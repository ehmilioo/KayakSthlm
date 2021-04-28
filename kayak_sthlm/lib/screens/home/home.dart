import 'package:flutter/material.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();


  void openPage(BuildContext context) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) {
        return ResetPass();
      })
    );
  }


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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: FloatingActionButton(
          onPressed: () {
            openPage(context);
          },
          tooltip: 'Start',
          child: Icon(Icons.play_arrow)
        ),
      ),
        
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
              IconButton(
                icon: Icon(Icons.wb_sunny_outlined),
                iconSize: 30,
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.person_outline_outlined),
                iconSize: 30,
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.sticky_note_2_outlined),
                iconSize: 30,
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.settings),
                iconSize: 30,
                onPressed: (){},
              ),
          ],
        ),
      ),
    );
  }
}