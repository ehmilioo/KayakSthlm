import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid = FirebaseAuth.instance.currentUser.uid;

  void deleteUser(){
    print('lol');
  }

  void saveUserSettings(){
    print('saved user');
  }

  void changePassword(){
    print('changed password');
  }

  Future<void> updateUser(String username, String age, String experience, String gender) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
  return users
    .doc(uid)
    .update({'age': age, 'username': username, 'experience': experience, 'gender': gender})
    .then((value) => print("User updated"))
    .catchError((error) => print("Failed to update user's property: $error"));
}


}