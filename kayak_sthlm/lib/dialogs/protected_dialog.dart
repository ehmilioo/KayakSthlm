import 'package:flutter/material.dart';
import 'dart:ui';

class ProtectedPinInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  ProtectedPinInfo({
    @required this.item,
  });

  @override
  State<StatefulWidget> createState() => _ProtectedPinInfo();
}

class _ProtectedPinInfo extends State<ProtectedPinInfo> {
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
            padding: EdgeInsets.only(left: 20, top: 120, right: 20, bottom: 20),
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
                widget.item['type'] == 'bird'
                    ? Text('Seal')
                    : Text('Bird'), //Bygg bild utefter denna kod
                Text(
                  widget.item['name'],
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'HammersmithOne'),
                ),
                Text(
                  'Type: ${widget.item['restrictArea']}',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'HammersmithOne'),
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'Access Ban: ${widget.item['accessBan']}',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'HammersmithOne'),
                ),
                Text('Municipality: ${widget.item['municipality']}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w200,
                        fontFamily: 'HammersmithOne',
                        color: Colors.red[800])),
                Text('Description: ${widget.item['desc']}',
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
