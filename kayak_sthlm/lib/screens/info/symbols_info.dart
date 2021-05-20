import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'information.dart';
import 'app_icons.dart';

class SymbolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 248, 255, 1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/bakgrund.png"),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Stack(children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 650,
                    width: 324,
                    padding: EdgeInsets.fromLTRB(25, 20, 25, 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 5),
                              blurRadius: 10),
                        ]),
                    child: Column(children: <Widget>[
                      Text(
                        "MAP SYMBOLS",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),

                      // Container(
                      //   padding: EdgeInsets.all(5),
                      //   margin: EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //     color: Colors.transparent,
                      //     borderRadius: BorderRadius.circular(10),
                      //     border: Border.all(
                      //       color: Colors.blueAccent,
                      //       width: 5,
                      //     ),
                      //   ),
                      //   child: Image(
                      //     image: AssetImage('assets/images/sealProtectionArea.png'),
                      //     height: 200,
                      //   ),
                      // ),
                      Container(
                        height: 266.0,
                        width: 322.0,
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            left: 15.0,
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromRGBO(255, 0, 0, 1)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0, 5),
                                    blurRadius: 10),
                              ],
                              color: Color.fromRGBO(255, 209, 46, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0))),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 64,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 5.0,
                                      top: 5.0,
                                      child: Icon(
                                        AppIcons.seal,
                                        color: Colors.black26,
                                        size: 60,
                                      ),
                                    ),
                                    Icon(
                                      AppIcons.seal,
                                      color: Colors.black,
                                      size: 60,
                                    ),
                                  ],
                                ),
                              ),
                              Text('Seal Protection Area',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 6),
                              Text(
                                "This symbol represents areas on the map that are meant for seals to live undisturbed from human life. Typically, this is at the time of year when seals have babies. These areas are forbidden for kayakers and humans in general to enter. ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      Container(
                        height: 266.0,
                        width: 322.0,
                        color: Colors.transparent,
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 15.0,
                            left: 15.0,
                            right: 15.0,
                            bottom: 15.0,
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromRGBO(255, 0, 0, 1)),
                              color: Color.fromRGBO(255, 209, 46, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    offset: Offset(0, 5),
                                    blurRadius: 10),
                              ]),
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 47,
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      left: 5.0,
                                      top: 5.0,
                                      child: Icon(
                                        AppIcons.bird,
                                        color: Colors.black26,
                                        size: 45,
                                      ),
                                    ),
                                    Icon(
                                      AppIcons.bird,
                                      color: Colors.black,
                                      size: 45,
                                    ),
                                  ],
                                ),
                              ),
                              Text('Bird Protection Area',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(height: 6),
                              Text(
                                "This symbol represents areas on the map that are meant for preservation of bird habitats. These areas are either areas important for endangered species or areas that attract many birds. These areas are forbidden for kayakers and humans in general to enter.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )),
              Positioned(
                  top: 26,
                  right: 6,
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
            ])));
  }
}
