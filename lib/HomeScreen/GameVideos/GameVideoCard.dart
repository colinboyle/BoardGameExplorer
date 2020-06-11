//import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GameVideoCard extends StatelessWidget {
  final dynamic video;
  GameVideoCard(this.video);
  //@override
  //_GameVideoCardState createState() => _GameVideoCardState();
  //}

  //class _GameVideoCardState extends State<GameVideoCard> {
  //YoutubePlayerController _controller;

  //@override
  //void initState(){
  //    _controller = YoutubePlayerController(
  //        initialVideoId: widget.video.extvideoid,
  //        flags: YoutubePlayerFlags(
  //            mute: false,
  //            autoPlay: false,
  //            disableDragSeek: true,
  //        ),
  //    );
  //    super.initState();
  //}

  @override
  Widget build(BuildContext context){
    return 
    Container( width: 260, height: 180, child: 
      GestureDetector( onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {return VideoScreen(tag: '${video.videoid}', video: video);}));
      }, child: 
        Stack( children: <Widget>[
          Image.network(this.video.images.featured, width: 240),
          Align(alignment: Alignment.center, child: Container(width: 40, height: 30, decoration: BoxDecoration(color: Colors.black54 ,borderRadius: BorderRadius.all(Radius.circular(10))),child: Icon(Icons.play_arrow, size: 20, color: Colors.white))),
          Align(alignment: Alignment.topLeft, child: Container(width: 240, height: 50, decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter ,colors: [Colors.black.withOpacity(1.0), Colors.black.withOpacity(0.0)])), child: Padding( padding: EdgeInsets.fromLTRB(5,5,0,0), child: Text(video.title, style: TextStyle(color: Colors.white)))))
        ])
      )
    );
  }

  //@override
  //void dispose() {
  //  super.dispose();
  //  _controller.dispose();
  //}
}

class VideoScreen extends StatefulWidget {
  final String tag;
  final dynamic video;
  //VideoScreen(this.video);

  VideoScreen({Key key, @required this.tag, @required this.video})
      : assert(tag != null),
        assert(video != null),
        super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  YoutubePlayerController _controller;
  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
     _controller = YoutubePlayerController(
          initialVideoId: widget.video.extvideoid,
          flags: YoutubePlayerFlags(
              mute: false,
              autoPlay: false,
              disableDragSeek: true,
          ),
      );
    super.initState();
  }

  @override
  void dispose() {
    //SystemChrome.restoreSystemUIOverlays();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold (
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Hero(
            tag: widget.tag,
            child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                width: MediaQuery.of(context).size.width,
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
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}