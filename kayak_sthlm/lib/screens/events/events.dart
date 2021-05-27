import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:kayak_sthlm/screens/info/information.dart';
import 'package:kayak_sthlm/screens/my_routes/my_routes.dart';
import 'package:kayak_sthlm/screens/settings/settings.dart';

class Events extends StatefulWidget {
  @override
  State<Events> createState() => EventsPage();
}

class EventsPage extends State<Events> {
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
                          color: Colors.black26,
                          blurRadius: 3.0,
                          offset: Offset(2.0, 3))
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  child: Text('EVENTS',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 35,
                      ))),
              SizedBox(height: 33),
              Container(
                height: 400,
                width: 324,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/eventsComingSoon.png'),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              )
            ])),
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
                child: Image.asset('assets/navigationbar/home.png')),
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
                    icon: Image.asset('assets/navigationbar/routes.png'),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyRoutes()));
                    }),
                Container(
                  width: 48,
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        // Navigationsknapp 2: Events
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                        icon: Icon(Icons.calendar_today_outlined),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      Icon(Icons.circle,
                          size: 8, color: Color.fromRGBO(86, 151, 211, 1))
                    ],
                  ),
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
                ), // En container som innehåller tener som innehåller text till mittenknappen och samtidigt sprider ut ikonerna runt mittenknappen
                IconButton(
                  // Navigationsknapp 3: Info
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.info_outline),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InformationScreen()));
                  },
                ),

                IconButton(
                  // Navigationsknapp 4: Settings
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.settings_outlined),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
