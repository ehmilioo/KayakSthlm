import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

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
    final response = await http.get(Uri.https(url, '/api/category/pmp3g/version/2/geotype/point/lon/$userLongitude/lat/$userLatitude/data.json'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }

  

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await DefaultAssetBundle.of(context).loadString('assets/weatherType.json');
    final data = await json.decode(response);
    setState(() => {
      _types = data['types']
    });
  }

  Map<String, dynamic> getWeatherTypeInfo(int index){
    if(_types != null){
      return _types[index];
    }else{
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather>(
      future: currentWeather,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> response = getWeatherTypeInfo(snapshot.data.timeSeries[0]['parameters'][18]['values'][0]-1); //-1 eftersom SMHI API börjar på 1 och listor på 0 :-)
          return Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: Constants.padding,top: 120, right: Constants.padding,bottom: Constants.padding
                ),
                margin: EdgeInsets.only(top: Constants.avatarRadius),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(color: Colors.black,offset: Offset(0,10),
                    blurRadius: 10
                    ),
                  ]
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Temp: ${snapshot.data.timeSeries[0]['parameters'][10]['level']} °C',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text('Wind: ${snapshot.data.timeSeries[0]['parameters'][14]['level']} m/s',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text('Weather type: ${response['desc']}',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text('Rain: ${snapshot.data.timeSeries[0]['parameters'][0]['level']}%',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
                    SizedBox(height: 22,),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                          child: Text('Close',style: TextStyle(fontSize: 18),)),
                    ),
                  ],
                ),
              ),
            ],
          );
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

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}