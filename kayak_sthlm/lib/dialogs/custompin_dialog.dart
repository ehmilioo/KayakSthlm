import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/models/custompin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomPinDialog extends StatefulWidget {
  final double lat;
  final double lng;
  CustomPinDialog({
    @required this.lat,
    @required this.lng,
  });

  @override
  State<StatefulWidget> createState() => _CustomPinDialog();
}

class _CustomPinDialog extends State<CustomPinDialog> {
  String username = '';
  String pinName = '';
  String pinDesc = '';
  String uid = FirebaseAuth.instance.currentUser.uid;
  FirestoreService _firestoreAuth = FirestoreService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.only(
                      bottom: Constants.padding, top: Constants.padding),
                  margin: EdgeInsets.fromLTRB(57, 169, 57, 169),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Constants.padding),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 5),
                            blurRadius: 10),
                      ]),
                  child: Material(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: Color.fromRGBO(
                                              214, 214, 214, 1)))),
                              alignment: Alignment.topCenter,
                              child: Text('CREATE NEW PIN',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25,
                                      fontFamily: 'Montserrat'))),
                          SizedBox(height: 20),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 51),
                              height: 184,
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 10),
                                    Text(
                                      'Name your pin:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 55, minHeight: 55),
                                        child: TextFormField(
                                            style: TextStyle(fontSize: 16),
                                            decoration: InputDecoration(
                                              hintText: "Name",
                                              contentPadding:
                                                  EdgeInsets.only(top: 20),
                                              labelStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      136, 134, 134, 1)),
                                            ),
                                            onChanged: (val) {
                                              pinName = val;
                                            })),
                                    SizedBox(height: 10),
                                    Text(
                                      'Add a description:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxHeight: 55, minHeight: 55),
                                        child: TextField(
                                            style: TextStyle(fontSize: 16),
                                            decoration: InputDecoration(
                                              hintText: "Description",
                                              contentPadding:
                                                  EdgeInsets.only(top: 20),
                                              labelStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      136, 134, 134, 1)),
                                            ),
                                            onChanged: (val) {
                                              pinDesc = val;
                                            })),
                                  ])),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  minimumSize: Size(195, 48),
                                  primary: Colors.white,
                                  backgroundColor:
                                      Color.fromRGBO(139, 239, 123, 1),
                                  shadowColor: Colors.black,
                                  elevation: 10,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              child: Text('Save Pin'),
                              onPressed: () async {
                                try {
                                  await _firestoreAuth.createUser(CustomPin(
                                    username: snapshot.data['username'],
                                    name: pinName,
                                    desc: pinDesc,
                                    lat: widget.lat,
                                    lng: widget.lng,
                                  ));
                                } catch (e) {
                                  print(e);
                                }
                                Navigator.pop(context, true);
                              })
                        ],
                      )));
            } else {
              return CircularProgressIndicator();
            }
          }),
      Positioned(
          top: 142,
          right: 28,
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Card(
                elevation: 20,
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              )))
    ]));
  }
}

//     return Card(
//       color: Colors.transparent,
//       child: Stack(
//         children: <Widget>[
//           StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('users')
//                   .doc(uid)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Container(
//                     padding: EdgeInsets.only(
//                         left: 20, top: 120, right: 20, bottom: 20),
//                     margin: EdgeInsets.only(top: 45),
//                     decoration: BoxDecoration(
//                         shape: BoxShape.rectangle,
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.black,
//                               offset: Offset(0, 10),
//                               blurRadius: 10),
//                         ]),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         IconButton(
//                           color: Color.fromRGBO(136, 134, 134, 1),
//                           icon: Icon(Icons.close_outlined),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         Text('Create New Pin'),
//                         SizedBox(height: 22),
//                         ConstrainedBox(
//                             constraints:
//                                 BoxConstraints(maxHeight: 82, minHeight: 82),
//                             child: TextFormField(
//                                 style: TextStyle(
//                                     fontFamily: 'HammersmithOne', fontSize: 18),
//                                 decoration: InputDecoration(
//                                   hintText: "Name your pin",
//                                   contentPadding: EdgeInsets.only(top: 20),
//                                   labelStyle: TextStyle(
//                                       color: Color.fromRGBO(136, 134, 134, 1)),
//                                 ),
//                                 onChanged: (val) {
//                                   pinName = val;
//                                 })),
//                         SizedBox(height: 22),
//                         ConstrainedBox(
//                             constraints:
//                                 BoxConstraints(maxHeight: 82, minHeight: 82),
//                             child: TextFormField(
//                                 style: TextStyle(
//                                     fontFamily: 'HammersmithOne', fontSize: 18),
//                                 decoration: InputDecoration(
//                                   hintText: "Description",
//                                   contentPadding: EdgeInsets.only(top: 20),
//                                   labelStyle: TextStyle(
//                                       color: Color.fromRGBO(136, 134, 134, 1)),
//                                 ),
//                                 onChanged: (val) {
//                                   pinDesc = val;
//                                 })),
//                         SizedBox(height: 22),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 minimumSize: Size(281, 48),
//                                 primary: Color.fromRGBO(86, 151, 211, 1),
//                                 backgroundColor: Colors.white,
//                                 shadowColor: Colors.black54,
//                                 elevation: 10,
//                                 shape: const RoundedRectangleBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(20))),
//                                 textStyle: TextStyle(
//                                     color: Colors.green[400],
//                                     fontSize: 18,
//                                     fontFamily: 'HammersmithOne'),
//                               ),
//                               child: Text('Save Pin'),
//                               onPressed: () async {
//                                 try {
//                                   await _firestoreAuth.createUser(CustomPin(
//                                     username: snapshot.data['username'],
//                                     name: pinName,
//                                     desc: pinDesc,
//                                     lat: widget.lat,
//                                     lng: widget.lng,
//                                   ));
//                                 } catch (e) {
//                                   print(e);
//                                 }
//                                 Navigator.pop(context, true);
//                               }),
//                         ),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return CircularProgressIndicator();
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("pins");
  Future createUser(CustomPin pin) async {
    try {
      await _usersCollectionReference.doc().set(pin.toJson());
    } catch (e) {
      return e.message;
    }
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
