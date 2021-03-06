import 'dart:ui';

//import 'package:board_game_app/Common/Skeleton.dart';
import 'package:board_game_app/DataTypes/GameVideos.dart';
import 'package:board_game_app/DataTypes/MarketOffers.dart';
import 'package:board_game_app/HomeScreen/GameVideos/GameVideoCard.dart';
import 'package:board_game_app/MechanicList/MechanicList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/utils/api_response.dart';
import 'package:board_game_app/utils/getHashColors.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';

import 'package:board_game_app/BoardGamePage/board_game_page_bloc.dart';
import 'package:board_game_app/Common/ExpandableText.dart';

class BoardGamePage extends StatefulWidget {
  final BoardGame gameData;
  final bool needFullInfo;
  final String gameid;
  final _hashColors = new GetHashColors();

  BoardGamePage(this.gameid, this.gameData, this.needFullInfo);

  @override
  _BoardGamePageState createState() => _BoardGamePageState();
}

class _BoardGamePageState extends State<BoardGamePage> {
  BoardGame game;
  BoardGamePageBloc _bloc;
  String loadingMessage;
  String errorMessage;
  bool readingMore = false;
  var broadcastGameImagesStream;
  var gameRecsStream;
  var marketOffersStream;
  var gameVideosStream;

  _BoardGamePageState();

  @override
  void initState() {
    setState(() {
      game = widget.gameData;
    });
    if(widget.needFullInfo){
      super.initState();
      _bloc = BoardGamePageBloc(widget.gameid);
      broadcastGameImagesStream = _bloc.gameImagesStream.asBroadcastStream();
      gameRecsStream = _bloc.gameRecsStream;
      marketOffersStream = _bloc.marketOffersStream; 
      gameVideosStream = _bloc.gameVideosStream;
      getGameData(widget.gameid);
    } else {
      super.initState();
      _bloc = BoardGamePageBloc(game.id);
      broadcastGameImagesStream = _bloc.gameImagesStream.asBroadcastStream();
      gameRecsStream = _bloc.gameRecsStream;
      marketOffersStream = _bloc.marketOffersStream; 
      gameVideosStream = _bloc.gameVideosStream;
    }
  }

  getGameData(id) async {
    BoardGame finalgame = await _bloc.fetchGameDetails(id);
    setState((){
      game = finalgame;
    });
  }

