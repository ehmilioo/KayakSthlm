import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

class PreserveDialog extends StatefulWidget {
  final String name;
  final String info;
  final String size;

  PreserveDialog(
      {@required this.name, @required this.info, @required this.size});

  @override
  State<StatefulWidget> createState() => PreserveOverlayState();
}

class PreserveOverlayState extends State<PreserveDialog> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          height: 200,
          padding: EdgeInsets.all(Constants.padding),
          margin: EdgeInsets.fromLTRB(37, 120, 37, 100),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Material(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 90,
                      child: Text(widget.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.black))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: Text(widget.info,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                        SizedBox(height: 20),
                        Container(
                            child: Text(widget.size,
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                      ],
                    ),
                  )
                ],
              ))),
      Positioned(
          top: 92,
          right: 8,
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
