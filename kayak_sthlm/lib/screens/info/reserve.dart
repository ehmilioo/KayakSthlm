import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'information.dart';

class ReserveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map of Reserves'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
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
          )
        ],
      )),
    );
  }
}
