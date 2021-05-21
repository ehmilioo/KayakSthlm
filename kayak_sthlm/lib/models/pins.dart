import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class Pins {
  final double longitude;
  final double latitude;
  List<dynamic> finalList = [];

  Pins({
    @required this.longitude, 
    @required this.latitude
  });

  var rentalInfo = {
    'type': 'kayak',
    'color': 'pink',
  };

  var restaurantInfo = {
    'type': 'restaurant',
    'color': 'orange',
  };

  var restplaceInfo = {
    'type': 'restplace',
    'color': 'yellow',
  };


  Future<List<dynamic>> fetchAllPins() async{ 
    await getPins('hyra kajak', rentalInfo);
    await getPins('archipelago restaurant', restaurantInfo);
    await getPins('archipelago camping', restplaceInfo);
    return finalList;
  }


  Future<List<dynamic>> getPins(String keywords, Map<String, String> pinInfo) async{
    String _url = 'maps.googleapis.com';
    Map<String, String> _parameters = {
      'key': 'AIzaSyAQB7qDxdH_-5bpTA6IvQjlPru7fkOPqQY',
      'radius': '15000',
      'keyword': keywords,
      'location': '${this.latitude},${this.longitude}',
      'language': 'sv',

    };
    String _path = '/maps/api/place/nearbysearch/json';
    final response = await http.get(Uri.https(_url, _path, _parameters));
    if (response.statusCode == 200) {
      return rentalPinsToJson(jsonDecode(response.body), pinInfo);
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }
  

  List<dynamic> rentalPinsToJson(Map<String, dynamic> json, Map<String, String> pinInfo){
    Map<String, dynamic> mappedResult;
    List<dynamic> responseList = json['results'];
    for(var i = 0; i < responseList.length; i++){
      mappedResult = responseList[i];
      mappedResult.addAll(pinInfo);
      finalList.add(mappedResult);
    }
    return finalList;
  }
}