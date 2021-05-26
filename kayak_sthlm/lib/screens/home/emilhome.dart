import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kayak_sthlm/dialogs/weather_dialog.dart';
import 'package:kayak_sthlm/dialogs/save_route_dialog.dart';
import 'package:kayak_sthlm/dialogs/filters_dialog.dart';
import 'package:kayak_sthlm/dialogs/confirmation_dialog.dart';
import 'package:kayak_sthlm/dialogs/custompin_dialog.dart';
import 'package:kayak_sthlm/dialogs/pininfo_dialog.dart';
import 'package:kayak_sthlm/dialogs/protected_dialog.dart';
import 'package:kayak_sthlm/dialogs/attention_dialog.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';
import 'package:kayak_sthlm/models/pins.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => MapSampleState();
}

class MapSampleState extends State<Home> {
  final Database db = new Database();
  final Set<Polyline> _polyline = {};
  List<LatLng> routeCoords = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  List<dynamic> pinList;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  StreamSubscription _locationSubscription;
  GoogleMapController _controller;
  LocationData locationData;
  CameraPosition currentPosition;
  bool isStarted = false;
  bool pausedRoute = false;
  bool stoppedRoute = false;
  Timer timer;
  double totalDistance = 0;
  LatLng firstPos;

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
    setFilterBool();
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

