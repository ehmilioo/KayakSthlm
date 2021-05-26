import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReserveRulesDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RulesOverlayState();
}

class RulesOverlayState extends State<ReserveRulesDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(children: <Widget>[
      Container(
          height: 600,
          padding: EdgeInsets.only(
              bottom: Constants.padding, top: Constants.padding),
          margin: EdgeInsets.fromLTRB(37, 50, 37, 50),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: Material(
            color: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text('Rules',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Colors.black))),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(10),
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
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                Text(
                                    "Avoid bird nests and their children. Do not hurt or pick up snakes, reptiles and frogs nor other animals." +
                                        "\n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                Text(
                                    "Avoid bird and seal sanctuaries when access to those areas is prohibited." +
                                        "\n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                Text(
                                    "Your dog needs to be tethered at all time when in nature." +
                                        "\n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                Text(
                                    "Do not start a fire. It is also forbidden to put disposable grills in the garbage due to the fire risk!" +
                                        "\n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                Text(
                                    "In Sweden there is a right, allemansrätten, or in english 'right of public access', that says you are allowed to spend time in nature, even when it belongs to landowners, however, you do need to be responsible and not disturb anyone while doing so. \n",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Montserrat')),
                                RichText(
                                  text: new TextSpan(
                                    children: [
                                      new TextSpan(
                                        text:
                                            'For more information, please see Naturvårdsverket site.',
                                        style: new TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Montserrat',
                                            color: Colors.blue),
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
            ]),
          )),
      Positioned(
          top: 23,
          right: 8,
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
    ]));
  }
}

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
