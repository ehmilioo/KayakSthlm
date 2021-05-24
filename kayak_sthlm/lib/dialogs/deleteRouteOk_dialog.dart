import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kayak_sthlm/dialogs/reauth_dialog.dart';
import 'package:kayak_sthlm/screens/authenticate/sign_in.dart';

class DeleteRouteOkDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DeleteRouteOkOverlayState();
}

class DeleteRouteOkOverlayState extends State<DeleteRouteOkDialog> {
  @override
  void initState() {
    super.initState();
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
                    child: Text('CONFIRMATION',
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
                    child: Column(children: <Widget>[
                      SizedBox(height: 25),
                      ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 220),
                          child: Text('Your route has been deleted',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(239, 14, 14, 1),
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 27,
                                  fontFamily: 'Montserrat'))),
                      SizedBox(height: 80),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(195, 48),
                              primary: Color.fromRGBO(86, 151, 211, 1),
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              textStyle: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600)),
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
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