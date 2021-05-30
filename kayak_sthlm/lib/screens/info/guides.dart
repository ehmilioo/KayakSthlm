import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GuideScreen extends StatelessWidget {
  final YoutubePlayer player1 = YoutubePlayer(
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),
    ],
    controller: YoutubePlayerController(
        initialVideoId: 'ddwOc4uj4mQ',
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: false,
          autoPlay: false,
          mute: false,
        )),
    showVideoProgressIndicator: true,
  );
  final YoutubePlayer player2 = YoutubePlayer(
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),
    ],
    controller: YoutubePlayerController(
        initialVideoId: 'zT67YPFkqqY',
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: false,
          autoPlay: false,
          mute: false,
        )),
    showVideoProgressIndicator: true,
  );
  final YoutubePlayer player3 = YoutubePlayer(
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),
    ],
    controller: YoutubePlayerController(
        initialVideoId: 'Calmsh4zI5U',
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: false,
          autoPlay: false,
          mute: false,
        )),
    showVideoProgressIndicator: true,
  );
  final YoutubePlayer player4 = YoutubePlayer(
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),
    ],
    controller: YoutubePlayerController(
        initialVideoId: 'smoRZGa0qXs',
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: false,
          autoPlay: false,
          mute: false,
        )),
    showVideoProgressIndicator: true,
  );

  final YoutubePlayer player5 = YoutubePlayer(
    bottomActions: [
      CurrentPosition(),
      ProgressBar(isExpanded: true),
    ],
    controller: YoutubePlayerController(
        initialVideoId: 'peA76KGvM_w',
        flags: YoutubePlayerFlags(
          hideControls: false,
          controlsVisibleAtStart: false,
          autoPlay: false,
          mute: false,
        )),
    showVideoProgressIndicator: true,
  );

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
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 5),
                                blurRadius: 10),
                          ]),
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
                                          player1,
                                          SizedBox(height: 25),
                                          player2,
                                          SizedBox(height: 25),
                                          player3,
                                          SizedBox(height: 25),
                                          player4,
                                          SizedBox(height: 25),
                                          player5,
                                        ]))))
                      ]))),
              Positioned(
                  top: 26,
                  right: 6,
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
