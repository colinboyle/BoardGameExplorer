import 'package:board_game_app/DataTypes/GameVideos.dart';
import 'package:board_game_app/HomeScreen/GameVideos/GameVideoCard.dart';
import 'package:board_game_app/HomeScreen/GameVideos/game_videos_bloc.dart';
import 'package:board_game_app/utils/api_response.dart';
//import 'package:board_game_app/HomeScreen/GameVideos/GameVideosCard.dart';
import 'package:flutter/material.dart';

class GameVideosList extends StatefulWidget {
  @override
  _GameVideosListState createState() => _GameVideosListState();
}


class _GameVideosListState extends State<GameVideosList> {
  GameVideosBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = GameVideosBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<GameVideos>>(
      stream: _bloc.gameVideosStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                return Text('Loading...', style: TextStyle(color: Colors.black));
            case Status.COMPLETED:
                return 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.videos.length,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                      Container(margin: EdgeInsets.symmetric(horizontal: 5), child: new GameVideoCard(snapshot.data.data.videos[index], 260, 180),);
                      
                    },);
            case Status.ERROR:
              return  Text('error', style: TextStyle(color: Colors.black));
            case Status.PARTIAL:
              return  Text('partial', style: TextStyle(color: Colors.black));
              }
            }
          return Container();
      });
     }

  @override 
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class Gam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}