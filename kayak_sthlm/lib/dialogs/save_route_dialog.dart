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
    return Card(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20, top: 120, right: 20, bottom: 20),
            margin: EdgeInsets.only(top: 45),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Name your route:',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'HammersmithOne'),
                ),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                    child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'HammersmithOne', fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Route name",
                          contentPadding: EdgeInsets.only(top: 20),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(136, 134, 134, 1)),
                        ),
                        onChanged: (val) {
                          routeName = val;
                        })),
                SizedBox(
                  height: 22,
                ),
                Center(
                  child: Row(
                    children: [
                      Text('Make Favorite',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'HammersmithOne')),
                      IconButton(
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
                ),
                SizedBox(
                  height: 22,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: Color.fromRGBO(86, 151, 211, 1),
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black54,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        textStyle: TextStyle(
                            color: Colors.green[400],
                            fontSize: 18,
                            fontFamily: 'HammersmithOne'),
                      ),
                      child: Text('Save Route'),
                      onPressed: () async {
                        var mappedRouteList = widget.routeList.map((coord) {
                          return {
                            "lat": coord.latitude,
                            "lon": coord.longitude
                          };
                        }).toList();
                        try {
                          await _firestoreAuth.createUser(MyRoute(
                            name: routeName,
                            favorite: favoriteRoute,
                            coordinates: mappedRouteList,
                            date: date,
                            timeTaken: widget.time,
                            distance: widget.distance.toString(),
                            userUid: uid,
                          ));
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pop(context);
                      }),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: Color.fromRGBO(86, 151, 211, 1),
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black54,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        textStyle: TextStyle(
                            color: Colors.green[400],
                            fontSize: 18,
                            fontFamily: 'HammersmithOne'),
                      ),
                      child: Text('Cancel'),
                      onPressed: () async {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
