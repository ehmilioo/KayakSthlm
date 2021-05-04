import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherDialog extends StatefulWidget {
  final double longitude;
  final double latitude;

  WeatherDialog({
    @required this.longitude, 
    @required this.latitude
  });

  @override
  State<StatefulWidget> createState() => WeatherOverlayState();
}

class WeatherOverlayState extends State<WeatherDialog> {
  Future<Weather> currentWeather;

  @override
  void initState() {
    super.initState();
    currentWeather = fetchWeather();
  }

  Future<Weather> fetchWeather() async {
    String userLongitude = widget.longitude.toStringAsFixed(6).toString();
    String userLatitude = widget.latitude.toStringAsFixed(6).toString();
    String url = "opendata-download-metfcst.smhi.se";
    final response = await http.get(Uri.https(url, '/api/category/pmp3g/version/2/geotype/point/lon/$userLongitude/lat/$userLatitude/data.json'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: currentWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.timeSeries[0].toString());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
 
//ToDo
//Serializea JSON string korrekt


class Weather {
  final List timeSeries;

  Weather({@required this.timeSeries});

  factory Weather.fromJson(Map<String, dynamic> json) {
    List<dynamic> responseList;
    List<dynamic> weatherList = []; 
    responseList = json['timeSeries'];
    weatherList.addAll(responseList.getRange(0, 8));
    return Weather(
      timeSeries: weatherList,
    );
  }
}