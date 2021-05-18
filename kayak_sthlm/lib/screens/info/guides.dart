import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'information.dart';

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(242, 248, 255, 1),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/bakgrund.png"),
              fit: BoxFit.cover,
            )),
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Stack(children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 650,
                      width: 324,
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(children: <Widget>[
                        Container(
                            height: 50,
                            alignment: Alignment.topCenter,
                            child: Text('TIPS',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w500))),
                        Container(
                            padding: EdgeInsets.only(left: 30),
                            height: 30,
                            alignment: Alignment.bottomLeft,
                            child: Text('Videos',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500))),
                        Expanded(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 600,
                                width: 324,
                                child: RawScrollbar(
                                    thumbColor:
                                        Color.fromRGBO(127, 184, 244, 0.8),
                                    radius: Radius.circular(7),
                                    isAlwaysShown: true,
                                    thickness: 14,
                                    child: ListView(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 25),
                                        children: <Widget>[
                                          YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId: 'ddwOc4uj4mQ',
                                              flags: YoutubePlayerFlags(
                                                hideControls: false,
                                                controlsVisibleAtStart: false,
                                                autoPlay: false,
                                                mute: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                          ),
                                          SizedBox(height: 25),
                                          YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId: 'zT67YPFkqqY',
                                              flags: YoutubePlayerFlags(
                                                hideControls: false,
                                                controlsVisibleAtStart: false,
                                                autoPlay: false,
                                                mute: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                          ),
                                          SizedBox(height: 25),
                                          YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId: 'Calmsh4zI5U',
                                              flags: YoutubePlayerFlags(
                                                hideControls: false,
                                                controlsVisibleAtStart: false,
                                                autoPlay: false,
                                                mute: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                          ),
                                          SizedBox(height: 25),
                                          YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              initialVideoId: 'JbP4XHPjVPk',
                                              flags: YoutubePlayerFlags(
                                                hideControls: false,
                                                controlsVisibleAtStart: true,
                                                autoPlay: false,
                                                mute: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                          ),
                                        ]))))
                      ]))),
              Positioned(
                  top: 26,
                  right: 7,
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
            ])));
  }
}