import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kayak_sthlm/dialogs/reauth_dialog.dart';
import 'package:kayak_sthlm/dialogs/confirmation_dialog.dart';

class DeleteUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteUser();
}

class _DeleteUser extends State<DeleteUser> {
  final User user = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  void initState() {
    super.initState();
  }

  void deleteUser() async{
    try{
      CollectionReference users = FirebaseFirestore.instance.collection('users');
        users.doc(uid)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed: $error"));
      await user.delete();
    }catch(e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                child: Column(
                  children: <Widget>[
                    Text('Are you sure you want to delete your account?'),
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed:(){
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text("Delete Account", style: TextStyle(color : Colors.red)),
                      onPressed:(){
                        showDialog(
                          context: context,
                          builder: (_) => AuthDialog(),
                        ).then((val) =>{
                          deleteUser(),
                          showDialog(
                            context: this.context,
                            builder: (_) => Confirmation(message: 'Your account has been deleted', color: false)
                          ).then((val) =>{
                            Navigator.of(context).popUntil((route) => route.isFirst)
                          })
                        });
                        
                      },
                    )
                  ],
                ),
              ),
    );
  }
}

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}