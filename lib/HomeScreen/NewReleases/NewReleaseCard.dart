//import 'package:video_player/video_player.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewReleaseCard extends StatelessWidget {
  final BoardGame gameData;
  NewReleaseCard(this.gameData);
  var _stringSplit = new GetSplitWords();
  //var _hashColors = new GetHashColors();
  
  @override 
  Widget build(BuildContext context){
    _stringSplit.splitWords(gameData.name);
    //.getHashColors('hundred');
    //List<Color> bgColors = _hashColors.getHashColors('hashString');
    //print('Testing ids');
    //print(gameData.id);
    return
      InkWell(
        onTap: () {openGame(context, gameData);},
        child: Container(
          width: 285,
          height: 190,
          decoration: BoxDecoration(color: Colors.white, ),//boxShadow: [new BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(5,5))]),
          margin: EdgeInsets.all(5),
          child:
            Stack(
              children: <Widget>[
                Positioned(top: 15, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), alignment: Alignment.topRight, onPressed: (){}),),
                Padding( padding: EdgeInsets.all(5), child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: <Widget>[
                        Image.network(gameData.imageUrl, width: 110,)
                      ],
                    ),
                    SizedBox(width: 10),
                    //Padding(padding: EdgeInsets.all(5), child:
                    Expanded(
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 30,),
                          //Spacer(),
                          Container( child:
                          //LimitedBox( maxHeight: 90, child:
                          Column(children: <Widget>[
                            if(_stringSplit.firstWords != null) Container(width: 100,child: AutoSizeText( _stringSplit.firstWords, maxLines: 2, wrapWords: false, style: Theme.of(context).textTheme.headline2)),
                            Container(width: 110,child: AutoSizeText(_stringSplit.lastWords, maxLines: 1, wrapWords: false, style: Theme.of(context).textTheme.headline3)),
                            Container(width: 110,child: AutoSizeText(gameData.boardGamePublisher, maxLines: 1, wrapWords: false, style: TextStyle(fontSize: 13, color: Colors.black54))),
                          ],),),
                          //TextSpan(text: _stringSplit.firstWords + '\n', style: Theme.of(context).textTheme.headline2),
                          //TextSpan(text: _stringSplit.lastWord, style: Theme.of(context).textTheme.headline3),
                          //TextSpan(text: '\n${gameData.boardGamePublisher}', style: TextStyle(fontSize: 13, color: Colors.black54),),
                            //]),
                            //presetFontSizes: [22,18,16,12],
                          //wrapWords: false,
                          //),
                          //Row(children: <Widget>[
                            //Spacer(),
                            //Wrap(
                            //alignment: WrapAlignment.center,
                            //runAlignment: WrapAlignment.center,
                            //children: <Widget>[
                            //  GestureDetector(onTap: (){print('no category page');},child:
                            //    Container(
                            //      //width: 25,
                            //      height: 15,
                            //      decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.category.first)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                            //      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.category.first}', style: Theme.of(context).textTheme.caption,),)
                            //  )),
                            //  GestureDetector(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicList(gameData.mechanic.first.id,gameData.mechanic.first.name)));},child:
                            //    Container(
                            //      //width: 25,
                            //      height: 15,
                            //      decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.mechanic.first.name)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                            //      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.mechanic.first.name}', style: Theme.of(context).textTheme.caption,),)
                            //  )),
                          //],),
                          //],),   //),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 20,),Text('${gameData.rating}', style: Theme.of(context).textTheme.caption)]),
                              Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 20),Text('${gameData.minPlayers}-${gameData.maxPlayers}',style: Theme.of(context).textTheme.caption)]),
                              Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 20),Text('${gameData.minPlaytime}-${gameData.maxPlaytime}',style: Theme.of(context).textTheme.caption)]),
                            ],
                          ),
                          Spacer(),
                          SizedBox(height: 10,),
                        ],
                      )
                    ),
                      //],
                    //),
                  ],
                ),)
              ],
            )
      )
    );
  }
  openGame(context,BoardGame gameData){
    print('Game id from onTap');
    print(gameData.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.id, gameData, false)));
  }
}