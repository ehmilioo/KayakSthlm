import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:url_launcher/url_launcher.dart';

class PinInfo extends StatefulWidget {
  final Map<String, dynamic> item;
  PinInfo({
    @required this.item,
  });

  @override
  State<StatefulWidget> createState() => _PinInfo();
}

class _PinInfo extends State<PinInfo> {
  String pinType;
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getDetails() async {
    String _url = 'maps.googleapis.com';

    Map<String, String> _parameters = {
      'key':
          'AIzaSyAQB7qDxdH_-5bpTA6IvQjlPru7fkOPqQY', //Denna ska egentligen gömmas med dotenv..
      'place_id': widget.item['place_id'],
      'fields':
          'website,rating,opening_hours/weekday_text,geometry/location,name,rating,formatted_phone_number',
    };
    String _path = '/maps/api/place/details/json';
    final response = await http.get(Uri.https(_url, _path, _parameters));
    final Map<String, dynamic> data = json.decode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      print('Failed to load API ${response.statusCode} ');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.item['type'] == 'Custom Pin'
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
        : FutureBuilder(
            future: getDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var resData = snapshot.data['result'];
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 420,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Material(
                            color: Colors.white,
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    resData['name'] != null
                                        ? Text(
                                            resData['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Montserrat'),
                                          )
                                        : Text('No name available'),
                                    SizedBox(height: 10),
                                    Text(widget.item['type'],
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14)),
                                    SizedBox(height: 20),
                                    resData['formatted_phone_number'] != null
                                        ? RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Phone: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        '${resData['formatted_phone_number']}',
                                                    style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            0, 71, 255, 1)))
                                              ]))
                                        : RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Phone: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        'No phone number available')
                                              ])),
                                    SizedBox(height: 20),
                                    resData['website'] != null
                                        ? RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: <TextSpan>[
                                                TextSpan(
                                                    text: 'Website: ',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                    text:
                                                        '${resData['website']}',
                                                    recognizer:
                                                        new TapGestureRecognizer()
                                                          ..onTap = () {
                                                            launch(
                                                                '${resData['website']}');
                                                          },
                                                    style: TextStyle(
                                                        decoration:
                                                            TextDecoration
                                                                .underline,
                                                        color: Color.fromRGBO(
                                                            0, 71, 255, 1)))
                                              ]))
                                        : Text('No website available'),
                                    SizedBox(height: 20),
                                    Container(
                                      height: 150,
                                      child: resData['opening_hours'] != null
                                          ? RichText(
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Opening Hours:\n',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          ('${resData['opening_hours']['weekday_text'][0]}\n')),
                                                  TextSpan(
                                                      text:
                                                          ('${resData['opening_hours']['weekday_text'][1]}\n')),
                                                  TextSpan(
                                                      text:
                                                          ('${resData['opening_hours']['weekday_text'][2]}\n')),
                                                  TextSpan(
                                                    text:
                                                        ('${resData['opening_hours']['weekday_text'][3]}\n'),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ('${resData['opening_hours']['weekday_text'][4]}\n'),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ('${resData['opening_hours']['weekday_text'][5]}\n'),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ('${resData['opening_hours']['weekday_text'][6]}\n'),
                                                  )
                                                ]))
                                          : Text('No opening hours available'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 424,
                          right: 3,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Card(
                                elevation: 20,
                                shape: CircleBorder(),
                                child: CircleAvatar(
                                  radius: 18.0,
                                  backgroundColor: Colors.blue,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              )))
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            });
  }
}