  //Sets all filters to true when building the home widget.
  void setFilterBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('kayak', true);
    await prefs.setBool('restaurant', true);
    await prefs.setBool('mypin', true);
    await prefs.setBool('restplace', true);
    await prefs.setBool('allpins', true);
  }

  Future<Uint8List> getMarker(String imagePath) async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/${imagePath}");
    return byteData.buffer.asUint8List();
  }

  Future<void> fetchList() async {
    Pins _pins = Pins(
        latitude: locationData.latitude, longitude: locationData.longitude);
    pinList = await _pins.fetchAllPins();
  }

  Future<void> reloadCustomPins() async {
    pinList.clear();
    Pins _pins = Pins(
        latitude: locationData.latitude, longitude: locationData.longitude);
    pinList = await _pins.reloadCustomPins();
  }

  void loadMarkersOfType(String type, bool reload) async {
    if (reload) {
      await reloadCustomPins();
    }

    for (var i = 0; i < pinList.length; i++) {
      if (pinList[i]['type'] == type) {
        if (pinList[i]['type'] == 'mypin' ||
            pinList[i]['type'] == 'protected') {
          createCustomMarker(pinList[i]);
        } else {
          createMarker(pinList[i]);
        }
      }
    }
  }

  void loadAllMarkers(bool firstFetch) async {
    if (firstFetch) {
      await fetchList();
    }
    for (var i = 0; i < pinList.length; i++) {
      if (pinList[i]['type'] == 'mypin' || pinList[i]['type'] == 'protected') {
        createCustomMarker(pinList[i]);
      } else {
        createMarker(pinList[i]);
      }
    }
  }

  void createCustomMarker(Map<String, dynamic> item) async {
    MarkerId markerId = MarkerId(item['name']);
    LatLng pinLocation = LatLng(item['lat'], item['lng']);
    Uint8List imageData = await getMarker(item['path']);
    Marker marker = Marker(
      markerId: markerId,
      position: pinLocation,
      draggable: false,
      onTap: () {
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: locationData.heading,
                target: LatLng(pinLocation.latitude, pinLocation.longitude),
                zoom: 15.00)));
        if (item['type'] == 'protected') {
          showDialog(
              context: this.context,
              builder: (_) => ProtectedPinInfo(item: item));
        } else {
          showDialog(
              context: this.context, builder: (_) => PinInfo(item: item));
        }
      },
      zIndex: 2,
      icon: BitmapDescriptor.fromBytes(imageData),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void createMarker(Map<String, dynamic> item) async {
    MarkerId markerId = MarkerId(item['place_id']);
    LatLng pinLocation = LatLng(item['geometry']['location']['lat'],
        item['geometry']['location']['lng']);
    Uint8List imageData = await getMarker(item['path']);
    Marker marker = Marker(
      markerId: markerId,
      position: pinLocation,
      draggable: false,
      onTap: () {
        _controller.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                bearing: locationData.heading,
                target: LatLng(pinLocation.latitude, pinLocation.longitude),
                zoom: 15.00)));
        showDialog(context: this.context, builder: (_) => PinInfo(item: item));
      },
      zIndex: 2,
      icon: BitmapDescriptor.fromBytes(imageData),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  void toggleAllPins(bool toggled) {
    if (toggled) {
      setState(() {
        markers = {};
      });
    } else {
      loadAllMarkers(false);
    }
  }

  void togglePins(bool toggled, String pinType) {
    if (toggled) {
      loadMarkersOfType(pinType, false);
    } else {
      for (int i = 0; i < pinList.length; i++) {
        if (pinList[i]['type'] == pinType) {
          if (pinList[i]['type'] == 'mypin' ||
              pinList[i]['type'] == 'protected') {
            markers.remove(MarkerId(pinList[i]['name']));
          } else {
            markers.remove(MarkerId(pinList[i]['place_id']));
          }
        }
      }
    }
  }

  void updateMarkerAndCircle(
      LocationData newLocalData, Uint8List imageData) async {
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
        markers[marker.markerId] = marker;
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
      Uint8List imageData = await getMarker('arrow_final.png');
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
                    points: routeCoords,
                    width: 3,
                    color: Colors.red,
                  )),
                }
            });
  }

  void finishRoute() {
    isStarted = !isStarted;
    pausedRoute = !pausedRoute;
    _polyline.clear();
    routeCoords.clear();
    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    totalDistance = 0;
    print('Cleared cache');
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
                  polylines: _polyline,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  onLongPress: (latlang) {
                    showDialog(
                            context: this.context,
                            builder: (_) => CustomPinDialog(
                                lat: latlang.latitude, lng: latlang.longitude))
                        .then((value) => loadMarkersOfType('mypin', true));
                  },
                  initialCameraPosition: _startPosition,
                  markers: Set<Marker>.of(markers
                      .values), //Set.of((marker != null) ? [marker] : []),
                  circles: Set.of((circle != null) ? [circle] : []),
                  onMapCreated: (GoogleMapController controller) {
                    loadAllMarkers(true);
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
                  right: 5,
                  child: stoppedRoute
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: RawMaterialButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => Filters(
                                    togglePins: togglePins,
                                    toggleAllPins: toggleAllPins),
                              );
                            },
                            elevation: 5.0,
                            fillColor: Colors.white,
                            child: Icon(
                              Icons.filter_alt_outlined,
                              size: 35.0,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ),
                ),
                Positioned(
                  top: 40,
                  child: stoppedRoute
                      ? Container()
                      : Padding(
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
                Positioned(
                  child: stoppedRoute
                      ? Container(
                          constraints: BoxConstraints(
                            minHeight: double.infinity,
                            minWidth: double.infinity,
                          ),
                          color: Colors.transparent,
                          width: 150,
                          height: 150,
                        )
                      : Container(height: 0, width: 0),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: stoppedRoute
                      ? Stack(
                          children: [
                            Container(
                              height: 200,
                              width: 400,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Text('Route Stopped'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text('Duration: '),
                                          Text(StopWatchTimer.getDisplayTime(
                                                  _stopWatchTimer.rawTime
                                                      .valueWrapper?.value)
                                              .substring(0, 8)),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text('Distance (KM)'),
                                          Text(totalDistance.toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: () {
                                          pausedRoute = !pausedRoute;
                                          stoppedRoute = !stoppedRoute;
                                          _stopWatchTimer.onExecute
                                              .add(StopWatchExecute.start);
                                          startRoute();
                                        },
                                        elevation: 5.0,
                                        fillColor: Colors.green[200],
                                        child: Icon(
                                          Icons.play_arrow,
                                          size: 35.0,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        shape: CircleBorder(),
                                      ),
                                      RawMaterialButton(
                                        onPressed: () async {
                                          bool savedRoute = await showDialog(
                                            context: this.context,
                                            builder: (_) => SaveRoute(
                                                routeList: routeCoords,
                                                distance: totalDistance,
                                                time: StopWatchTimer
                                                    .getDisplayTimeSecond(
                                                        _stopWatchTimer
                                                            .rawTime
                                                            .valueWrapper
                                                            ?.value)),
                                          );
                                          if (savedRoute) {
                                            finishRoute();
                                            showDialog(
                                                context: this.context,
                                                builder: (_) => Confirmation(
                                                    message:
                                                        'Your route has been saved',
                                                    color: true));
                                            stoppedRoute = !stoppedRoute;
                                          }
                                        },
                                        elevation: 5.0,
                                        fillColor: Colors.blue[200],
                                        child: Icon(
                                          Icons.save_alt_sharp,
                                          size: 35.0,
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        shape: CircleBorder(),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () async {
                                      final result = await showDialog(
                                          context: this.context,
                                          builder: (_) => AttentionDialog(
                                                message:
                                                    'Are you sure you want to delete route?',
                                              ));
                                      if (result) {
                                        stoppedRoute = !stoppedRoute;
                                        finishRoute();
                                      } else {
                                        print('Canceled deletion');
                                      }
                                    },
                                    child: Text('Delete Route',
                                        style: TextStyle(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.underline)),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container(height: 0, width: 0),
                ),
                Positioned(
                  bottom: 20,
                  left: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: stoppedRoute
                        ? null
                        : pausedRoute
                            ? RawMaterialButton(
                                onPressed: () {
                                  pausedRoute = !pausedRoute;
                                  _stopWatchTimer.onExecute
                                      .add(StopWatchExecute.start);
                                  startRoute();
                                },
                                elevation: 5.0,
                                fillColor: Colors.green[200],
                                child: Icon(
                                  Icons.play_arrow,
                                  size: 35.0,
                                ),
                                padding: EdgeInsets.all(10.0),
                                shape: CircleBorder(),
                              )
                            : null,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: stoppedRoute
                        ? null
                        : pausedRoute
                            ? RawMaterialButton(
                                onPressed: () async {
                                  stoppedRoute = !stoppedRoute;
                                  _controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          new CameraPosition(
                                              bearing: 0,
                                              target: LatLng(firstPos.latitude,
                                                  firstPos.longitude),
                                              zoom: 13.00)));
                                },
                                elevation: 5.0,
                                fillColor: Colors.red[400],
                                child: Icon(
                                  Icons.stop_rounded,
                                  size: 35.0,
                                ),
                                padding: EdgeInsets.all(10.0),
                                shape: CircleBorder(),
                              )
                            : null,
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
                        firstPos = LatLng(
                            locationData.latitude, locationData.longitude);
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
          : stoppedRoute
              ? null
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
                                    child: Text(
                                        (totalDistance / 1000).toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    width: 40,
                                    height: 30),
                                Container(
                                    child: pausedRoute
                                        ? Text("Paused",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        : Text('Pause',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                    width: 45,
                                    height: 30),
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
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
