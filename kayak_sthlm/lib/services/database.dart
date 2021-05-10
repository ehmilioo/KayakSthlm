import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  String uid = FirebaseAuth.instance.currentUser.uid;
  final _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;

  var data = {
    'age': 0,
    'email': '',
    'experience': '',
    'gender': '',
    'username': ''
  };

//Gör färdigt dessa auth samt usertable

  void deleteUser(String pw) async{
    try{
      String email = data['email'];
      String password = pw;
      EmailAuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      var result = await _user.reauthenticateWithCredential(credential);
      await result.user.delete();
      print('auth user deleted');

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .delete();
      print('tog bort dokument');
      _auth.signOut();
      print('loggade ut');
    }
    catch(e){
      print(e);
    }
  }

  void saveUserSettings(){
    print('saved user');
  }

  void changePassword(){
    print('changed password');
  }


  Map<String, dynamic> mapData(){
    var myMap = Map<String, dynamic>.from(data);
    return myMap;
  }

  Map<String, dynamic> getUser() {
    _fetchUserInfo();
    while(data == null){
      Map<String,dynamic> myMap = mapData();
      return myMap;
    }
    return data;
  }

  Future<void> _fetchUserInfo() async {
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