import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReserveRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stack(children: [
      Align(
          alignment: Alignment.center,
          child: Container(
              height: 650,
              width: 324,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 5),
                        blurRadius: 10),
                  ]),
              child: Column(children: <Widget>[
                Container(
                    height: 50,
                    alignment: Alignment.topCenter,
                    child: Text('Rules',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w500))),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        height: 600,
                        width: 324,
                        child: RawScrollbar(
                            thumbColor: Color.fromRGBO(127, 184, 244, 0.8),
                            radius: Radius.circular(7),
                            isAlwaysShown: true,
                            thickness: 14,
                            child: ListView(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                children: <Widget>[
                                  Text(
                                      "Avoid plants and trees. You are not allowed to pick up protected plants; such as orchids." +
                                          "\n",
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      "Avoid bird nests and their children. Do not hurt or pick up snakes, reptiles and frogs nor other animals." +
                                          "\n",
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      "Avoid bird and seal sanctuaries when access to those areas is prohibited." +
                                          "\n",
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      "Your dog needs to be tethered at all time when in nature." +
                                          "\n",
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      "Do not start a fire. It is also forbidden to put disposable grills in the garbage due to the fire risk!" +
                                          "\n",
                                      style: TextStyle(fontSize: 20)),
                                  Text(
                                      "In Sweden there is a right, allemansrätten, or in english 'right of public access', that says you are allowed to spend time in nature, even when it belongs to landowners, however, you do need to be responsible and not disturb anyone while doing so. \n",
                                      style: TextStyle(fontSize: 20)),
                                  RichText(
                                    text: new TextSpan(
                                      children: [
                                        new TextSpan(
                                          text:
                                              'For more information, please see Naturvårdsverket site.',
                                          style:
                                              new TextStyle(color: Colors.blue),
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              launch(
                                                  'https://www.naturvardsverket.se/Var-natur/Allemansratten/Det-har-galler/');
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ])))),
                Positioned(
                    top: 26,
                    right: 6,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Card(
                          elevation: 20,
                          shape: CircleBorder(),
                          child: CircleAvatar(
                            radius: 24.0,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        )))
              ])))
    ]);
  }
}
