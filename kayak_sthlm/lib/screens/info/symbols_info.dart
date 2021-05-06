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
            height: 150.0,
            width: 300.0,
            color: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: new Center(
                  child: new Text(
                    "Rounded Corner Rectangle Shape",
                    style: TextStyle(color: Colors.white, fontSize: 22),
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
