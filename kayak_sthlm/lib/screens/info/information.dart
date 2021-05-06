import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';
import 'package:kayak_sthlm/screens/info/fire_info.dart';
import 'package:kayak_sthlm/screens/info/guides.dart';
import 'package:kayak_sthlm/screens/info/reserve.dart';
import 'package:kayak_sthlm/screens/info/symbols_info.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/services/database.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Information'),
        ),
        body: SafeArea(
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.place_outlined),
                iconSize: 35,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GuideScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                iconSize: 35,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ReserveScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                iconSize: 35,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FireScreen()));
                },
              ),
              IconButton(
                icon: Icon(Icons.settings_outlined),
                iconSize: 35,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SymbolsScreen()));
                },
              ),
            ],
          ),
        ));
  }
}
