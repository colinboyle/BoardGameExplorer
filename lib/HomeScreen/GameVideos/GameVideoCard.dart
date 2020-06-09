//import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameVideoCard extends StatefulWidget {
  final dynamic video;
  GameVideoCard(this.video);
  @override
  _GameVideoCardState createState() => _GameVideoCardState();
}

class _GameVideoCardState extends State<GameVideoCard> {
  YoutubePlayerController _controller;

  @override
  void initState(){
      _controller = YoutubePlayerController(
          initialVideoId: widget.video.extvideoid,
          flags: YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
          ),
      );
      super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container( width: 286, height: 170, child: 
      Padding( padding: EdgeInsets.all(10), child: 
        YoutubePlayerBuilder(
          player: YoutubePlayer(
              controller: _controller,
          ),
          builder: (context, player){
            return Column( children: <Widget>[
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                width: 266,
                //thumbnail: widget.video.images.thumb, 
                progressIndicatorColor: Colors.amber,
                progressColors: ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              )
            ]);
          }
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}