  _launchInBrowser(String url) async {
    if (await canLaunch('https://boardgamegeek.com'+url)) {
      await launch(
        'https://boardgamegeek.com'+url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      throw 'Could not launch $url';
    }

  }

  openGame(context, String href) async{
    String id = href.split('/')[2];
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(id, null, true)));
  }

  @override
  Widget build(BuildContext context) {
    if(game == null){
      return LoadingGamePage();
    }
    return 
    Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(191, 199, 209, 1),
      body:Stack( children: <Widget>[
        Column(children: <Widget>[
          SizedBox(height: 100,),
          Container(
            child:
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
                            if(snapshot.data.data.images.length > 2){
                              return Image.network(snapshot.data.data.images[1].imageurl, fit: BoxFit.fill, width: MediaQuery.of(context).size.width/1.8 ,);
                            }
                            return Container();
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
              ), 
              Container(
                decoration: BoxDecoration(color: Colors.black, gradient: RadialGradient(radius: 2.3,center: Alignment(.9,0), stops: [0, 0.2, 0.3, 0.6], colors: [Colors.grey[900].withOpacity(0.7),Colors.grey[900].withOpacity(0.8),Colors.grey[900].withOpacity(.95),Colors.grey[900]])),
                height: 160,
                width: MediaQuery.of(context).size.width
              ),
              //TO DO: Add to favorite list to view
              //Removed favorite
              //Positioned(top: 5, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), alignment: Alignment.topRight, onPressed: (){}),),
              Container( width: MediaQuery.of(context).size.width, child:
              Row(
              children: <Widget>[
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                    child: Container(
                      height: 175,
                        child: Container( width: 140, child: LimitedBox( maxWidth: 140, child:Image.network(game.imageUrl, height: 140,)))
                      
                    ),
                  ),
                ]),
                Spacer(),
                Container(height: 160,child:
                Column(mainAxisSize: MainAxisSize.min, 
                children: <Widget>[
                  Spacer(),
                  Container( width: 200, child: 
                    AutoSizeText('${game.name} (${game.yearPublished})',maxFontSize: 22, presetFontSizes: [18,16] ,textAlign: TextAlign.center,softWrap: true, maxLines: 2, style: TextStyle( color: Colors.white),),
                  ),
                  Text('By: ${game.designer}', style: TextStyle(color: Colors.white, fontSize: 10),),
                  SizedBox(height: 10,),
                  AutoSizeText('${game.boardGamePublisher}',maxFontSize: 12 ,textAlign: TextAlign.center,softWrap: true, maxLines: 2, style: TextStyle(fontSize: 12, color: Colors.white),),
                  Container( width: 200, child:
                  Padding(padding: EdgeInsets.all(5),child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 20,),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:'${game.rating}',style: Theme.of(context).textTheme.subtitle1),TextSpan(text:'\nstars', style: TextStyle(fontSize: 8, color: Colors.white))]))]),
                      Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 20),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:game.recPlayers, style: Theme.of(context).textTheme.subtitle1), TextSpan(text:'\nplayers', style: TextStyle(fontSize: 8, color: Colors.white))]))]),
                      Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 20),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:game.recPlaytime,style: Theme.of(context).textTheme.subtitle1),TextSpan(text:'\nmins', style: TextStyle(fontSize: 8, color: Colors.white))]))]),
                      Column(children: <Widget>[Icon(Icons.person, color: Colors.grey, size: 20),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:'${game.age}+',style: Theme.of(context).textTheme.subtitle1),TextSpan(text:'\nyears', style: TextStyle(fontSize: 8, color: Colors.white))]))]),
                    ],
                  ),),),
                  //Positioned( child: 
                  Expanded( child: Align(alignment: Alignment.bottomCenter, child: GestureDetector(onTap: (){_launchInBrowser('/boardgame/${game.id}');}, child: Container(alignment: Alignment.center,width: 100, height: 25, decoration: BoxDecoration(color: Colors.blue[900],borderRadius: BorderRadius.all(Radius.circular(10))), child: Text('Visit on BGG', textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle1)))))
                ]),),
                Spacer()//,),),
              ]),
              ),
            ]),
          ),
          Container(height: MediaQuery.of(context).size.height -285, child: 
          SingleChildScrollView( scrollDirection: Axis.vertical, child:
            Column( 
            children: <Widget>[
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
                itemCount: game.mechanic.length,
                itemBuilder: (context, index){ return 
                  Padding( padding: EdgeInsets.symmetric(vertical: 10.0), child:
                  GestureDetector(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicList(game.mechanic[index].id, game.mechanic[index].name)));},child:
                  Container(
                    height: 15,
                    decoration: BoxDecoration(color: widget._hashColors.getHashColors(game.mechanic[index].name)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5), child: Text('${game.mechanic[index].name}', style: Theme.of(context).textTheme.caption,),)
                  )));
                }),
              ),
              Container(height: 20,),
              Align(alignment: Alignment.topLeft, child: Text('DESCRIPTION', style: Theme.of(context).textTheme.headline2)),
              Row(
                children: <Widget>[
                Expanded(child:
                Padding(padding: EdgeInsets.all(10), child:
                    Container( 
                      child:
                    Stack(
                      children: <Widget>[
                        Container(color: Color.fromRGBO(245,246,247,1), child:Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0) , child: ExpandableText(game.description),),),
                  ])))
                )
              ]),
              Container(height: 20,),
              Align(alignment: Alignment.topLeft, child: Text('TOP VIDEOS', style: Theme.of(context).textTheme.headline2)),
              Container(
                height: 150,
                child: StreamBuilder<ApiResponse<GameVideos>>(
                  stream: gameVideosStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data.status) {
                        case Status.LOADING:
                            return Text('Loading...', style: TextStyle(color: Colors.black));
                        case Status.COMPLETED:
                        if(snapshot.data.data.videos.length > 0) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.data.videos.length,
                            itemBuilder: (BuildContext context, int index){ 
                              return 
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                //width: 200, 
                                child: Container( color: Colors.grey[400], child: new GameVideoCard(snapshot.data.data.videos[index], 250, 160))
                              );
                            },
                          );
                        }
                        return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                //width: 200, 
                                child: Container( color: Colors.blueGrey[100], child: Center(child: Text("No videos found"),))
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
              Container(height: 20,),
              Align(alignment: Alignment.topLeft, child: Text('MARKET OFFERS', style: Theme.of(context).textTheme.headline2),),
              StreamBuilder<ApiResponse<MarketOffers>>(
                stream: marketOffersStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                          // here we are showing loading view in waiting state.
                          return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12));
                      case Status.COMPLETED:
                          if(snapshot.data.data.config.numitems > 0){

                           return  Container( height: 100, child:ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data.data.products.length,
                              itemBuilder:  (BuildContext context, int index){ 
                                return 
                                InkWell(
                                  onTap: (){_launchInBrowser(snapshot.data.data.products[index].producthref);},
                                  child:Container(width: 100,child:
                                  Padding(padding: EdgeInsets.all(3), child:
                                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                                      snapshot.data.data.products[index].images != null && snapshot.data.data.products[index].images[0].canonicalLink != null ? Image.network(snapshot.data.data.products[index].images[0].images.square200.url, height: 100,) : Container(color: widget._hashColors.getHashColors(snapshot.data.data.products[index].prettycondition)[4], child: Center(child:Text(snapshot.data.data.products[index].prettycondition, style: TextStyle(color: widget._hashColors.getHashColors(snapshot.data.data.products[index].prettycondition)[2], fontSize: 18, fontWeight: FontWeight.w800)) )),
                                      Container(constraints: BoxConstraints.tightFor(height: 30),color: Colors.black54, child: Center(child: AutoSizeText('${snapshot.data.data.products[index].currencysymbol}${snapshot.data.data.products[index].price}', textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),)),
                                      Positioned(right: 3, top: 3, child: Container( alignment: Alignment.center , width: 20, height: 20, decoration: BoxDecoration(color: widget._hashColors.getHashColors(snapshot.data.data.products[index].prettycondition)[2], borderRadius: BorderRadius.all(Radius.circular(10))), child: Text(snapshot.data.data.products[index].conditioncode.toUpperCase(), textAlign: TextAlign.center,))),
                                      Positioned(left: 3, top: 3, child: Image.network(snapshot.data.data.products[index].flagimgurl, width: 20, height: 20,)),
                                    ],)
                                  ),
                                 ),);
                              }));} 
                              return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No offers available'),),);
                      case Status.ERROR:
                        return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12));
                      case Status.PARTIAL:
                        return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));
                    }
                  }
                return Container();
                }
              ),
              Container(height: 20,),
              Align(alignment: Alignment.topLeft, child: Text('RECOMMENDATIONS', style: Theme.of(context).textTheme.headline2),),//TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
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
                                  onTap: (){openGame(context, snapshot.data.data.recs[index].item.href);},
                                  child:Container(width: 100,child:
                                  Padding(padding: EdgeInsets.all(3), child:
                                    Stack(alignment: Alignment.bottomCenter, children: <Widget>[
                                      Image.network(snapshot.data.data.recs[index].item.imageSets.square100.src, height: 100,),
                                      Container(constraints: BoxConstraints.tightFor(height: 30),color: Colors.black54, child: Center(child: AutoSizeText(snapshot.data.data.recs[index].item.name, textAlign: TextAlign.center, style: TextStyle(color: Colors.white,)),))
                                    ],)
                                  ),
                                 ),);
                              }));} 
                              return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No recommendations found'),),);
                      case Status.ERROR:
                        return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12));
                      case Status.PARTIAL:
                        return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));
                    }
                  }
                return Container();
                }
              ),
            ])
          ),
          ),
        ]),
        CustomSearchBar(false),
      ]
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
              placeholder: _loader,
              errorWidget: _error,
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
              child:CustomSearchBar(false)
            ),
          ],
        ),
      ],
    );
  }
}

