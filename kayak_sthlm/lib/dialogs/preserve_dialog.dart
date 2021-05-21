import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:ui';

import 'package:kayak_sthlm/screens/info/mapForReserves.dart';

class PreserveDialog extends StatefulWidget {
  final RPA rpa;

  PreserveDialog({this.rpa});

  @override
  State<StatefulWidget> createState() => PreserveOverlayState();
}

class PreserveOverlayState extends State<PreserveDialog> {
  RPA rpa = PreserveDialog().rpa;
  getId() {
    return rpa.id;
  }

  getInfo() {
    return rpa.information;
  }

  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
        padding:
            EdgeInsets.only(bottom: Constants.padding, top: Constants.padding),
        margin: EdgeInsets.fromLTRB(50, 196, 50, 196),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Material(
          child: Column(
            children: <Widget>[Text(getInfo() + ' ' + getId())],
          ),
        ),
      ),
      Positioned(
          top: 168,
          right: 22,
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
