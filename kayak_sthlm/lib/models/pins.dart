import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pins {
  final double longitude;
  final double latitude;
  List<dynamic> finalList = [];

  Pins({@required this.longitude, @required this.latitude});

  var rentalInfo = {
    'type': 'Kayak Rental',
    'path': 'pins/bluepin.png',
  };

  var restaurantInfo = {
    'type': 'Restaurant',
    'path': 'pins/pinkpin.png',
  };

  var restplaceInfo = {
    'type': 'Rest Place',
    'path': 'pins/greenpin.png',
  };

  var mypinInfo = {
    'type': 'Custom Pin',
    'path': 'pins/yellowpin.png',
  };

  var protectedInfo = {
    'type': 'protected',
    'path': 'pins/birdpin.png',
  };

  Future<List<dynamic>> fetchAllPins() async {
    await getPins('hyra kajak', rentalInfo);
    await getPins('archipelago restaurant', restaurantInfo);
    await getPins('archipelago camping', restplaceInfo);
    await getCustomPins(mypinInfo);
    await readProtectedPins();
    return finalList;
  }

  Future<List<dynamic>> reloadCustomPins() async {
    for (var i = 0; i < finalList.length; i++) {
      if (finalList[i]['type'] == 'Custom Pin') {
        finalList.removeAt(i);
      }
    }
    await getCustomPins(mypinInfo);
    return finalList;
  }

  Future<void> readProtectedPins() async {
    final String response =
        await rootBundle.loadString('assets/restrictedAreas.json');
    final data = await json.decode(response);
    data.forEach((item) {
      item.addAll(protectedInfo);
      finalList.add(item);
    });
  }

  Future<List<dynamic>> getPins(
      String keywords, Map<String, String> pinInfo) async {
    String _url = 'maps.googleapis.com';
    Map<String, String> _parameters = {
      'key':
          'AIzaSyAQB7qDxdH_-5bpTA6IvQjlPru7fkOPqQY', //Denna ska egentligen gömmas med dotenv..
      'radius': '15000',
      'keyword': keywords,
      'location': '${this.latitude},${this.longitude}',
      'language': 'sv',
    };
    String _path = '/maps/api/place/nearbysearch/json';
    final response = await http.get(Uri.https(_url, _path, _parameters));
    if (response.statusCode == 200) {
      return pinsToJson(jsonDecode(response.body), pinInfo);
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }

  Future<void> getCustomPins(Map<String, String> pinInfo) async {
    Map<String, dynamic> firestoreResult;
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("pins").get();
    snap.docs.forEach((element) {
      firestoreResult = element.data();
      firestoreResult.addAll(pinInfo);
      finalList.add(firestoreResult);
    });
  }

  List<dynamic> pinsToJson(
      Map<String, dynamic> json, Map<String, String> pinInfo) {
    Map<String, dynamic> mappedResult;
    List<dynamic> responseList = json['results'];
    for (var i = 0; i < responseList.length; i++) {
      mappedResult = responseList[i];
      mappedResult.addAll(pinInfo);
      finalList.add(mappedResult);
    }
    return finalList;
  }
}
