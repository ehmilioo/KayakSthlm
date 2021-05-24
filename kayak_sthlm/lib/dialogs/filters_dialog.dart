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

  var styleConfig = TextStyle(fontSize: 13, fontFamily: 'HammersmithOne');

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
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 20),
                    margin: EdgeInsets.only(top: 20),
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
                          icon: Icon(Icons.close_outlined),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'HammersmithOne'),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Kayak Rentals',
                                style: styleConfig, textAlign: TextAlign.left),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: getBool('kayak'),
                                onChanged: (bool value) {
                                  setState(() {
                                    setLocalBool('kayak', value);
                                  });
                                  widget.togglePins(getBool('kayak'), 'kayak');
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Restaurants',
                                style: styleConfig, textAlign: TextAlign.left),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
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
                                style: styleConfig, textAlign: TextAlign.left),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: getBool('mypin'),
                                onChanged: (bool value) {
                                  setState(() {
                                    setLocalBool('mypin', value);
                                  });
                                  widget.togglePins(getBool('mypin'), 'mypin');
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rest Places',
                                style: styleConfig, textAlign: TextAlign.left),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
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
                  ),
                ),
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
