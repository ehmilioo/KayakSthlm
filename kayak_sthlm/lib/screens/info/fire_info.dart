import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


import 'information.dart';

class FireScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fire Info'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.push(
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

class FireInfo {
  String county;
  String countyCode;
  String municipality;
  String municipalityCode;
  String status;
  String startDate;
  String revisionDate;
  String description;
  String authority;
  String url;
  Map<String, dynamic> fireProhibition;

  FireInfo(Map<String, dynamic> map) {
    this.county = map['county'];
    this.countyCode = map['countyCode'];
    this.municipality = map['municipality'];
    this.municipalityCode = map['municipalityCode'];
    this.fireProhibition = map['fireProhibition'];
    this.status = fireProhibition['status'];
    this.startDate = fireProhibition['startDate'];
    this.revisionDate = fireProhibition['revisionDate'];
    this.description = fireProhibition['description'];
    this.authority = fireProhibition['authority'];
    this.url = fireProhibition['url'];
  }
}