class LoadingGamePage extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return 
    Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(191, 199, 209, 1),
      body:Stack( children: <Widget>[
        Column(children: <Widget>[
            SearchSection(),
            Container(child:
                Stack(children: <Widget>[
                   Container(
                    decoration: BoxDecoration(color: Colors.black, gradient: RadialGradient(radius: 2.5,center: Alignment(.9,0), stops: [0, 0.2, 0.3, 0.6, 1], colors: [Colors.grey[900].withOpacity(0.7),Colors.grey[900].withOpacity(0.8),Colors.grey[900].withOpacity(.90),Colors.grey[900].withOpacity(.95), Colors.grey[900]])),
                    height: 160,
                    width: MediaQuery.of(context).size.width
                  ),
                  //
                  //Removed favorite
                  //
                  //Positioned(top: 5, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.white), alignment: Alignment.topRight, onPressed: (){}),),
                  Container( width: MediaQuery.of(context).size.width, child:
                  Row(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0, 0),
                        child: Container(
                          height: 125,
                          width: 100,
                          color: Colors.grey[400]
                        ),
                      ),
                    ]),
                    Spacer(),
                    Shimmer.fromColors(
                      baseColor: Colors.black54,
                      highlightColor: Colors.black38,
                      loop: 15,
                      child:
                    Column(mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Container( width: 200, height: 30, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                      SizedBox(height: 10,),
                      Container( width: 200, height: 20, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                      SizedBox(height: 10,),
                      Container( width: 120, height: 25, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                      Container( width: 200, child:
                      Padding(padding: EdgeInsets.all(5),child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container( width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                          Container( width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                          Container( width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                        ],
                      ),),),
                    ]),),
                    Spacer()
                  ]),
                  ),
                ]),
              ),
            Shimmer.fromColors(
              baseColor: Colors.black54,
              highlightColor: Colors.black38,
              loop: 15,
              child:
            
            Container(height: 363, child: 
              ListView( scrollDirection: Axis.vertical, children: <Widget>[
                Container(height: 100, child:    
                  ListView(
                    children: <Widget>[Container(width: 100, height: 50, color: Colors.grey[400],),Container( width: 200, height: 20, color: Colors.grey[400],),Container( width: 200, height: 20, color: Colors.grey[400]),],)
                ),
                Container( height: 40,
                  child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 9,
                  itemBuilder: (context, index){ return 
                    Padding( padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15), child:
                      Container(width: 50, height: 15, decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10)))),
                    );
                  }),
                ),
                SizedBox(height:15),
                Align(alignment: Alignment.topLeft, child: Text('DESCRIPTION', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),),
                Row(children: <Widget>[
                  Container( width: MediaQuery.of(context).size.width, height: 200, color: Colors.grey[400]),
                ]),
                Text('RECOMMENDED', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                Container( height: 100, color: Colors.grey[400],),
                Text('MARKET OFFERS', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                Container( height: 100, color: Colors.grey[400],),
              ])
            ),)
          ]),
        CustomSearchBar(false),
      ]), 
    );
  } 
}

