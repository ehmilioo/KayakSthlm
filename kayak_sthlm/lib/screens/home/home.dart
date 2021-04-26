import 'package:flutter/material.dart';
import 'package:kayak_sthlm/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //dynamic name = _auth.getUser().displayName;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Hemskärmen'),
        backgroundColor: Colors.red[600],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(onPressed: () async {await _auth.signOut();},style: ElevatedButton.styleFrom(primary: Colors.deepOrange[600]), icon: Icon(Icons.lock_open), label: Text('Logga ut'))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Welcome ', style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}