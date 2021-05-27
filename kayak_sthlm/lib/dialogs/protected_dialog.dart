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
    return Container(
        child: Stack(children: <Widget>[
      Container(
          height: 386,
          padding: EdgeInsets.all(Constants.padding),
          margin: EdgeInsets.fromLTRB(37, 120, 37, 0),
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
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(214, 214, 214, 1)))),
                      height: 70,
                      child: Text(widget.item['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                              color: Colors.black))),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    children: <TextSpan>[
                              TextSpan(
                                  text: 'Type: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              widget.item['areaType'] == 'bird'
                                  ? TextSpan(text: 'Bird Protection Area')
                                  : TextSpan(text: 'Seal Protection Area')
                            ]))),
                        SizedBox(height: 20),
                        Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    children: <TextSpan>[
                              TextSpan(
                                  text: 'Restricted Area: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${widget.item['restrictArea']}')
                            ]))),
                        SizedBox(height: 20),
                        Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    children: <TextSpan>[
                              TextSpan(
                                  text: 'Access Ban: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${widget.item['accessBan']}')
                            ]))),
                        SizedBox(height: 20),
                        Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    children: <TextSpan>[
                              TextSpan(
                                  text: 'Municipality: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${widget.item['municipality']}')
                            ]))),
                        SizedBox(height: 20),
                        Container(
                            child: RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    children: <TextSpan>[
                              TextSpan(
                                  text: 'Description: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${widget.item['desc']}')
                            ]))),
                      ],
                    ),
                  )
                ],
              ))),
      Positioned(
          top: 92,
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
//     return Card(
//       color: Colors.transparent,
//       child: Stack(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(left: 20, top: 120, right: 20, bottom: 20),
//             margin: EdgeInsets.only(top: 45),
//             decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                       color: Colors.black,
//                       offset: Offset(0, 10),
//                       blurRadius: 10),
//                 ]),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.close_outlined),
//                   color: Colors.blue[200],
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 widget.item['type'] == 'bird'
//                     ? Text('Seal')
//                     : Text('Bird'), //Bygg bild utefter denna kod
//                 Text(
//                   widget.item['name'],
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w200,
//                       fontFamily: 'HammersmithOne'),
//                 ),
//                 Text(
//                   'Type: ${widget.item['restrictArea']}',
//                   style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w200,
//                       fontFamily: 'HammersmithOne'),
//                 ),
//                 SizedBox(
//                   height: 22,
//                 ),
//                 Text(
//                   'Access Ban: ${widget.item['accessBan']}',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.w200,
//                       fontFamily: 'HammersmithOne'),
//                 ),
//                 Text('Municipality: ${widget.item['municipality']}',
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w200,
//                         fontFamily: 'HammersmithOne',
//                         color: Colors.red[800])),
//                 Text('Description: ${widget.item['desc']}',
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.w200,
//                         fontFamily: 'HammersmithOne',
//                         color: Colors.red[800])),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}
