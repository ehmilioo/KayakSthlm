import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kayak_sthlm/screens/info/fire_info.dart';
import 'information.dart';
import 'dart:convert';

//Så kan man skriva över deras värde när vi får till en getUserLocation att funka tänker jag.
String lat = '59.377990';
String long = '18.037960';

Future<FireInfo> fetchFireInfo(String lat, String long) async {
  var response = await http.get(Uri.https(
      'api.msb.se', ('/brandrisk/v2/FireProhibition/' + lat + '/' + long)));

  if (response.statusCode == 200) {
    return FireInfo(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load fire info');
  }
}

class _FireScreenState extends State<FireScreen> {
  Future<FireInfo> getFireInfo;

  @override
  void initState() {
    super.initState();

    // Koordinaterna till området vi vill ha eldningsförbuds info från i latitude/longitude
    getFireInfo = fetchFireInfo(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Info'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          FutureBuilder<FireInfo>(
            future: getFireInfo,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data.county != null) {
                return Text(
                    snapshot.data.county + " har " + snapshot.data.status);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationScreen()));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class FireScreen extends StatefulWidget {
  FireScreen({Key key}) : super(key: key);

  @override
  _FireScreenState createState() => _FireScreenState();
}
