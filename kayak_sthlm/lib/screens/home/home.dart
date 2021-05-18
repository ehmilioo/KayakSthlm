import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayak_sthlm/dialogs/weather_dialog.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => MapSampleState();
}

class MapSampleState extends State<Home> {
  final Database db = new Database();
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  StreamSubscription _locationSubscription;
  GoogleMapController _controller;
  LocationData locationData;
  CameraPosition currentPosition;
  bool isStarted = false;
  bool pausedRoute = false;
  Timer timer;
  List<dynamic> routeCoords = [];
  double totalDistance = 0;

  static final sthlmNE = LatLng(60.380987, 19.644660);
  static final sthlmSW = LatLng(58.653765, 17.205695);
  static final CameraPosition _startPosition = CameraPosition(
    target: LatLng(59.33879, 18.08487),
    zoom: 14.4746,
  );
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/arrow_final.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    if (this.mounted) {
      this.setState(() {
        marker = Marker(
            markerId: MarkerId("user"),
            position: latlng,
            rotation: newLocalData.heading,
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(imageData));
        circle = Circle(
            circleId: CircleId("radius"),
            radius: newLocalData.accuracy + 100,
            zIndex: 1,
            strokeColor: Colors.blue,
            center: latlng,
            fillColor: Colors.blue.withAlpha(70));
      });
    }
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged().listen((newLocalData) {
        locationData = newLocalData;
        if (_controller != null) {
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENID') {
        debugPrint('Permission Denied');
      }
    } catch(e){
      print(e);
    }
  }
  

  bool checkCoordsRadius(double cachedLon, double cachedLat){
    if(cachedLon == null || cachedLat == null){
      return false;
    }
    if(locationData.latitude > cachedLat+0.00003 || cachedLat-0.00003 > locationData.latitude){
      if(locationData.longitude > cachedLon+0.00003 || cachedLon-0.00003 > locationData.longitude){
        return false;
      }
    }
    return true;
  }


  void startRoute(){
    double cachedLon;
    double cachedLat;
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => {
      if(cachedLat == locationData.latitude && cachedLon == locationData.longitude){
        print('duplicate')
      }else if(checkCoordsRadius(cachedLon, cachedLat)){
        print('Too close to latest coords')
      }else{
        cachedLon = locationData.longitude,
        cachedLat = locationData.latitude,
        routeCoords.add({
          'lat': locationData.latitude,
          'lon': locationData.longitude,
        }),
        totalDistance += Geolocator.distanceBetween(routeCoords[routeCoords.length-2]["lat"], routeCoords[routeCoords.length-2]["lon"], routeCoords[routeCoords.length-1]["lat"], routeCoords[routeCoords.length-1]["lon"]),
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return new Scaffold(
      body: locationData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : Stack(
              children: <Widget>[                 
                GoogleMap(
                  mapType: MapType.hybrid,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  onLongPress: (latlang) {
                        print('Markerad pos: ${latlang}'); //Jobba vidare på detta?
                    },
                  initialCameraPosition: _startPosition,
                  markers: Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    _controller.animateCamera(CameraUpdate.newCameraPosition(
                        new CameraPosition(
                            bearing: locationData.heading,
                            target: LatLng(
                                locationData.latitude, locationData.longitude),
                            zoom: 15.00)));
                  },
                  cameraTargetBounds: new CameraTargetBounds(
                    new LatLngBounds(
                      northeast: sthlmNE,
                      southwest: sthlmSW,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => WeatherDialog(
                              longitude: locationData.longitude,
                              latitude: locationData.latitude),
                        );
                      },
                      elevation: 5.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.wb_cloudy_rounded,
                        size: 35.0,
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: RawMaterialButton(
                      onPressed: () {
                        getCurrentLocation();
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(new CameraPosition(
                                bearing: locationData.heading,
                                target: LatLng(locationData.latitude,
                                    locationData.longitude),
                                zoom: 15.00)));
                      },
                      elevation: 5.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.location_searching,
                        size: 35.0,
                      ),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: locationData == null || pausedRoute
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      if (isStarted) {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        timer.cancel();
                        pausedRoute = !pausedRoute;
                      } else {
                        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        isStarted = !isStarted;
                        dynamic firstPos = {
                          'lat' : locationData.latitude,
                          'lon' : locationData.longitude,
                        };
                        routeCoords.add(firstPos);
                        startRoute();
                      }
                    });
                  },
                  tooltip: 'Start',
                  backgroundColor:
                      isStarted ? Colors.yellow[700] : Colors.green[200],
                  child: isStarted
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow_outlined)),
            ),
      bottomNavigationBar: locationData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : SizedBox(
              height: 60,
              child: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 10.0,
                child: isStarted
                    ? new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                            Container(
                                child: Text((totalDistance/1000).toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                width: 40,
                                height: 30),
                            Container(
                                child: Text("Pause",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                width: 40,
                                height: 30),
                            Container(
                                child: StreamBuilder<int>(
                                    stream: _stopWatchTimer.rawTime,
                                    initialData: _stopWatchTimer
                                        .rawTime.valueWrapper?.value,
                                    builder: (context, snap) {
                                      final value = snap.data;
                                      final displayTime =
                                          StopWatchTimer.getDisplayTime(value)
                                              .substring(0, 8);
                                      return Container(
                                          child: Text(
                                        displayTime,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'Helvetica',
                                            fontWeight: FontWeight.bold),
                                      ));
                                    }),
                                width: 80,
                                height: 30),
                          ])
                    : new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            // Navigationsknapp 1: Routes
                            icon: Icon(Icons.place_outlined),
                            iconSize: 35,
                            onPressed: () {},
                          ),
                          IconButton(
                            // Navigationsknapp 2: Events
                            icon: Icon(Icons.calendar_today_outlined),
                            iconSize: 35,
                            onPressed: () {},
                          ),
                          Container(
                              child: Text("Start",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              width: 32,
                              height:
                                  30), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
                          IconButton(
                            // Navigationsknapp 3: Info
                            icon: Icon(Icons.info_outline),
                            iconSize: 35,
                            onPressed: () {},
                          ),
                          IconButton(
                            // Navigationsknapp 4: Settings
                            icon: Icon(Icons.settings_outlined),
                            iconSize: 35,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Settings();
                              }));
                            },
                          ),
                        ],
                      ),
              ),
            ),
    );
  }
}
