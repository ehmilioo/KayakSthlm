import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kayak_sthlm/screens/info/fire_info.dart';
import 'information.dart';
import 'dart:convert';

class Kommuner {
  final String name;
  final String latitude;
  final String longitude;

  const Kommuner(this.name, this.latitude, this.longitude);
}

Future<FireInfo> fetchFireInfo(String lat, String long) async {
  var response = await http
      .get(Uri.https(
          'api.msb.se', ('/brandrisk/v2/FireProhibition/' + lat + '/' + long)))
      .catchError((e) {
    print(e);
  });

  if (response.statusCode == 200) {
    return FireInfo(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load fire info');
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class _FireScreenState extends State<FireScreen> {
  Future<FireInfo> getFireInfo;
  FireInfo fireInfo;
  Kommuner selectedKommun;
  Position position;
  final Geolocator geolocator = Geolocator();

  _getCurrentLocation() async {
    position = await _determinePosition();

    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        getFireInfo = fetchFireInfo(
            position.latitude.toString(), position.longitude.toString());
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Kommuner> kommuner = <Kommuner>[
      const Kommuner('Botkyrka', '59.2', '17.833333'),
      const Kommuner('Danderyd', '59.4', '18.083333'),
      const Kommuner('Ekerö', '59.35', '17.683333'),
      const Kommuner('Haninge', '59.166667', '18.133333'),
      const Kommuner('Huddinge', '59.233333', '17.983333'),
      const Kommuner('Järfälla', '59.433333', '17.833333'),
      const Kommuner('Lidingö', '59.366667', '18.183333'),
      const Kommuner('Nacka', '59.31', '18.163889'),
      const Kommuner('Norrtälje', '59.766667', '18.7'),
      const Kommuner('Nykvarn', '59.183333', '17.4'),
      const Kommuner('Nynäshamn', '58.933333', '17.883333'),
      const Kommuner('Salem', '59.233333', '17.683333'),
      const Kommuner('Sigtuna', '59.633333', '17.883333'),
      const Kommuner('Sollentuna', '59.45', '17.916667'),
      const Kommuner('Solna', '59.366667', '18.016667'),
      const Kommuner('Stockholm', '59.35', '18.066667'),
      const Kommuner('Sundbyberg', '59.363333', '17.965556'),
      const Kommuner('Södertälje', '59.1', '17.516667'),
      const Kommuner('Tyresö', '59.233333', '18.216667'),
      const Kommuner('Täby', '59.4439', '18.06872'),
      const Kommuner('Upplands-Bro', '59.533333', '17.666667'),
      const Kommuner('Upplands Väsby', '59.516667', '17.9'),
      const Kommuner('Vallentuna', '59.583333', '18.2'),
      const Kommuner('Vaxholm', '59.4', '18.283333'),
      const Kommuner('Värmdö', '59.316667', '18.566667'),
      const Kommuner('Österåker', '59.5', '18.45'),
    ];

    _getCurrentLocation();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Info'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Text(
            "FIRE BANS",
            textScaleFactor: 3,
          ),
          SizedBox(
            height: 20,
          ),
          Text("Status"),
          Container(
            height: 120.0,
            width: 300.0,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                top: 15.0,
                left: 15.0,
                right: 15.0,
                bottom: 15.0,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                children: [
                  DropdownButton<Kommuner>(
                    hint: Text("Välj Kommun"),
                    value: selectedKommun,
                    onChanged: (Kommuner kommun) {
                      setState(() {
                        selectedKommun = kommun;
                        getFireInfo =
                            fetchFireInfo(kommun.latitude, kommun.longitude);
                      });
                    },
                    items: kommuner.map((Kommuner kommun) {
                      return DropdownMenuItem<Kommuner>(
                        value: kommun,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              kommun.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  FutureBuilder<FireInfo>(
                    future: getFireInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.county != null) {
                        return Text(snapshot.data.county +
                            " har " +
                            snapshot.data.status);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Start Date"),
          Container(
            height: 120,
            width: 300,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                FutureBuilder<FireInfo>(
                    future: getFireInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data.startDate != null) {
                        return Text(snapshot.data.startDate);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    }),
              ]),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Description"),
          Container(
            height: 120,
            width: 300,
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(children: [
                FutureBuilder<FireInfo>(
                    future: getFireInfo,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.description != null) {
                        return Text(snapshot.data.description);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return CircularProgressIndicator();
                    }),
              ]),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: 50,
          child: ElevatedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => InformationScreen()));
            },
          ),
        ),
      ),
    );
  }
}

class FireScreen extends StatefulWidget {
  FireScreen({Key key}) : super(key: key);

  @override
  _FireScreenState createState() => _FireScreenState();
}
