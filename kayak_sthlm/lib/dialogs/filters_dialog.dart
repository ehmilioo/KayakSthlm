import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class Filters extends StatefulWidget {
  final Function togglePins;
  final Function toggleAllPins;
  Filters({
    @required this.togglePins,
    @required this.toggleAllPins,
  });

  @override
  State<StatefulWidget> createState() => _Filters();
}

class _Filters extends State<Filters> {
  

  @override
  void initState() {
    super.initState();
  }

  bool showKayak = true;
  bool showRestaurant = true;
  bool showMyPins = true;
  bool showRestplace = true;
  bool showAll = true;

  var styleConfig = TextStyle(fontSize: 13, fontFamily: 'HammersmithOne');


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 20,top: 20, right: 20,bottom: 20
              ),
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black,offset: Offset(0,10),
                  blurRadius: 10
                  ),
                ]
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close_outlined),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Text('Filters',
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200, fontFamily: 'HammersmithOne'),
                  ),
                  SizedBox(height: 22,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
                    children: [
                      Text('Kayak Rentals', style: styleConfig, textAlign: TextAlign.left),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: showKayak,
                          onChanged: (bool value){
                            setState((){
                              showKayak = value;
                            });
                            widget.togglePins(showKayak, 'kayak');
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: [
                      Text('Restaurants', style: styleConfig ,textAlign: TextAlign.left),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: showRestaurant,
                          onChanged: (bool value){
                            setState((){
                              showRestaurant = value;
                            });
                            widget.togglePins(showKayak, 'restaurant');
                          },
                        ),
                      ),
                      
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
                    children: [
                      Text('My Pins', style: styleConfig , textAlign: TextAlign.left),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: showMyPins,
                          onChanged: (bool value) {
                            setState((){
                              showMyPins = value;
                            });
                            widget.togglePins(showKayak, 'mypin');
                           },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween  ,
                    children: [
                      Text('Rest Places', style: styleConfig , textAlign: TextAlign.left),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: showRestplace,
                          onChanged: (bool value) { 
                            setState((){ 
                              showRestplace = value; 
                            });
                            widget.togglePins(showRestplace, 'restplace');
                          },
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    elevation: 5.0,
                    child: Text('Hide/Show All'),
                    onPressed: (){
                      widget.toggleAllPins(showAll);
                      setState(() {
                        showAll = !showAll;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );      
  }
}