import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kayak_sthlm/dialogs/delete_dialog.dart';
import 'package:kayak_sthlm/dialogs/logout_dialog.dart';
import 'package:kayak_sthlm/screens/authenticate/sign_in.dart';
import 'package:kayak_sthlm/screens/events/events.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:kayak_sthlm/screens/info/information.dart';
import 'package:kayak_sthlm/screens/my_routes/my_routes.dart';
import 'package:kayak_sthlm/screens/settings/settings_edit.dart';
import 'package:kayak_sthlm/services/auth.dart';
import 'package:kayak_sthlm/screens/settings/change_pass.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => SettingsPage();
}

class SettingsPage extends State<Settings> {
  final User user = FirebaseAuth.instance.currentUser;
  String uid = FirebaseAuth.instance.currentUser.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  child: Text('SETTINGS',
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.6, color: Colors.black),
                          ),
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 8)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('Account',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'Montserrat',
                                          ))),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: Color.fromRGBO(136, 134, 134, 1))
                                ]),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SettingsEdit();
                              }));
                            })),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.6, color: Colors.black),
                          ),
                        ),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.only(left: 8)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('Password',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                          ))),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: Color.fromRGBO(136, 134, 134, 1))
                                ]),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChangePass();
                              }));
                            })),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 0.6, color: Colors.black),
                          ),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.only(left: 8)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text('Delete Account',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color.fromRGBO(189, 0, 0, 1),
                                          fontFamily: 'Montserrat',
                                        ))),
                                Icon(Icons.arrow_forward_ios_rounded,
                                    color: Color.fromRGBO(136, 134, 134, 1))
                              ]),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => DeleteDialog()).then((value) {
                              if (AuthService().user == null) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()));
                              }
                            });
                          },
                        )),
                    SizedBox(height: 158),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(281, 48),
                        primary: Colors.white,
                        backgroundColor: Color.fromRGBO(86, 151, 211, 1),
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 45),
                          Icon(Icons.logout, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Log Out'),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                            context: context, builder: (_) => LogoutDialog());
                      },
                    ),
                  ],
                ),
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
                Container(
                  width: 48,
                  padding: EdgeInsets.only(top: 16),
                  child: Column(
                    children: <Widget>[
                      IconButton(
                        // Navigationsknapp 3: Settings
                        padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                        icon: Icon(Icons.settings_outlined),
                        iconSize: 30,
                        onPressed: () {},
                      ),
                      Icon(Icons.circle,
                          size: 8, color: Color.fromRGBO(86, 151, 211, 1))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
