//import 'dart:html';
import 'dart:async';
import 'dart:ui';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
//import 'package:board_game_app/Layout/CustomBanner.dart';
import 'package:board_game_app/Layout/CustomSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/utils/getHashColors.dart';
//import 'package:board_game_app/BoardGame.dart';
//import './board_game_repository.dart';
//import 'package:board_game_app/api_response.dart';
import 'package:board_game_app/BoardGamePage/board_game_page_bloc.dart';

import '../api_response.dart';
//import 'package:board_game_app/api_response.dart';
//import 'package:board_game_app/BoardGameList/GameListView.dart';

class BoardGamePage extends StatefulWidget {
  final BoardGame game;
  final bool needFullInfo;
  var _hashColors = new GetHashColors();

  BoardGamePage(this.game, this.needFullInfo);

  @override
  _BoardGamePageState createState() => _BoardGamePageState();
}

class _BoardGamePageState extends State<BoardGamePage> {
  BoardGamePageBloc _bloc;
  String loadingMessage;
  String errorMessage;
  var broadcastGameImagesStream;
  //Future<BoardGame> futureBoardGame;

  _BoardGamePageState();//this.title, this.url);

  @override
  void initState() {
    super.initState();
    _bloc = BoardGamePageBloc(widget.game.id);
    broadcastGameImagesStream = _bloc.gameImagesStream.asBroadcastStream();//widget.id);
    //_bloc.fetchGameImages(widget.game.id);
    //futureBoardGame = _bloc.fetchBoardGame(widget.game.id);
    //_hashColors = new GetHashColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue[800]
                  ),
                  Container( 
                    height: 80, 
                    width:MediaQuery.of(context).size.width,
                    child:CustomSearchBar()
                  ),
                ],
              ),
            ],
          ),
          Row(children: <Widget>[
            Stack(children: <Widget>[
              Container( 
                width: MediaQuery.of(context).size.width, 
                height: 160,
                child: Align(alignment: Alignment.topRight, child:

              StreamBuilder<ApiResponse<GameImages>>(
      stream: broadcastGameImagesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                // here we are showing loading view in waiting state.
                return Container(); //Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
            case Status.COMPLETED:
                return 
                Image.network(snapshot.data.data.images[1].imageurl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,);
            case Status.ERROR:
              return  Container(); //Text('error', style: TextStyle(color: Colors.black));
            case Status.PARTIAL:
              return  Container();//Text('partial', style: TextStyle(color: Colors.black));
              }
            }
          return Container();
      }),


                
              //Image.network(widget.game.fullImageUrl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,),
              
              ),), //Create bottom spacing
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.5, 0.7, 0.9], colors: [Colors.grey[900],Colors.grey[900].withOpacity(0.8),Colors.grey[900].withOpacity(0.6)])),
                height: 160,
                width: MediaQuery.of(context).size.width
              ),
              Positioned(top: 5, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), alignment: Alignment.topRight, onPressed: (){}),),
              Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Container(
                      height: 175,
                      child: Align( 
                        alignment: Alignment.centerRight,
                        child: Image.network(widget.game.imageUrl, height: 140,)
                      ),
                    ),
                  ),
                ]),
                Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                  AutoSizeText('${widget.game.name}', softWrap: true, maxLines: 2, minFontSize: 18, maxFontSize: 30, style: TextStyle(color: Colors.white),),
                  Text('By: Uwe Rosenbirth', style: TextStyle(color: Colors.white, fontSize: 10),),
                  SizedBox(height: 10,),
                  Text('${widget.game.boardGamePublisher}', style: TextStyle(color: Colors.white, fontSize: 14),),
                  Padding(padding: EdgeInsets.all(5),child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 26,),Text('${widget.game.rating}', style: Theme.of(context).textTheme.subtitle1)]),
                      Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 26),Text('${widget.game.minPlayers}-${widget.game.maxPlayers}',style: Theme.of(context).textTheme.subtitle1)]),
                      Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 26),Text('${widget.game.minPlaytime}-${widget.game.maxPlaytime}',style: Theme.of(context).textTheme.subtitle1)]),
                    ],
                  ),),
                ]),
              ]),
            ]),
          ]),

          
      Container( height: 363, child: ListView( scrollDirection: Axis.vertical, children: <Widget>[
      Container(height: 100, child:    
      StreamBuilder<ApiResponse<GameImages>>(
      stream: broadcastGameImagesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                // here we are showing loading view in waiting state.
                return Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
            case Status.COMPLETED:
                return 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.images.length,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    Image.network(snapshot.data.data.images[index].imageurl);
                    },);
            case Status.ERROR:
              return  Text('error', style: TextStyle(color: Colors.black));
            case Status.PARTIAL:
              return  Text('partial', style: TextStyle(color: Colors.black));
              }
            }
          return Container();
      }),),







          
            Container( height: 20,
              child:ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.game.mechanic.length,
              itemBuilder: (context, index){ return 
                Container(
                  height: 15,
                  decoration: BoxDecoration(color: widget._hashColors.getHashColors(widget.game.mechanic[index])[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5), child: Text('${widget.game.mechanic[index]}', style: Theme.of(context).textTheme.caption,),)
                );}
              ),),
            SizedBox(height:15),
            Align(alignment: Alignment.topLeft, child: Text('DESCRIPTION', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),),
            Row(children: <Widget>[
              Expanded(child:
                Stack(children: <Widget>[
                  Container(height: 150, child:Text('    ' + widget.game.description, softWrap: true,),),
                  Container(height: 150,decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.7, 1], colors: [Colors.white.withOpacity(0),Colors.white])),),
                  Container(height: 160, child:Align(alignment: Alignment.bottomRight, child: Text('READ MORE', style: TextStyle(color: Colors.black)),),),
              ])
              )
            ])
          ]),)


        ])
      )
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }  
}