import 'package:flutter/material.dart';
import 'dart:ui';

class Confirmation extends StatefulWidget {
  final String message;
  final bool color;
  Confirmation({
    @required this.message,
    @required this.color,
  });

  @override
  State<StatefulWidget> createState() => _Confirmation();
}

class _Confirmation extends State<Confirmation> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20,top: 120, right: 20,bottom: 20
                ),
                margin: EdgeInsets.only(top: 45),
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
                    Text('Confirmation',
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.w200, fontFamily: 'HammersmithOne'),
                    ),
                    SizedBox(height: 22,),
                    widget.color ? Text(widget.message,
                      style:  TextStyle(fontSize: 22,fontWeight: FontWeight.w200, fontFamily: 'HammersmithOne', color: Colors.green[600]),
                    ): Text(widget.message,
                      style:  TextStyle(fontSize: 22,fontWeight: FontWeight.w200, fontFamily: 'HammersmithOne', color: Colors.red[800])),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(281, 48),
                          primary: Color.fromRGBO(86, 151, 211, 1),
                          backgroundColor: Colors.white,
                          shadowColor: Colors.black54,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          textStyle: TextStyle(
                              color: Colors.green[400],
                              fontSize: 18,
                              fontFamily: 'HammersmithOne'
                          ),
                        ),
                        child: Text('Close'),
                        onPressed: () async {
                          Navigator.pop(context);
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
    );      
  }
}