import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kayak_sthlm/dialogs/reauth_dialog.dart';
import 'package:kayak_sthlm/screens/authenticate/sign_in.dart';
import 'package:kayak_sthlm/services/auth.dart';

class LogoutDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutDialog> {
  final AuthService _auth = AuthService();
  final User user = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser.uid;

  @override
  void initState() {
    super.initState();
  }

  void deleteUser() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users
          .doc(uid)
          .delete()
          .then((value) => print("User deleted"))
          .catchError((error) => print("Failed: $error"));
      await user.delete();
      print('Tog bort horungen');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(
              bottom: Constants.padding, top: Constants.padding),
          margin: EdgeInsets.fromLTRB(57, 169, 57, 169),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Material(
              color: Colors.white,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(214, 214, 214, 1)))),
                    alignment: Alignment.topCenter,
                    child: Text('ATTENTION',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            fontFamily: 'Montserrat'))),
                Container(
                    height: 275,
                    color: Colors.white,
                    //fromRGBO(212, 230, 251, 0.15),
                    child: Column(children: <Widget>[
                      SizedBox(height: 20),
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 250),
                          child: Text('Are you sure you want to log out?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 27,
                                  fontFamily: 'Montserrat'))),
                      SizedBox(height: 30),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(195, 48),
                              primary: Colors.white,
                              backgroundColor: Color.fromRGBO(143, 192, 245, 1),
                              shadowColor: Colors.black,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      SizedBox(height: 20),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(195, 48),
                              primary: Colors.white,
                              backgroundColor: Color.fromRGBO(248, 122, 130, 1),
                              shadowColor: Colors.black,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          child: Text('Log Out'),
                          onPressed: () {
                            _auth.signOut();
                            Navigator.of(context)
                                .popUntil((route) => route.isFirst);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          }),
                      SizedBox(height: 10)
                    ]))
              ])))
    ]));
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}