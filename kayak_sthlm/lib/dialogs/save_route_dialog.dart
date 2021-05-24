import 'package:flutter/material.dart';
import 'package:kayak_sthlm/models/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class SaveRoute extends StatefulWidget {
  final List<dynamic> routeList;
  final double distance;
  final dynamic time;
  SaveRoute({
    @required this.routeList,
    @required this.distance,
    @required this.time,
  });

  @override
  State<StatefulWidget> createState() => _SaveRoute();
}

class _SaveRoute extends State<SaveRoute> {
  FirestoreService _firestoreAuth = FirestoreService();
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  void initState() {
    super.initState();
  }

  String routeName = '';
  bool favoriteRoute = false;
  String date = DateFormat('EEEE dd MMMM yyyy')
      .format(DateTime.now()); // Tuesday 18 May 2021 -- Dag-Datum-Månad-År

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
                    child: Text('SAVE ROUTE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                            fontFamily: 'Montserrat'))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 51),
                    height: 275,
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Name your route:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 55, minHeight: 55),
                          child: TextFormField(
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: "Route name",
                                contentPadding: EdgeInsets.only(top: 20),
                                labelStyle: TextStyle(
                                    color: Color.fromRGBO(136, 134, 134, 1)),
                              ),
                              onChanged: (val) {
                                routeName = val;
                              })),
                      Row(
                        children: [
                          Text('Make Favorite',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              )),
                          IconButton(
                            alignment: Alignment.center,
                            constraints:
                                BoxConstraints(maxWidth: 36, maxHeight: 36),
                            icon: favoriteRoute
                                ? Icon(Icons.star_rate_rounded,
                                    color: Colors.yellow[700])
                                : Icon(Icons.star_border_rounded,
                                    color: Colors.black),
                            onPressed: () {
                              setState(() => {favoriteRoute = !favoriteRoute});
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
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
                          child: Text('Save Route'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      SizedBox(height: 20),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(195, 48),
                              primary: Color.fromRGBO(250, 70, 81, 1),
                              backgroundColor: Colors.white,
                              shadowColor: Colors.black,
                              elevation: 10,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          child: Text('Cancel'),
                          onPressed: () async {
                            Navigator.pop(context, false);
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

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("routes");
  Future createUser(MyRoute route) async {
    try {
      await _usersCollectionReference.doc().set(route.toJson());
    } catch (e) {
      return e.message;
    }
  }
}
