import 'dart:ui';

import 'package:board_game_app/DataTypes/MarketOffers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/utils/api_response.dart';
import 'package:board_game_app/utils/getHashColors.dart';
import 'package:board_game_app/Layout/CustomSearchBar.dart';

import 'package:board_game_app/BoardGamePage/board_game_page_bloc.dart';

class BoardGamePage extends StatefulWidget {
  BoardGame game;
  bool needFullInfo;
  String gameid;
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
  var gameRecsStream;
  var marketOffersStream;
  //Future<BoardGame> futureBoardGame;

  _BoardGamePageState();//this.title, this.url);

  @override
  void initState() {
    super.initState();
    _bloc = BoardGamePageBloc(widget.game.id);
    broadcastGameImagesStream = _bloc.gameImagesStream.asBroadcastStream();
    gameRecsStream = _bloc.gameRecsStream;
    marketOffersStream = _bloc.marketOffersStream;
    //_bloc.fetchGameImages(widget.game.id);
    //futureBoardGame = _bloc.fetchBoardGame(widget.game.id);
    //_hashColors = new GetHashColors();
  }

  openGame(context, String href) async{
    print('Game id from onTap no game data');
    String id = href.split('/')[2];
    print(id);
    BoardGame game = await _bloc.fetchGameDetails(id);
    //print(game.name);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(game, false)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: <Widget>[
          SearchSection(),
          //Container( width: MediaQuery.of(context).size.width, child: 
          //Row( mainAxisSize: MainAxisSize.max, children: <Widget>[
          Container(child:
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
                              return Container();
                          case Status.COMPLETED:
                              return 
                              Image.network(snapshot.data.data.images[1].imageurl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,);
                          case Status.ERROR:
                            return  Container();
                          case Status.PARTIAL:
                            return  Container();
                            }
                          }
                        return Container();
                    }
                  ),
                ),
              ), //Create bottom spacing
              Container(
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.5, 0.7, 0.9], colors: [Colors.grey[900],Colors.grey[900].withOpacity(0.8),Colors.grey[900].withOpacity(0.6)])),
                height: 160,
                width: MediaQuery.of(context).size.width
              ),
              //TO DO: Add to favorite list to view
              Positioned(top: 5, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), alignment: Alignment.topRight, onPressed: (){}),),
              Container( width: MediaQuery.of(context).size.width, child:
              Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Container(
                      height: 175,
                      //child: Align( 
                        //alignment: Alignment.centerRight,
                        child: LimitedBox( maxWidth: 140, child:Image.network(widget.game.imageUrl, height: 140,))
                      //),
                    ),
                  ),
                ]),
                Spacer(),
                Container(child:
                //Expanded( child: Align( alignment: Alignment.center,child:
                Column(mainAxisSize: MainAxisSize.max, //mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, 
                children: <Widget>[
                  AutoSizeText('${widget.game.name}', softWrap: true, maxLines: 2, style: TextStyle(color: Colors.white),),
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
                ]),),
                Spacer()//,),),
              ]),
              ),
            ]),
          ),
          Container(height: 363, child: 
            ListView( scrollDirection: Axis.vertical, children: <Widget>[
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
                              return GestureDetector( 
                                onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {return DetailScreen(tag: '$index', url: snapshot.data.data.images[index].imageurlLg);}));
                                },
                                child: Hero( tag: '$index', child: Image.network(snapshot.data.data.images[index].imageurlLg)));
                              },
                          );
                      case Status.ERROR:
                        return  Text('error', style: TextStyle(color: Colors.black));
                      case Status.PARTIAL:
                        return  Text('partial', style: TextStyle(color: Colors.black));
                    }
                  }
                  return Container();
                }),
              ),
              Container( height: 40,
                child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.game.mechanic.length,
                itemBuilder: (context, index){ return 
                  Padding( padding: EdgeInsets.symmetric(vertical: 10.0), child:
                  Container(
                    height: 15,
                    decoration: BoxDecoration(color: widget._hashColors.getHashColors(widget.game.mechanic[index])[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5), child: Text('${widget.game.mechanic[index]}', style: Theme.of(context).textTheme.caption,),)
                  ));
                }),
              ),
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
              ]),
              //Container(height: 100, color: Colors.green,),
              Text('RECOMMENDED', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
              StreamBuilder<ApiResponse<GameRecs>>(
                stream: gameRecsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                          // here we are showing loading view in waiting state.
                          return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
                      case Status.COMPLETED:
                          if(snapshot.data.data.numrecs > 0){

                           return  Container( height: 100, child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.data.numrecs,
                              itemBuilder:  (BuildContext context, int index){ 
                                return 
                                InkWell(
                                  onTap: (){openGame(context, snapshot.data.data.recs[index].recitem.item.href);},
                                  child:Container(width: 100,child:
                                  Padding(padding: EdgeInsets.all(3), child:
                                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                                      Image.network(snapshot.data.data.recs[index].recitem.item.images.square200, height: 100,),
                                      Container(constraints: BoxConstraints.tightFor(height: 30),color: Colors.black45, child: Center(child: AutoSizeText(snapshot.data.data.recs[index].recitem.item.primaryname.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),))
                                    ],)
                                  ),
                                 ),);
                              }));} 
                              return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No recommendations found'),),);
                          //Text('${snapshot.data.data.recs[0].recitem.item.primaryname.name}', style: TextStyle(color: Colors.black, fontSize: 12));//Image.network(snapshot.data.data.images[1].imageurl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,);
                      case Status.ERROR:
                        return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('error', style: TextStyle(color: Colors.black));
                      case Status.PARTIAL:
                        return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));//Text('partial', style: TextStyle(color: Colors.black));
                    }
                  }
                return Container();
                }
              ),
              Text('MARKET OFFERS', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
              StreamBuilder<ApiResponse<MarketOffers>>(
                stream: marketOffersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                          // here we are showing loading view in waiting state.
                          return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
                      case Status.COMPLETED:
                          if(snapshot.data.data.config.numitems > 0){

                           return  Container( height: 100, child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.data.products.length,
                              itemBuilder:  (BuildContext context, int index){ 
                                return 
                                InkWell(
                                  onTap: (){print('thanks for pressing');}, //openGame(context, snapshot.data.data.recs[index].recitem.item.href);},
                                  child:Container(width: 100,child:
                                  Padding(padding: EdgeInsets.all(3), child:
                                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                                      //Image.network(snapshot.data.data.recs[index].recitem.item.images.square200, height: 100,),
                                      Container(constraints: BoxConstraints.tightFor(height: 30),color: Colors.black45, child: Center(child: AutoSizeText(snapshot.data.data.products[index].price, textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),))
                                    ],)
                                  ),
                                 ),);
                              }));} 
                              return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No recommendations found'),),);
                          //Text('${snapshot.data.data.recs[0].recitem.item.primaryname.name}', style: TextStyle(color: Colors.black, fontSize: 12));//Image.network(snapshot.data.data.images[1].imageurl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,);
                      case Status.ERROR:
                        return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('error', style: TextStyle(color: Colors.black));
                      case Status.PARTIAL:
                        return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));//Text('partial', style: TextStyle(color: Colors.black));
                    }
                  }
                return Container();
                }
              ),
            ])
          ),
        ]),
      )
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }  
}


class DetailScreen extends StatefulWidget {
  final String tag;
  final String url;

  DetailScreen({Key key, @required this.tag, @required this.url})
      : assert(tag != null),
        assert(url != null),
        super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
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
        body: Center(
          child: Hero(
            tag: widget.tag,
            child: CachedNetworkImage(
              imageUrl: widget.url,
              placeholder: _loader,//Container(width: 32, height: 32,child: new CircularProgressIndicator()), //need center
              errorWidget: _error,//new Icon(Icons.error),
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}

Widget _loader(BuildContext context, String url) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _error(BuildContext context, String url, dynamic error) {
  print(error);
  return const Center(child: Icon(Icons.error));
}

class SearchSection extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return
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
    );
  }
}

class GameRecList extends StatelessWidget {
  GameRecs games;
  int numRecs;

  GameRecList(this.games, this.numRecs);
  @override 
  Widget build(BuildContext context) {
    return Text('nah');

  }
}

