import 'package:flutter/material.dart';
import 'dart:async';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget  {
  @override
  State<Home> createState() => MapSampleState();
}

class MapSampleState extends State<Home> {

  Completer<GoogleMapController> _controller = Completer();

  final AuthService _auth = AuthService();
  final Database db = new Database();

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ResetPass();
    }));
  }

  void flutterIsShit() {
    db.getMap();
  }

  bool terrain = false;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  CameraPosition _userPos = CameraPosition(
    bearing: 300.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 19.151926040649414
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: GoogleMap(
        mapType: terrain ? MapType.hybrid : MapType.normal,
        zoomControlsEnabled: false,
        compassEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            onPressed: () {
              setState(() =>!terrain);
              print(terrain);
            },
            tooltip: 'Start',
            backgroundColor: Colors.green[200],
            child: Icon(Icons.play_arrow_outlined)),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: new Row(
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
                      style: TextStyle(fontWeight: FontWeight.bold)),
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_userPos));
  }
}
