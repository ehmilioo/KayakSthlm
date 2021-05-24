import 'package:flutter/material.dart';
import 'dart:ui';

class PinInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  PinInfo({
    @required this.item,
  });

  @override
  State<StatefulWidget> createState() => _PinInfo();
}

class _PinInfo extends State<PinInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.item['type'] == 'mypin'
        ? Card(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 20, top: 120, right: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.close_outlined),
                        color: Colors.blue[200],
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        widget.item['name'],
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'HammersmithOne'),
                      ),
                      Text(
                        'Custom pin made by: ${widget.item['username']}',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'HammersmithOne'),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'HammersmithOne'),
                      ),
                      Text(widget.item['desc'],
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'HammersmithOne',
                              color: Colors.red[800])),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Card(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 20, top: 120, right: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 10),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Confirmation',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w200,
                            fontFamily: 'HammersmithOne'),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Text('Inte Custom Pin',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w200,
                              fontFamily: 'HammersmithOne',
                              color: Colors.red[800])),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
