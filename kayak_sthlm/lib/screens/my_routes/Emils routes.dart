import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyRoutes extends StatefulWidget {
  const MyRoutes({Key key}) : super(key: key);

  @override
  _MyRoutesState createState() => _MyRoutesState();
}

class _MyRoutesState extends State {
  List<QueryDocumentSnapshot> routeList;
  AsyncSnapshot<QuerySnapshot> snap;
  //FirebaseAuth.instance.currentUser.uid;
  //'SA7vfU0GafXxjpUgLeNfcJfOZGA2'; for testing
  final String userId = FirebaseAuth.instance.currentUser.uid;

  List<QueryDocumentSnapshot> sortAll() {
    return snap.data.docs
        .where(
            (element) => (element.data()['userUid'] == userId) ? true : false)
        .toList();
  }

  List<QueryDocumentSnapshot> sortFavourites() {
    return snap.data.docs
        .where((element) =>
            (((element.data()['userUid'] == userId) ? true : false) &&
                ((element.data()['favorite'] == true) ? true : false)))
        .toList();
  }

  void sortShortest() {
    List<QueryDocumentSnapshot> list = routeList;

    list.sort((a, b) => double.parse(a.data()['distance'])
        .compareTo(double.parse(b.data()['distance'])));
    routeList = list;
  }

  void sortLongest() {
    sortShortest();
    routeList = routeList.reversed.toList();
  }

  void sortLatest() {
    List<QueryDocumentSnapshot> list = routeList;

    list.sort((a, b) => DateFormat('EEEE dd MMMM yyyy')
            .parse(a.data()['date'])
            .isBefore(DateFormat('EEEE dd MMMM yyyy').parse(b.data()['date']))
        ? 1
        : 0);
    routeList = list;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text('My Routes'),
      ),
      body: Center(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              height: 42,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (snap.connectionState == ConnectionState.done) {
                        setState(() {
                          routeList = sortAll();
                        });
                      }
                    },
                    child: Text('All Routes'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (snap.connectionState == ConnectionState.done) {
                        setState(() {
                          routeList = sortFavourites();
                        });
                      }
                    },
                    child: Text('Favorites'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (snap.connectionState == ConnectionState.done) {
                        setState(() {
                          sortLatest();
                        });
                      }
                    },
                    child: Text('Latest'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (snap.connectionState == ConnectionState.done) {
                        setState(() {
                          sortLongest();
                        });
                      }
                    },
                    child: Text('Longest'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (snap.connectionState == ConnectionState.done) {
                        setState(() {
                          sortShortest();
                        });
                      }
                    },
                    child: Text('Shortest'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
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

                  if (snapshot.connectionState == ConnectionState.done) {
                    snap = snapshot;
                    if (routeList == null) {
                      routeList = sortAll();
                    }

                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('routes')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return Column(
                          children: routeList.map((DocumentSnapshot document) {
                            return Column(
                              children: [
                                Card(
                                  child: Container(
                                    height: 200,
                                    width: 280,
                                    padding: EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8.0,
                                        left: 8.0,
                                        right: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.star,
                                            color: (() {
                                              if (document.get('favorite')) {
                                                return Colors.yellow;
                                              } else {
                                                return Colors.grey;
                                              }
                                            }()),
                                            size: 24,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            document.get('name'),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            document.get('date'),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Duration: ' +
                                                document.get('timeTaken'),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Distance: ' +
                                                document.get('distance'),
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
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
      ),
    );
  }
}
