import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/events/events.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:kayak_sthlm/screens/info/fire_screen.dart';
import 'package:kayak_sthlm/screens/info/guides.dart';
import 'package:kayak_sthlm/screens/info/mapForReserves.dart';
import 'package:kayak_sthlm/screens/my_routes/my_routes.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';
import 'package:kayak_sthlm/screens/info/symbols_info.dart';
import 'package:kayak_sthlm/services/database.dart';
import 'package:kayak_sthlm/screens/authenticate/reset_pass.dart';
import 'app_icons.dart';

class InformationScreen extends StatelessWidget {
  final Database db = new Database();

  void openPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ResetPass();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 248, 255, 1),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/bakgrund.png"),
          fit: BoxFit.cover,
        )),
        padding: EdgeInsets.symmetric(horizontal: 45),
        child: Column(children: <Widget>[
          SizedBox(height: 90),
          Container(
              width: 270,
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 3.0,
                      offset: Offset(2.0, 3))
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Text('INFORMATION',
                  style: TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 33,
                  ))),
          SizedBox(height: 80),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    height: 87,
                    width: 133,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3.0,
                            offset: Offset(2.0, 3))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(Icons.lightbulb_outline, size: 55),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GuideScreen()));
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Tips\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ))
                ]),
                Column(children: <Widget>[
                  Container(
                    height: 87,
                    width: 133,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3.0,
                            offset: Offset(2.0, 3))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(AppIcons.reserves, size: 55),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WildlifePreserves()));
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Wildlife\nPreserves',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ))
                ]),
              ]),
          SizedBox(height: 40),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(children: <Widget>[
                  Container(
                    height: 87,
                    width: 133,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3.0,
                            offset: Offset(2.0, 3))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(AppIcons.fire, size: 55),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FireScreen()));
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Fire Bans\n',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ))
                ]),
                Column(children: <Widget>[
                  Container(
                    height: 87,
                    width: 133,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            blurRadius: 3.0,
                            offset: Offset(2.0, 3))
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 56,
                      icon: Icon(AppIcons.symbols, size: 55),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SymbolsScreen()));
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  Text('Map\nSymbols',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ))
                ]),
              ]),
        ]),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 80.0,
        width: 80.0,
        child: FloatingActionButton(
          elevation: 10,
          child: Container(
              height: 80.0,
              width: 80.0,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors: [Color.fromRGBO(86, 151, 211, 1), Colors.black],
                      stops: [0.44, 1],
                      radius: 1)),
              child: Icon(
                Icons.map_outlined,
                size: 50,
              )),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(

                  // Navigationsknapp 1: Routes
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.place_outlined),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyRoutes()));
                  }),
              IconButton(
                // Navigationsknapp 2: Events
                padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                icon: Icon(Icons.calendar_today_outlined),
                iconSize: 30,
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Events()));
                },
              ),
              Container(
                padding: EdgeInsets.only(bottom: 8),
                alignment: Alignment.bottomCenter,
                height: 50,
                width: 52,
                child: Text("HOME",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              ), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
              Container(
                width: 48,
                padding: EdgeInsets.only(top: 16),
                child: Column(
                  children: <Widget>[
                    IconButton(
                      // Navigationsknapp 3: Info
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                      icon: Icon(Icons.info_outline),
                      iconSize: 30,
                      onPressed: () {},
                    ),
                    Icon(Icons.circle,
                        size: 8, color: Color.fromRGBO(86, 151, 211, 1))
                  ],
                ),
              ),

              IconButton(
                  // Navigationsknapp 4: Settings
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.settings_outlined),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  }),
            ],
          ),
        ),
      ),

      // // FLOATINGACTIONBUTTON
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 30.0),
      //   child: FloatingActionButton(
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //             context, MaterialPageRoute(builder: (context) => Home()));
      //       },
      //       tooltip: 'Start',
      //       backgroundColor: Colors.green[200],
      //       child: Icon(Icons.play_arrow_outlined)),
      // ),

      // // BOTTOMNAVIVGATIONBAR
      // bottomNavigationBar: SizedBox(
      //   height: 60,
      //   child: BottomAppBar(
      //     shape: CircularNotchedRectangle(),
      //     notchMargin: 10.0,
      //     child: new Row(
      //       mainAxisSize: MainAxisSize.max,
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: <Widget>[
      //         IconButton(
      //           // Navigationsknapp 1: Routes
      //           icon: Icon(Icons.place_outlined),
      //           iconSize: 35,
      //           onPressed: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (context) => Register()));
      //           },
      //         ),
      //         IconButton(
      //           // Navigationsknapp 2: Events
      //           icon: Icon(Icons.calendar_today_outlined),
      //           iconSize: 35,
      //           onPressed: () {},
      //         ),
      //         Container(
      //             child: Text("Start",
      //                 style: TextStyle(fontWeight: FontWeight.bold)),
      //             width: 32,
      //             height:
      //                 30), // En container som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
      //         IconButton(
      //           // Navigationsknapp 3: Info
      //           icon: Icon(Icons.info_outline),
      //           iconSize: 35,
      //           onPressed: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => InformationScreen()));
      //           },
      //         ),
      //         IconButton(
      //           // Navigationsknapp 4: Settings
      //           icon: Icon(Icons.follow_the_signs),
      //           iconSize: 35,
      //           onPressed: () {},
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      // // APPBAR
      // appBar: AppBar(
      //   title: Text('Information'),
      //   backgroundColor: Colors.red[600],
      //   elevation: 0.0,
      //   actions: <Widget>[
      //     ElevatedButton.icon(
      //         onPressed: () async {
      //           await _auth.signOut();
      //         },
      //         style: ElevatedButton.styleFrom(primary: Colors.deepOrange[600]),
      //         icon: Icon(Icons.lock_open),
      //         label: Text('Logga ut'))
      //   ],
      // ),
    );
  }
}
