import 'package:flutter/material.dart';
import 'package:kayak_sthlm/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    print(_auth.getUser());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.red[600],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(onPressed: () async {await _auth.signOut();},style: ElevatedButton.styleFrom(primary: Colors.deepOrange[600]), icon: Icon(Icons.lock_open), label: Text('Logga ut'))
        ],
      )
    );
  }
}