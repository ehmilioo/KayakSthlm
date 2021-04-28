import 'package:kayak_sthlm/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _username = '';
  String _experience = '';
  String _gender = '';
  String _age = '';

  //Tappert försök till att kunna hämta den skapade profilen
  User getUser(){
    return FirebaseAuth.instance.currentUser;
  }


  //Kolla ifall det funkar, måste även ta bort all info från user tabell GDPR skit..
  void deleteAccount(uid){
    FirebaseAuth.instance.currentUser.delete();
  }

  //Skapa ett objekt för användare
  TheUser _userFromFirebase(User user){
    return user != null ? 
      TheUser(
        uid: user.uid,
        email: user.email,
        username: _username,
        experience: _experience,
        age : _age,
        gender: _gender,
      ) 
    : null;
  }

  //Auth change user stream
  Stream<TheUser> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  //Sign in with email&pass
  Future signInMail(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebase(user);
    } on PlatformException catch (err){
      print(err);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with email&pass
  Future registerMail(String email, String password, String username, String experience, String age, String gender) async {
    String _username = username;
    String _experience = experience;
    String _gender = gender;
    String _age = age;
    FirestoreService _firestoreAuth = FirestoreService();
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      user.updateProfile(displayName: username);
      await _firestoreAuth.createUser(TheUser(
          uid: user.uid,
          email: user.email,
          username: _username,
          experience: _experience,
          age: _age,
          gender: _gender,
          )); // Spara data i user tabell - firebase
      return _userFromFirebase(user);
    }
    catch (error) {
      switch (error.code) {       // ERROR HANDLA LOGIN-SKITEN SÅ MAN HITTAR PROBLEMET
        case "ERROR_INVALID_EMAIL":
          print("Your email address appears to be malformed.");
          break;
        case "ERROR_WRONG_PASSWORD":
          print("Your password is wrong.");

          break;
        case "ERROR_USER_NOT_FOUND":
          print("User with this email doesn't exist.");

          break;
        case "ERROR_USER_DISABLED":
          print("Your email address appears to be malformed.");

          break;
        case "ERROR_TOO_MANY_REQUESTS":
          print("Too many requests. Try again later.");

          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          print("Signing in with Email and Password is not enabled.");

          break;
        default:
          print("An undefined Error happened.");
      }
  }

  }

  //Sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }

}

class FirestoreService {
  final CollectionReference _usersCollectionReference = FirebaseFirestore.instance.collection("users");
  Future createUser(TheUser user) async {
    try {
      await _usersCollectionReference.doc(user.uid).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }
}