import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRoutes extends StatelessWidget {
  final String userId = 'SA7vfU0GafXxjpUgLeNfcJfOZGA2';

  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');
    return Scaffold(
      appBar: AppBar(
        title: Text('My Routes'),
      ),
      body: Center(
        child: ListView(
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

                  if (snapshot.connectionState == ConnectionState.done) {
                    Iterable<QueryDocumentSnapshot> routeIt = snapshot.data.docs
                        .where((element) =>
                            (element.data()['userUid'] == userId)
                                ? true
                                : false);

                    List<QueryDocumentSnapshot> routeList = routeIt.toList();

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
                                Container(
                                  height: 280,
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
      ),
    );
  }
}
