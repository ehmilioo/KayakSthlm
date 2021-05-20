import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';


class Pins {
  final double longitude;
  final double latitude;

  Pins({
    @required this.longitude, 
    @required this.latitude
  });


  Future<List<dynamic>> fetchAllPins() async{
    return await getRentalPins();
  }


  Future<List<dynamic>> getRentalPins() async{
    String _url = 'maps.googleapis.com';
    Map<String, String> _parameters = {
      'key': 'AIzaSyAQB7qDxdH_-5bpTA6IvQjlPru7fkOPqQY',
      'radius': '10000',
      'keyword': 'hyra kajak',
      'location': '${this.latitude},${this.longitude}',
      'language': 'sv',

    };
    String _path = '/maps/api/place/nearbysearch/json';
    final response = await http.get(Uri.https(_url, _path, _parameters));
    if (response.statusCode == 200) {
      return rentalPinsToJson(jsonDecode(response.body));
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }

  List<dynamic> rentalPinsToJson(Map<String, dynamic> json){
    var pinInfo = {
      'type': 'rental',
      'color': 'BitmapDescriptor.hueCyan',
    };
    List<dynamic> responseList = json['results'];
    responseList.add(pinInfo);
    return responseList;
  }
}