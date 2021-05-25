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

  var styleConfig = TextStyle(fontSize: 17, fontFamily: 'Montserrat');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initBool(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Card(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  child: Container(
                    height: 310,
                    width: 219,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                    child: Column(
                      children: [
                        Text(
                          'Filters',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat'),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 22,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  'assets/pins/bluepin.png',
                                  height: 20,
                                  width: 20,
                                ),
                                Text('Kayak Rentals',
                                    style: styleConfig,
                                    textAlign: TextAlign.left),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    activeColor:
                                        Color.fromRGBO(143, 192, 245, 1),
                                    value: getBool('kayak'),
                                    onChanged: (bool value) {
                                      setState(() {
                                        setLocalBool('kayak', value);
                                      });
                                      widget.togglePins(
                                          getBool('kayak'), 'kayak');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Restaurants',
                                    style: styleConfig,
                                    textAlign: TextAlign.left),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    activeColor:
                                        Color.fromRGBO(143, 192, 245, 1),
                                    value: getBool('restaurant'),
                                    onChanged: (bool value) {
                                      setState(() {
                                        setLocalBool('restaurant', value);
                                      });
                                      widget.togglePins(
                                          getBool('restaurant'), 'restaurant');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Custom Pins',
                                    style: styleConfig,
                                    textAlign: TextAlign.left),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    activeColor:
                                        Color.fromRGBO(143, 192, 245, 1),
                                    value: getBool('mypin'),
                                    onChanged: (bool value) {
                                      setState(() {
                                        setLocalBool('mypin', value);
                                      });
                                      widget.togglePins(
                                          getBool('mypin'), 'mypin');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Rest Places',
                                    style: styleConfig,
                                    textAlign: TextAlign.left),
                                Transform.scale(
                                  scale: 0.5,
                                  child: CupertinoSwitch(
                                    activeColor:
                                        Color.fromRGBO(143, 192, 245, 1),
                                    value: getBool('restplace'),
                                    onChanged: (bool value) {
                                      setState(() {
                                        setLocalBool('restplace', value);
                                      });
                                      widget.togglePins(
                                          getBool('restplace'), 'restplace');
                                    },
                                  ),
                                ),
                              ],
                            ),
                            RaisedButton(
                              elevation: 5.0,
                              child: Text('Hide/Show All'),
                              onPressed: () {
                                bool allPinsBool = getBool('allpins');
                                setState(() {
                                  setLocalBool('kayak', !allPinsBool);
                                  setLocalBool('restaurant', !allPinsBool);
                                  setLocalBool('mypin', !allPinsBool);
                                  setLocalBool('restplace', !allPinsBool);
                                  setLocalBool('allpins', !allPinsBool);
                                });
                                widget.toggleAllPins(allPinsBool);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 50,
                    right: 22,
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
