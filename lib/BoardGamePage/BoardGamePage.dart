import 'dart:ui';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/Layout/CustomBanner.dart';
import 'package:flutter/material.dart';
//import 'package:board_game_app/BoardGame.dart';
//import './board_game_repository.dart';
//import 'package:board_game_app/api_response.dart';
import 'package:board_game_app/BoardGamePage/board_game_page_bloc.dart';
//import 'package:board_game_app/api_response.dart';
//import 'package:board_game_app/BoardGameList/GameListView.dart';

class BoardGamePage extends StatefulWidget {
  final String id;
  //final String title;

  BoardGamePage(this.id);

  @override
  _BoardGamePageState createState() => _BoardGamePageState();//title, url);
}

class _BoardGamePageState extends State<BoardGamePage> {
  BoardGamePageBloc _bloc;
  //String title;
  String id;
  String loadingMessage;
  String errorMessage;
  Future<BoardGame> futureBoardGame;

  _BoardGamePageState();//this.title, this.url);

  @override
  void initState() {
    super.initState();
    _bloc = BoardGamePageBloc();//widget.id);
    futureBoardGame = _bloc.fetchBoardGame(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: Container(
          decoration: backgroundGradient(),
          child: 
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    CustomBanner(),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          //Text(widget.id)

                          FutureBuilder<BoardGame>(
                            future: futureBoardGame,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return BoardGameDisplay(snapshot.data);//Text(snapshot.data.name);
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              // TO DO: Unbreak this
                              return SizedBox(
                                width: 20,
                                height: 20,
                                //color: Colors.red,
                                child:Center(child:CircularProgressIndicator())
                              );
                            },
                          ),

                        ],
                      )
                    ),
                  ],
                ),
              ],
            ),
        )
      );
  }
}

class Loading extends StatelessWidget {
  //final String loadingMessage;
  //Loading({String loadingMessage});
  @override 
  Widget build(BuildContext context) {
    return Text('Loading..');
  }
}

class Error extends StatelessWidget {
  //const String errorMessage;
  //Error({String errorMessage});
  @override 
  Widget build(BuildContext context) {
    return Text('Error loading.. Please try again.');
  }
}

BoxDecoration backgroundGradient() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      tileMode: TileMode.mirror,
      stops: [0,0.4,0.6,1],
      colors: [
        Colors.blueGrey[800],
        Colors.blueGrey[700],
        Colors.blueGrey[700],
        Colors.blueGrey[800]
      ]
    )
  );
}

class BoardGameDisplay extends StatelessWidget {
  final BoardGame gameInfo;

  BoardGameDisplay(this.gameInfo);

  build(BuildContext context){
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(gameInfo.fullImageUrl),
                ),
              ),
              //width: 200,//MediaQuery.of(context).size.width,
              height: 200.0,
            ),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black.withOpacity(0.9),
                  ],
                  stops: [0.0,0.6,0.9]
                )
              ),
            ),
            Positioned.fill(child:Align(child:Text(gameInfo.name, style: TextStyle(color: Colors.white, ) ), alignment: Alignment.bottomCenter,)),
            Positioned.fill(child:Align(child:Icon(Icons.favorite_border, color: Colors.white), alignment: Alignment.bottomRight,)),
          ]
        ), 
        Text(gameInfo.description, style: TextStyle(color: Colors.white),)
      ]
    );
  }
}