import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/home/home.dart';

class Settings extends StatefulWidget {
  Settings();

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  final _auth = FirebaseAuth.instance;
  final Database db = Database();

  @override
  void initState() {
    super.initState();
    flutterIsShit();
  }

  void flutterIsShit() {
    Map<String, dynamic> myMap = db.getUser();
    print(myMap);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Welcome'),
            ElevatedButton(
              child: Text('Sign out'),
              onPressed: (){
                _auth.signOut();
                Navigator.pop(context, MaterialPageRoute(builder: (context) {
                  return Home();
                }));
              }
            ),
          ],
        ),
      ),
        
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) {
                return Home();
              }));
            },
            tooltip: 'Home',
            backgroundColor: Colors.green[200],
            child: Icon(Icons.map_outlined)),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 10.0,
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                // Navigationsknapp 1: Routes
                icon: Icon(Icons.place_outlined),
                iconSize: 35,
                onPressed: () {},
              ),
              IconButton(
                // Navigationsknapp 2: Events
                icon: Icon(Icons.calendar_today_outlined),
                iconSize: 35,
                onPressed: () {},
              ),
              Container(
                  child: Text("Home",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  width: 40,
                  height:
                      30), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
              IconButton(
                // Navigationsknapp 3: Info
                icon: Icon(Icons.info_outline),
                iconSize: 35,
                onPressed: () {},
              ),
              IconButton(
                // Navigationsknapp 4: Settings
                icon: Icon(Icons.settings_outlined),
                iconSize: 35,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Settings();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}