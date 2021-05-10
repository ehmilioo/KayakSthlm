import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/info/fire_info.dart';
import 'package:kayak_sthlm/screens/info/guides.dart';
import 'package:kayak_sthlm/screens/info/reserve.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/screens/info/symbols_info.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';
import 'app_icons.dart';

class InformationScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final Database db = new Database();

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ResetPass();
    }));
  }

  void flutterIsShit() {
    db.getMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 248, 255, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bakgrund.png"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.symmetric(horizontal: 45.0),
        child: Column(children: <Widget>[
          SizedBox(height: 50),
          Container(
              width: 322,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text('INFORMATION',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 33,
                  ))),
          SizedBox(height: 30),
          Row(children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.lightBlue,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        icon: Icon(AppIcons.guide),
                        iconSize: 55,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GuideScreen()));
                        },
                      )),
                )
              ],
            ),
            IconButton(
              icon: Icon(AppIcons.reserves),
              iconSize: 55,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReserveScreen()));
              },
            ),
          ]),
          SizedBox(height: 30),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(AppIcons.fire),
                iconSize: 55,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FireScreen()));
                },
              ),
              IconButton(
                icon: Icon(AppIcons.symbols),
                iconSize: 55,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SymbolsScreen()));
                },
              ),
            ],
          )
        ]),
      ),

      // FLOATINGACTIONBUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: FloatingActionButton(
            onPressed: () {
              openPage(context);
            },
            tooltip: 'Start',
            backgroundColor: Colors.green[200],
            child: Icon(Icons.play_arrow_outlined)),
      ),

      // BOTTOMNAVIVGATIONBAR
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationScreen()));
                },
              ),
              IconButton(
                // Navigationsknapp 4: Settings
                icon: Icon(Icons.follow_the_signs),
                iconSize: 35,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),

      // APPBAR
      appBar: AppBar(
        title: Text('Information'),
        backgroundColor: Colors.red[600],
        elevation: 0.0,
        actions: <Widget>[
          ElevatedButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              style: ElevatedButton.styleFrom(primary: Colors.deepOrange[600]),
              icon: Icon(Icons.lock_open),
              label: Text('Logga ut'))
        ],
      ),
    );
  }
}
