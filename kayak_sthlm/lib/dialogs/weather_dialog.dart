import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class WeatherDialog extends StatefulWidget {
  final double longitude;
  final double latitude;

  WeatherDialog({@required this.longitude, @required this.latitude});

  @override
  State<StatefulWidget> createState() => WeatherOverlayState();
}

class WeatherOverlayState extends State<WeatherDialog> {
  Future<Weather> currentWeather;
  List _types = [];
  @override
  void initState() {
    super.initState();
    currentWeather = fetchWeather();
    readJson();
  }

  Future<Weather> fetchWeather() async {
    String userLongitude = widget.longitude.toStringAsFixed(6).toString();
    String userLatitude = widget.latitude.toStringAsFixed(6).toString();
    String url = "opendata-download-metfcst.smhi.se";
    final response = await http.get(Uri.https(url,
        '/api/category/pmp3g/version/2/geotype/point/lon/$userLongitude/lat/$userLatitude/data.json'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/weatherType.json');
    final data = await json.decode(response);
    setState(() => {_types = data['types']});
  }

  Map<String, dynamic> getWeatherTypeInfo(int index) {
    if (_types != null) {
      return _types[index];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: currentWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> response = getWeatherTypeInfo(
              snapshot.data.timeSeries[0]['parameters'][18]['values'][0] -
                  1); //-1 eftersom SMHI API börjar på 1 och listor på 0 :-)
          return Container(
              child: Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  bottom: Constants.padding, top: Constants.padding),
              margin: EdgeInsets.fromLTRB(63, 196, 63, 196),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Material(
                child: Stack(
                  children: <Widget>[
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(214, 214, 214, 1)))),
                          alignment: Alignment.center,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text('Stockholm',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                        fontFamily: 'Montserrat')),
                                Text('Today',
                                    style: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        fontFamily: 'Montserrat')),
                                SizedBox(height: 7)
                              ])),
                      Container(
                          height: 151,
                          color: Color.fromRGBO(212, 230, 251, 0.4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${snapshot.data.timeSeries[0]['parameters'][10]['level']}',
                                      style: TextStyle(fontSize: 72)),
                                  Text('°C', style: TextStyle(fontSize: 24)),
                                ],
                              ),
                              SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.cloud, size: 40),
                                  Icon(Icons.waves_outlined, size: 40),
                                  Icon(Icons.wb_cloudy_outlined, size: 40)
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${response['desc']}',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 13,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                        TextSpan(
                                            text: 'Wind: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                '${snapshot.data.timeSeries[0]['parameters'][14]['level']} m/s')
                                      ])),
                                  RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 13,
                                              color: Colors.black),
                                          children: <TextSpan>[
                                        TextSpan(
                                            text: 'Rain: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text:
                                                '${snapshot.data.timeSeries[0]['parameters'][0]['level']}%')
                                      ])),
                                ],
                              )
                            ],
                          )),
                      Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  top: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromRGBO(214, 214, 214, 1)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('grader',
                                      style: TextStyle(fontSize: 12)),
                                  Icon(Icons.wb_sunny, size: 45),
                                  Text('tid', style: TextStyle(fontSize: 14))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('grader',
                                      style: TextStyle(fontSize: 12)),
                                  Icon(Icons.wb_sunny, size: 45),
                                  Text('tid', style: TextStyle(fontSize: 14))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('grader',
                                      style: TextStyle(fontSize: 12)),
                                  Icon(Icons.wb_sunny, size: 45),
                                  Text('tid', style: TextStyle(fontSize: 14))
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('grader',
                                      style: TextStyle(fontSize: 12)),
                                  Icon(Icons.wb_sunny, size: 45),
                                  Text('tid', style: TextStyle(fontSize: 14))
                                ],
                              )
                            ],
                          )),
                      // Text(
                      //   'Temp: ${snapshot.data.timeSeries[0]['parameters'][10]['level']} °C',
                      //   style: TextStyle(
                      //       fontSize: 22, fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   'Wind: ${snapshot.data.timeSeries[0]['parameters'][14]['level']} m/s',
                      //   style: TextStyle(
                      //       fontSize: 22, fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   'Weather type: ${response['desc']}',
                      //   style: TextStyle(
                      //       fontSize: 22, fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 15,
                      // ),
                      // Text(
                      //   'Rain: ${snapshot.data.timeSeries[0]['parameters'][0]['level']}%',
                      //   style: TextStyle(
                      //       fontSize: 22, fontWeight: FontWeight.w600),
                      // ),
                      // SizedBox(
                      //   height: 22,
                      // )
                    ]),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 168,
                right: 35,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Card(
                      elevation: 20,
                      shape: CircleBorder(),
                      child: CircleAvatar(
                        radius: 24.0,
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    )))
          ]));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}

//ToDo
//Lista för alla föremål
//['parameter'] för att hämta datan om föremålet
//  child: Text(snapshot.data.timeSeries[0]['parameters'][10]['name']),
//  https://opendata.smhi.se/apidocs/metfcst/parameters.html
//  timeSeries[0]['parameters'][10]['name']
//  Lista    Timme            Format Värde

class Weather {
  final List timeSeries;

  Weather({@required this.timeSeries});

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<dynamic> responseList;
    List<dynamic> weatherList = [];
    responseList = json['timeSeries'];
    weatherList.addAll(responseList.getRange(1, 8));
    return Weather(
      timeSeries: weatherList,
    );
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
