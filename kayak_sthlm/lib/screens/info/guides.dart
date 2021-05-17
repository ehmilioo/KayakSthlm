import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'information.dart';

class GuideScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guides'),
      ),
      body: Center(
        child: ListView(children: <Widget>[
          Text("I och ur kajaken", style: TextStyle(fontSize: 20)),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: 'ddwOc4uj4mQ',
              flags: YoutubePlayerFlags(
                hideControls: false,
                controlsVisibleAtStart: true,
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          Text("Golden Rules of Kayaking for Beginners",
              style: TextStyle(fontSize: 20)),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: 'zT67YPFkqqY',
              flags: YoutubePlayerFlags(
                hideControls: false,
                controlsVisibleAtStart: true,
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          Text("Top 5 Kayaking Tips and Skills for Beginners",
              style: TextStyle(fontSize: 20)),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: 'Calmsh4zI5U',
              flags: YoutubePlayerFlags(
                hideControls: false,
                controlsVisibleAtStart: true,
                autoPlay: false,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
          ),
          Text("Paddelteknik med kajaksidan.se",
              style: TextStyle(fontSize: 20)),
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
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                child: Text('Back'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationScreen()));
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
