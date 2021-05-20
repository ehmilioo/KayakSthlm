import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'information.dart';

class ReserveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map of Reserves'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            BottomAppBar(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: ElevatedButton(
                  child: Text('Rules when in nature'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReserveRulesScreen()));
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blueAccent,
                  width: 5,
                ),
              ),
              child: Image(
                image: AssetImage('assets/images/mapNatureReserves.png'),
                height: 200,
              ),
            ),
            ElevatedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InformationScreen()));
              },
            ),
          ],
        )));
  }
}

class ReserveRulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules when in nature'),
      ),
      body: Center(
          child: ListView(
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
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://www.naturvardsverket.se/Var-natur/Allemansratten/Det-har-galler/');
                    },
                ),
              ],
            ),
          ),
          ElevatedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => InformationScreen()));
            },
          ),
        ],
      )),
    );
  }
}
