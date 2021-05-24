import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyRoutes extends StatelessWidget {
  final String userId = 'SA7vfU0GafXxjpUgLeNfcJfOZGA2';
  var sorting = 1;

  @override
  Widget build(BuildContext context) {
    CollectionReference routes =
        FirebaseFirestore.instance.collection('routes');

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
                  child: Text('MY ROUTES',
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 35,
                      ))),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                width: 324,
                child: ListView(scrollDirection: Axis.horizontal, children: <
                    Widget>[
                  Container(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(122, 35),
                            primary: sorting == 1 ? Colors.white : Colors.black,
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
                          print('all');
                          sorting = 1;
                        },
                        child: Text('All Routes')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(122, 35),
                            primary: sorting == 2 ? Colors.white : Colors.black,
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
                          print('favorite');
                          sorting = 2;
                        },
                        child: Text('Favorite Routes')),
                  ),
                  SizedBox(width: 10),
                  Container(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            minimumSize: Size(122, 35),
                            primary: sorting == 3 ? Colors.white : Colors.black,
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
                          sorting = 3;
                          print('longest');
                        },
                        child: Text('Longest Routes')),
                  )
                ]),
              ),
              Expanded(
                  child: FutureBuilder<QuerySnapshot>(
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
                          Iterable<QueryDocumentSnapshot> testHej =
                              snapshot.data.docs.where((element) =>
                                  (element.data()['userUid'] == userId)
                                      ? true
                                      : false);

                          List<QueryDocumentSnapshot> testLista =
                              testHej.toList();
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
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 600,
                                  width: 324,
                                  child: Expanded(
                                    child: ListView(
                                      padding: EdgeInsets.only(
                                          top: 8.0,
                                          bottom: 8.0,
                                          left: 8.0,
                                          right: 8.0),
                                      children: testLista
                                          .map((DocumentSnapshot document) {
                                        Expanded(
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                height: 600,
                                                width: 324,
                                                child: RawScrollbar(
                                                    thumbColor: Color.fromRGBO(
                                                        127, 184, 244, 0.8),
                                                    radius: Radius.circular(7),
                                                    isAlwaysShown: true,
                                                    thickness: 14,
                                                    child: ListView(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 25),
                                                      children: <Widget>[
                                                        Container(
                                                          child: Text(
                                                            document
                                                                .get('name'),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            document
                                                                .get('date'),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Duration: ' +
                                                                document.get(
                                                                    'timeTaken'),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            'Distance: ' +
                                                                document.get(
                                                                    'distance'),
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      ],
                                                    ))));
                                      }).toList(),
                                    ),
                                  ),
                                );
                              });
                        }
                      }))
            ])));
  }
}
