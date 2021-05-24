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
  @override
  void initState() {
    super.initState();
  }

  String pinName = '';
  String pinDesc = '';

  @override
  Widget build(BuildContext context) {
    FirestoreService _firestoreAuth = FirestoreService();

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
                IconButton(
                  color: Color.fromRGBO(136, 134, 134, 1),
                  icon: Icon(Icons.close_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text('Create New Pin'),
                SizedBox(height: 22),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                    child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'HammersmithOne', fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Name your pin",
                          contentPadding: EdgeInsets.only(top: 20),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(136, 134, 134, 1)),
                        ),
                        onChanged: (val) {
                          pinName = val;
                        })),
                SizedBox(height: 22),
                ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 82, minHeight: 82),
                    child: TextFormField(
                        style: TextStyle(
                            fontFamily: 'HammersmithOne', fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Description",
                          contentPadding: EdgeInsets.only(top: 20),
                          labelStyle: TextStyle(
                              color: Color.fromRGBO(136, 134, 134, 1)),
                        ),
                        onChanged: (val) {
                          pinDesc = val;
                        })),
                SizedBox(height: 22),
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
                      child: Text('Save Pin'),
                      onPressed: () async {
                        try {
                          await _firestoreAuth.createUser(CustomPin(
                            name: pinName,
                            desc: pinDesc,
                            lat: widget.lat,
                            lng: widget.lng,
                          ));
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pop(context, true);
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
      FirebaseFirestore.instance.collection("pins");
  Future createUser(CustomPin pin) async {
    try {
      await _usersCollectionReference.doc().set(pin.toJson());
    } catch (e) {
      return e.message;
    }
  }
}
