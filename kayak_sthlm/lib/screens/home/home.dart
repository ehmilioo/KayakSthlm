import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:kayak_sthlm/dialogs/EventsInfo_dialog.dart';
import 'package:kayak_sthlm/dialogs/RoutesInfo_dialog.dart';
import 'package:kayak_sthlm/dialogs/eventsInfo_dialog.dart';
import 'package:kayak_sthlm/screens/authenticate/sign_in.dart';
import 'package:kayak_sthlm/screens/info/information.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayak_sthlm/dialogs/weather_dialog.dart';
import 'package:kayak_sthlm/dialogs/save_route_dialog.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => MapSampleState();
}

class MapSampleState extends State<Home> {
  final Database db = new Database();
  final Set<Polyline> _polyline = {};
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
  List<LatLng> routeCoords = [];
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
    } catch (e) {
      print(e);
    }
  }

  bool checkCoordsRadius(double cachedLon, double cachedLat) {
    //Prevent massive list of similar coords, make a radius of 3m
    if (cachedLon == null || cachedLat == null) {
      return false;
    }
    if (locationData.latitude > cachedLat + 0.00003 ||
        cachedLat - 0.00003 > locationData.latitude) {
      if (locationData.longitude > cachedLon + 0.00003 ||
          cachedLon - 0.00003 > locationData.longitude) {
        return false;
      }
    }
    return true;
  }

  void startRoute() {
    double cachedLon;
    double cachedLat;
    timer = Timer.periodic(
        Duration(seconds: 2),
        (Timer t) => {
              if (cachedLat == locationData.latitude &&
                  cachedLon == locationData.longitude)
                {print('duplicate')}
              else if (checkCoordsRadius(cachedLon, cachedLat))
                {print('Too close to latest coords')}
              else
                {
                  cachedLon = locationData.longitude,
                  cachedLat = locationData.latitude,
                  routeCoords.add(
                      LatLng(locationData.latitude, locationData.longitude)),
                  totalDistance += Geolocator.distanceBetween(
                      routeCoords[routeCoords.length - 2].latitude,
                      routeCoords[routeCoords.length - 2].longitude,
                      routeCoords[routeCoords.length - 1].latitude,
                      routeCoords[routeCoords.length - 1].longitude),
                  _polyline.add(Polyline(
                    polylineId: PolylineId('lat${locationData.latitude}'),
                    visible: true,
                    //latlng is List<LatLng>
                    points: routeCoords,
                    width: 3,
                    color: Colors.red,
                  )),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getCurrentLocation();
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          locationData == null
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                  ),
                )
              : GoogleMap(
                  mapType: MapType.hybrid,
                  zoomControlsEnabled: false,
                  polylines: _polyline,
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
            left: 10,
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
                constraints: BoxConstraints(minWidth: 80, minHeight: 80),
                elevation: 10.0,
                fillColor: Colors.white,
                child: Icon(
                  Icons.wb_sunny_outlined,
                  size: 50.0,
                ),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              ),
            ),
          ),
          Positioned(
              top: 140,
              left: 21.5,
              child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      getCurrentLocation();
                      _controller.animateCamera(CameraUpdate.newCameraPosition(
                          new CameraPosition(
                              bearing: locationData.heading,
                              target: LatLng(locationData.latitude,
                                  locationData.longitude),
                              zoom: 15.00)));
                    },
                    constraints: BoxConstraints(minWidth: 51, minHeight: 51),
                    elevation: 5.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.my_location_outlined,
                      size: 40.0,
                    ),
                    padding: EdgeInsets.all(8.0),
                    shape: CircleBorder(),
                  ))),
          Positioned(
              bottom: 7,
              left: 100,
              child: pausedRoute
                  ? Column(
                      children: [
                        Container(
                            height: 69.0,
                            width: 69.0,
                            child: FloatingActionButton(
                              elevation: 10,
                              child: Container(
                                  height: 69.0,
                                  width: 69.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: RadialGradient(colors: [
                                        Color.fromRGBO(139, 239, 123, 1),
                                        Colors.black
                                      ], stops: [
                                        0.44,
                                        1
                                      ], radius: 1)),
                                  child: Icon(Icons.play_arrow_outlined,
                                      size: 50)),
                              onPressed: () {
                                pausedRoute = !pausedRoute;
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.start);
                                startRoute();
                              },
                            )),
                        SizedBox(height: 4),
                        Container(
                            width: 79,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.0,
                                    offset: Offset(1, 1))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Text('RESUME',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))),
                      ],
                    )
                  : Container(height: 0, width: 0)),
          Positioned(
              bottom: 7,
              right: 100,
              child: pausedRoute
                  ? Column(
                      children: [
                        Container(
                            height: 69.0,
                            width: 69.0,
                            child: FloatingActionButton(
                                elevation: 10,
                                child: Container(
                                    height: 69.0,
                                    width: 69.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(colors: [
                                          Color.fromRGBO(248, 122, 130, 1),
                                          Colors.black
                                        ], stops: [
                                          0.44,
                                          1
                                        ], radius: 1)),
                                    child: Icon(Icons.stop_outlined, size: 50)),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => SaveRoute(
                                          routeList: routeCoords,
                                          distance: totalDistance,
                                          time: StopWatchTimer
                                              .getDisplayTimeSecond(
                                                  _stopWatchTimer.rawTime
                                                      .valueWrapper?.value)));
                                })),
                        SizedBox(height: 4),
                        Container(
                            width: 79,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 1.0,
                                    offset: Offset(1, 1))
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            child: Text('STOP',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))),
                      ],
                    )
                  : Container(height: 0, width: 0)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: locationData == null || pausedRoute
          ? null
          : Container(
              height: 80.0,
              width: 80.0,
              child: FloatingActionButton(
                  elevation: 10,
                  child: Container(
                      height: 80.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                              colors: isStarted
                                  ? [
                                      Color.fromRGBO(252, 216, 88, 1),
                                      Colors.black
                                    ]
                                  : [
                                      Color.fromRGBO(139, 239, 123, 1),
                                      Colors.black
                                    ],
                              stops: [0.44, 1],
                              radius: 1)),
                      child: isStarted
                          ? Icon(Icons.pause_outlined, size: 50)
                          : Icon(Icons.play_arrow_outlined, size: 50)),
                  onPressed: () {
                    if (isStarted) {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                      timer.cancel();
                      pausedRoute = !pausedRoute;
                    } else {
                      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                      isStarted = !isStarted;
                      LatLng firstPos =
                          LatLng(locationData.latitude, locationData.longitude);
                      routeCoords.add(firstPos);
                      startRoute();
                    }
                  })),
      bottomNavigationBar: locationData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            )
          : SizedBox(
              height: 80,
              child: BottomAppBar(
                child: isStarted
                    ? new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                            SizedBox(
                              width: 125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('DURATION',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  Container(
                                      child: StreamBuilder<int>(
                                          stream: _stopWatchTimer.rawTime,
                                          initialData: _stopWatchTimer
                                              .rawTime.valueWrapper?.value,
                                          builder: (context, snap) {
                                            final value = snap.data;
                                            final displayTime =
                                                StopWatchTimer.getDisplayTime(
                                                        value)
                                                    .substring(0, 8);
                                            return Container(
                                                child: Text(
                                              displayTime,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w700),
                                            ));
                                          }),
                                      width: 80,
                                      height: 30),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(bottom: 8),
                                alignment: Alignment.bottomCenter,
                                height: 50,
                                width: 52,
                                child: pausedRoute
                                    ? Text("PAUSED",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))
                                    : Text('PAUSE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600))),
                            SizedBox(
                              width: 125,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('DISTANCE (KM)',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)),
                                  Container(
                                      child: Text(
                                          (totalDistance / 1000).toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700)),
                                      width: 40,
                                      height: 30),
                                ],
                              ),
                            ),
                          ])
                    : new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                            // Navigationsknapp 1: Routes
                            icon: Icon(Icons.place_outlined),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (context, _, __) =>
                                      RoutesInfoDialog(),
                                  opaque: false,
                                  barrierColor: Colors.black.withOpacity(0.2)));
                            },
                          ),

                          IconButton(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                            // Navigationsknapp 2: Events
                            icon: Icon(Icons.calendar_today_outlined),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 8),
                            alignment: Alignment.bottomCenter,
                            height: 50,
                            width: 52,
                            child: Text("START",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12)),
                          ), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
                          IconButton(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                            // Navigationsknapp 3: Info
                            icon: Icon(Icons.info_outline),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InformationScreen()));
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                            // Navigationsknapp 4: Settings
                            icon: Icon(Icons.settings_outlined),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()));
                            },
                          ),
                        ],
                      ),
              ),
            ),
    );
  }

// List <Dialog> dialogs = <Dialog> [
//     RoutesInfoDialog(),
//     RoutesInfoDialog(),
//   ];

//   void recursiveShowDialog(int index) async {
//     if (index == 4) {
//         return;
//     }
//     await showDialog(
//       barrierDismissible: false,
//                                         context: context,
//                                         builder: (_) => dialogs[index]
//     );
//     recursiveShowDialog(index + 1);
// }
}
