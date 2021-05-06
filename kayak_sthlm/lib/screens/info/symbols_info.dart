import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'information.dart';

class SymbolsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Symbols Info'),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Container(
            height: 200.0,
            width: 300.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: new Center(
                  child: new Text(
                    "This symbol represents areas that are meant for seals to live undisturbed from human life. Typically, this is at the time of year when seals have babies. These areas are forbidden for kayakers to enter with their boat.",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          Container(
            height: 200.0,
            width: 300.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: new Center(
                  child: new Text(
                    "This symbol represents areas that are meant to preserve a habitat important for birds. These areas are either areas that attract many birds or imortant for the endangered species. These areas are forbidden for kayakers to enter.",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationScreen()));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
