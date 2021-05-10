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


  Map<String, dynamic> mapData(){
    var myMap = Map<String, dynamic>.from(data);
    return myMap;
  }

  Map<String, dynamic> getUser() {
    _fetchUserInfo();
    if(data['age'] == 0){
      print('Havent fetched yet');
    }else{
      Map<String,dynamic> myMap = mapData();
      return myMap;
    }
    return null;
  }

  void _fetchUserInfo() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
          data['age'] = value['age'];
          data['email'] = value['email'];
          data['experience'] = value['experience'];
          data['gender'] = value['gender'];
          data['username'] = value['username'];
        });
  }
}