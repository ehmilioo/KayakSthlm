import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Filters extends StatefulWidget {
  final Function togglePins;
  final Function toggleAllPins;
  Filters({
    @required this.togglePins,
    @required this.toggleAllPins,
  });

  @override
  State<StatefulWidget> createState() => _Filters();
}

class _Filters extends State<Filters> {
  bool showKayak;
  bool showRestaurant;
  bool showMyPins;
  bool showRestplace;
  bool showAll;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initBool();
  }

  Future<bool> initBool() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  void setLocalBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool getBool(String type) {
    return prefs.getBool(type);
  }

  var styleConfig = TextStyle(
      fontSize: 17, fontFamily: 'Montserrat', fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initBool(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 22,
                  right: 22,
                  child: Container(
                    height: 283,
                    width: 219,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 3),
                              blurRadius: 5),
                        ]),
                    child: Material(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Filters',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Montserrat'),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 22,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/pins/bluepin.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text('Kayak Rentals',
                                              style: styleConfig,
                                              textAlign: TextAlign.left),
                                        ),
                                        Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            activeColor: Color.fromRGBO(
                                                143, 192, 245, 1),
                                            value: getBool('Kayak Rental'),
                                            onChanged: (bool value) {
                                              setState(() {
                                                setLocalBool(
                                                    'Kayak Rental', value);
                                              });
                                              widget.togglePins(
                                                  getBool('Kayak Rental'),
                                                  'Kayak Rental');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/pins/pinkpin.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text('Restaurants',
                                              style: styleConfig,
                                              textAlign: TextAlign.left),
                                        ),
                                        Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            activeColor: Color.fromRGBO(
                                                143, 192, 245, 1),
                                            value: getBool('Restaurant'),
                                            onChanged: (bool value) {
                                              setState(() {
                                                setLocalBool(
                                                    'Restaurant', value);
                                              });
                                              widget.togglePins(
                                                  getBool('Restaurant'),
                                                  'Restaurant');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/pins/yellowpin.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text('Custom Pins',
                                              style: styleConfig,
                                              textAlign: TextAlign.left),
                                        ),
                                        Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            activeColor: Color.fromRGBO(
                                                143, 192, 245, 1),
                                            value: getBool('Custom Pin'),
                                            onChanged: (bool value) {
                                              setState(() {
                                                setLocalBool(
                                                    'Custom Pin', value);
                                              });
                                              widget.togglePins(
                                                  getBool('Custom Pin'),
                                                  'Custom Pin');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/pins/greenpin.png',
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text('Rest Places',
                                              style: styleConfig,
                                              textAlign: TextAlign.left),
                                        ),
                                        Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            activeColor: Color.fromRGBO(
                                                143, 192, 245, 1),
                                            value: getBool('Rest Place'),
                                            onChanged: (bool value) {
                                              setState(() {
                                                setLocalBool(
                                                    'Rest Place', value);
                                              });
                                              widget.togglePins(
                                                  getBool('Rest Place'),
                                                  'Rest Place');
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      minimumSize: Size(172, 35),
                                      primary: Colors.black,
                                      backgroundColor:
                                          Color.fromRGBO(212, 230, 251, 1),
                                      shadowColor: Colors.black,
                                      elevation: 10,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w400)),
                                  onPressed: () {
                                    bool allPinsBool = getBool('allpins');
                                    setState(() {
                                      setLocalBool(
                                          'Kayak Rental', !allPinsBool);
                                      setLocalBool('Restaurant', !allPinsBool);
                                      setLocalBool('Custom Pin', !allPinsBool);
                                      setLocalBool('Rest Place', !allPinsBool);
                                      setLocalBool('allpins', !allPinsBool);
                                    });
                                    widget.toggleAllPins(allPinsBool);
                                  },
                                  child: Text('Hide/Show All'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Card(
                          elevation: 20,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 18.0,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        )))
              ],
            ),
          );
        } else {
          return CircularProgressIndicator(
            backgroundColor: Colors.blue,
          );
        }
      },
    );
  }
}
