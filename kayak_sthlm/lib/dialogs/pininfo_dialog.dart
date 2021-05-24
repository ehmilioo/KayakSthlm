import 'dart:convert';
import 'package:http/http.dart' as http;
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
        : FutureBuilder(
            future: getDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var resData = snapshot.data['result'];
                return Card(
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
                              color: Colors.black,
                              icon: Icon(Icons.close_outlined),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            resData['name'] != null
                                ? Text(
                                    resData['name'],
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w200,
                                        fontFamily: 'HammersmithOne'),
                                  )
                                : Text('No name is specified'),
                            SizedBox(
                              height: 22,
                            ),
                            resData['formatted_phone_number'] != null
                                ? Text(
                                    'Number: ${resData['formatted_phone_number']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'HammersmithOne',
                                    ))
                                : Text(
                                    'No phone number is specified by owners'),
                            resData['website'] != null
                                ? Text('Website: ${resData['website']}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'HammersmithOne',
                                    ))
                                : Text('No website is specified by owners'),
                            resData['opening_hours'] != null
                                ? Text(
                                    '${resData['opening_hours']['weekday_text'][0]} \n ${resData['opening_hours']['weekday_text'][1]} \n ${resData['opening_hours']['weekday_text'][2]} \n ${resData['opening_hours']['weekday_text'][3]} \n ${resData['opening_hours']['weekday_text'][4]} \n ${resData['opening_hours']['weekday_text'][5]} \n ${resData['opening_hours']['weekday_text'][6]} \n',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      fontFamily: 'HammersmithOne',
                                    ))
                                : Text(
                                    'No opening hours is specified by owners'),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            });
  }
}
