import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kayak_sthlm/screens/home/home.dart';
import 'package:kayak_sthlm/screens/info/information.dart';

class MyRoutes extends StatefulWidget {
  @override
  State<MyRoutes> createState() => RoutesPage();
}

class RoutesPage extends State<MyRoutes> {
  final String userId = 'SA7vfU0GafXxjpUgLeNfcJfOZGA2';
  int sorting = 1;

  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');
    int sort;
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
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Column(children: <Widget>[
            SizedBox(height: 40),
            Container(
                width: 322,
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
                child: Text('MY ROUTES',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 35,
                    ))),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                height: 70,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size(122, 35),
                                primary:
                                    sorting == 1 ? Colors.white : Colors.black,
                                backgroundColor: sorting == 1
                                    ? Color.fromRGBO(85, 152, 214, 1)
                                    : Color.fromRGBO(212, 230, 251, 1),
                                shadowColor: Colors.black,
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            onPressed: () {
                              setState(() {
                                sorting = 1;
                              });
                            },
                            child: Text('All Routes')),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size(122, 35),
                                primary:
                                    sorting == 2 ? Colors.white : Colors.black,
                                backgroundColor: sorting == 2
                                    ? Color.fromRGBO(85, 152, 214, 1)
                                    : Color.fromRGBO(212, 230, 251, 1),
                                shadowColor: Colors.black,
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            onPressed: () {
                              setState(() {
                                sorting = 2;
                              });
                            },
                            child: Text('Favorite Routes')),
                      ),
                      SizedBox(width: 15),
                      Container(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                minimumSize: Size(122, 35),
                                primary:
                                    sorting == 3 ? Colors.white : Colors.black,
                                backgroundColor: sorting == 3
                                    ? Color.fromRGBO(85, 152, 214, 1)
                                    : Color.fromRGBO(212, 230, 251, 1),
                                shadowColor: Colors.black,
                                elevation: 10,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                textStyle: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                            onPressed: () {
                              setState(() {
                                sorting = 3;
                              });
                            },
                            child: Text('Longest Routes')),
                      )
                    ])),
            Container(
                padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                height: 551,
                width: MediaQuery.of(context).size.width,
                child: RawScrollbar(
                  thumbColor: Color.fromRGBO(127, 184, 244, 0.8),
                  radius: Radius.circular(7),
                  isAlwaysShown: true,
                  thickness: 14,
                  child: ListView(
                    padding: EdgeInsets.only(right: 30),
                    children: [
                      FutureBuilder<QuerySnapshot>(
                          future: routes.firestore.collection('routes').get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (snapshot.hasData && snapshot.data == null) {
                              return Text("Document does not exist");
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Iterable<QueryDocumentSnapshot> routeIt =
                                  snapshot.data.docs.where((element) =>
                                      (element.data()['userUid'] == userId)
                                          ? true
                                          : false);

                              List<QueryDocumentSnapshot> routeList =
                                  routeIt.toList();

                              return StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('routes')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }

                                  return Column(
                                    children: routeList
                                        .map((DocumentSnapshot document) {
                                      return Column(
                                        children: [
                                          SizedBox(height: 44),
                                          GestureDetector(
                                              onTap: () {
                                                print(document.get('name'));
                                              },
                                              child: Container(
                                                height: 176,
                                                width: 305,
                                                padding: EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            document
                                                                .get('name'),
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        IconButton(
                                                            alignment: Alignment
                                                                .center,
                                                            constraints:
                                                                BoxConstraints(
                                                                    maxWidth:
                                                                        36,
                                                                    maxHeight:
                                                                        36),
                                                            icon:
                                                                //  favoriteRoute
                                                                //     ?
                                                                Icon(
                                                                    Icons
                                                                        .star_rate_rounded,
                                                                    color: Colors
                                                                            .yellow[
                                                                        700]),
                                                            iconSize: 40,
                                                            // : Icon(Icons.star_border_rounded,
                                                            //     color: Colors.black),
                                                            // onPressed: () {
                                                            //   setState(() => {favoriteRoute = !favoriteRoute});
                                                            // },
                                                            onPressed: () {}),
                                                      ],
                                                    ),
                                                    Text(
                                                      document.get('date'),
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      'Duration: ' +
                                                          document.get(
                                                              'timeTaken') +
                                                          'm',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      'Distance: ' +
                                                          document
                                                              .get('distance') +
                                                          'km',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                },
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ],
                  ),
                )),
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
                Container(
                    width: 48,
                    padding: EdgeInsets.only(top: 16),
                    child: Column(children: <Widget>[
                      IconButton(
                          // Navigationsknapp 1: Routes
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                          icon: Icon(Icons.place_outlined),
                          iconSize: 30,
                          onPressed: () {}),
                      Icon(Icons.circle,
                          size: 8, color: Color.fromRGBO(86, 151, 211, 1))
                    ])),

                IconButton(
                  // Navigationsknapp 2: Events
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.calendar_today_outlined),
                  iconSize: 30,
                  onPressed: () {},
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
                  // Navigationsknapp 3: Settings
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
                  icon: Icon(Icons.settings_outlined),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InformationScreen()));
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

// class MyRoutes extends StatelessWidget {
//   final String userId = FirebaseAuth.instance.currentUser.uid;

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference routes =
//         FirebaseFirestore.instance.collection('routes');
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context, false);
//           },
//         ),
//         title: Text('My Routes'),
//       ),
//       body: Center(
//         child: ListView(
//           children: [
//             FutureBuilder<QuerySnapshot>(
//                 future: routes.firestore.collection('routes').get(),
//                 builder: (BuildContext context,
//                     AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasError) {
//                     return Text("Something went wrong");
//                   }

//                   if (snapshot.hasData && snapshot.data == null) {
//                     return Text("Document does not exist");
//                   }

//                   if (snapshot.connectionState == ConnectionState.done) {
//                     Iterable<QueryDocumentSnapshot> routeIt = snapshot.data.docs
//                         .where((element) =>
//                             (element.data()['userUid'] == userId)
//                                 ? true
//                                 : false);

//                     List<QueryDocumentSnapshot> routeList = routeIt.toList();

//                     return StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('routes')
//                           .snapshots(),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (!snapshot.hasData) {
//                           return Center(child: CircularProgressIndicator());
//                         }

//                         return Column(
//                           children: routeList.map((DocumentSnapshot document) {
//                             return Column(
//                               children: [
//                                 Container(
//                                   height: 280,
//                                   width: 280,
//                                   padding: EdgeInsets.only(
//                                       top: 8.0,
//                                       bottom: 8.0,
//                                       left: 8.0,
//                                       right: 8.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         child: Text(
//                                           document.get('name'),
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                           document.get('date'),
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                           'Duration: ' +
//                                               document.get('timeTaken'),
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                       Container(
//                                         child: Text(
//                                           'Distance: ' +
//                                               document.get('distance'),
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             );
//                           }).toList(),
//                         );
//                       },
//                     );
//                   }
//                   return Center(child: CircularProgressIndicator());
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
