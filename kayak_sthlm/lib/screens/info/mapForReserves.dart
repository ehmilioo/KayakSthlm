import 'dart:collection';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'information.dart';
import 'package:url_launcher/url_launcher.dart';


class WildlifePreserves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildlife Preserves',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  //bound limits
  static final sthlmNE = LatLng(60.380987, 19.644660);
  static final sthlmSW = LatLng(58.653765, 17.205695);
  static final extraCorner = LatLng(60, 18);
  static final natureReserves = 3;
  LatLng pinPosition = LatLng(59.33879, 18.08487);

  //adding custom pins for nature reserved areas
  BitmapDescriptor pinLocation;
  List<Marker> _markers = <Marker>[];
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<RPA> rpas = HashSet<RPA>();

  @override
  void initState() {
    super.initState();
    dataBasePrep();
  }

  void dataBasePrep() {
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs = List<LatLng>();
    // ignore: deprecated_member_use
    List<LatLng> polygonLatLngs1 = List<LatLng>();
    polygonLatLngs.add(sthlmNE);
    polygonLatLngs.add(sthlmSW);
    polygonLatLngs.add(extraCorner);
    var rpa = RPA('Skogås','Ett vackert naturreservat! /n Notes:  /n Protected since: ', 60.380987, 19.644660, polygonLatLngs);
    rpas.add(rpa);
    _setPolygon(rpa);
    LatLng point1 = LatLng(61, 19);
    LatLng point2 = LatLng(65, 19);
    LatLng point3 = LatLng(67, 19);
    LatLng point4 = LatLng(67, 20);
    LatLng point5 = LatLng(67, 19);
    LatLng point6 = LatLng(67, 19.644660);
    LatLng point7 = LatLng(67, 18);
    polygonLatLngs1.add(point1);
    polygonLatLngs1.add(point2);
    polygonLatLngs1.add(point3);
    polygonLatLngs1.add(point4);
    polygonLatLngs1.add(point5);
    polygonLatLngs1.add(point6);
    polygonLatLngs1.add(point7);
    var rpa1 = RPA('Alingssås','Ett vackert naturreservat! /n Notes:  /n Protected since: ', 67, 18, polygonLatLngs1);
    rpas.add(rpa1);
    _setPolygon(rpa1);
  }

  void _setPolygon(RPA rpa) {
    //var rpa = RPA('Skogås','Ett vackert naturreservat! /n Notes:  /n Protected since: ', 60.380987, 19.644660);
      final String polygonIdVal = 'polygon_id_$rpa.id';
      _polygons.add(Polygon(
        polygonId: PolygonId(polygonIdVal),
        points: rpa.polygonLatLngs,
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.redAccent.withOpacity(0.15),
      ));
    _markers.add(
      Marker(
          markerId: MarkerId(rpa.id),
          position: LatLng(rpa.lat, rpa.long),
          infoWindow: InfoWindow(
              title: rpa.id,
            snippet: rpa.information,
          )
      )
    );
  }

  static final CameraPosition _startPosition = CameraPosition(
    target: LatLng(59.33879, 18.08487),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return new Container(
          child: Column(
        children: <Widget>[
            AppBar(
              title: Text('Wildlife Preserves'),
      ),
             SizedBox(
               width: MediaQuery.of(context).size.width, // or use fixed size like 200
               height: 500,
                 child: GoogleMap(
              zoomControlsEnabled: true,
              mapToolbarEnabled: false,
              compassEnabled: false,
              initialCameraPosition: _startPosition,
              mapType: MapType.hybrid,
              markers: Set<Marker>.of(_markers),
              polygons: _polygons,
        cameraTargetBounds: new CameraTargetBounds(
        new LatLngBounds(
        northeast: sthlmNE,
        southwest: sthlmSW,
            ),
          ),
        ),
        ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: ElevatedButton(
            child: Text('Rules'),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReserveRulesScreen()));
            },
          ),
        ),
          ElevatedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  //ändra till informationScreen
                  MaterialPageRoute(builder: (context) => InformationScreen()));
            },
          ),
     ]),
    );
  }
}

class RPA {

  // ignore: deprecated_member_use
  List<LatLng> polygonLatLngs = List<LatLng>();
  String id;
  LatLng latLng;
  String information;
  LatLng markerSpot;
  double lat;
  double long;

  RPA(this.id, this.information, this.lat, this.long, this.polygonLatLngs);

  bool operator ==(o) => o is RPA && o.id == id && o.information == information;

  @override
  int get hashCode => id.hashCode*information.hashCode+1;

}

class ReserveRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules when in nature'),
      ),
      body: Center(
          child: ListView(
            children: <Widget>[
              Text("Avoid plants and trees. You are not allowed to pick up protected plants; such as orchids." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Avoid bird nests and their children. Do not hurt or pick up snakes, reptiles and frogs nor other animals." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Avoid bird and seal sanctuaries when access to those areas is prohibited." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Your dog needs to be tethered at all time when in nature." + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("Do not start a fire. It is also forbidden to put disposable grills in the garbage due to the fire risk!" + "\n",
                  style: TextStyle(fontSize: 20)),
              Text("In Sweden there is a right, allemansrätten, or in english 'right of public access', that says you are allowed to spend time in nature, even when it belongs to landowners, however, you do need to be responsible and not disturb anyone while doing so. \n",
                  style: TextStyle(fontSize: 20)),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: 'For more information, please see Naturvårdsverket site.',
                      style: new TextStyle(color: Colors.blue),
                      recognizer: new TapGestureRecognizer()..onTap = () { launch('https://www.naturvardsverket.se/Var-natur/Allemansratten/Det-har-galler/');
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => WildlifePreserves()));
                },
              ),
            ],
          )),
    );
  }
}