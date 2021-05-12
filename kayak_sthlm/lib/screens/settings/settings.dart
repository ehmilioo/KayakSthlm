import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/settings/settings_edit.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/screens/settings/delete_user.dart';
import 'package:kayak_sthlm/screens/settings/change_pass.dart';

class Settings extends StatefulWidget  {
  @override
  State<Settings> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  final AuthService _auth = AuthService();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 150),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SettingsEdit();
                    }));
                  },
                  child: new Text("Account"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ChangePass();
                    }));
                  },
                  child: new Text("Password"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return DeleteUser();
                    }));
                  },
                  child: new Text("Delete Account"),
                ),
                GestureDetector(
                  onTap: () {
                    _auth.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: new Text("Sign out"),
                ),
              ],
            ),
          ),
        ],
      ),
        
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            onPressed: () {
            },
            tooltip: 'Start',
            backgroundColor: Colors.green[200],
            child: Icon(Icons.play_arrow_outlined)),
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
                  child: Text("Start",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  width: 32,
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
