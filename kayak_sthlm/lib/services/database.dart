import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid = FirebaseAuth.instance.currentUser.uid;
  var test;

  var data = {
    'age': 0,
    'email': '',
    'experience': '',
    'gender': '',
    'username': ''
  };


  Map<String, dynamic> getUser(){
    getUser();
    var myMap = Map<String, dynamic>.from(data);
    return myMap;
  }

  void getMap() async {
    final user = await _fetchUserInfo();
    print(data);
  }

  void _fetchUserInfo() async {
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    data['age'] = snapshot['age'];
    data['email'] = snapshot['email'];
    data['experience'] = snapshot['experience'];
    data['gender'] = snapshot['gender'];
    data['username'] = snapshot['username'];
  }
  //toDO
  //Fetch user table
  //Fetch fetch events table
  //Write & update tables
}