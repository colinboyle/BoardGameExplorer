import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/utils/getHashColors.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';

class TrendingGameCard extends StatelessWidget{
  final BoardGame gameData;
  TrendingGameCard(this.gameData);
  var _stringSplit = new GetSplitWords();
  var _hashColors = new GetHashColors();
  
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
          decoration: BoxDecoration(color: Colors.white, boxShadow: [new BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(5,5))]),
          margin: EdgeInsets.all(5),
          child:
            Stack(
              children: <Widget>[
                Positioned(top: 15, right: 10, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), alignment: Alignment.topRight, onPressed: (){}),),
                Row(
                  children: <Widget>[
                   // Stack(
                      //children: <Widget>[
                        //Positioned(top: 10, right: 35, child:IconButton(icon: Icon(Icons.favorite_border, color: Colors.black), alignment: Alignment.topRight, onPressed: (){}),),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center, 
                          children: <Widget>[
                            Image.network(gameData.imageUrl, width: 130,)
                          ],
                        ),
                        SizedBox(width: 10),
                        //Padding(padding: EdgeInsets.all(5), child:
                        Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(height: 10,),
                              AutoSizeText.rich(
                                TextSpan( children: [
                                  if(_stringSplit.firstWords != null) TextSpan(text: _stringSplit.firstWords + '\n', style: TextStyle(color: Colors.black, fontSize: 18)),
                                  TextSpan(text: _stringSplit.lastWord, style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w800)),
                                  TextSpan(text: '\n${gameData.boardGamePublisher}', style: TextStyle(fontSize: 13, color: Colors.black54),),
                                ],
                                style: TextStyle(fontSize: 200),
                              ),
                                minFontSize: 0,
                                stepGranularity: 0.1,
                              ),                       
                             //Row(
                             //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                             //   children: <Widget>[
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    children: <Widget>[
                                    Container(
                                      //width: 25,
                                      height: 15,
                                      decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.category.first)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.category.first}', style: Theme.of(context).textTheme.caption,),)
                                    ),
                                    Container(
                                      //width: 25,
                                      height: 15,
                                      decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.mechanic.first)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                                      child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.mechanic.first}', style: Theme.of(context).textTheme.caption,),)
                                    ),
                                  ],
                                  ),
                              //  ],
                              //),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 20,),Text('${gameData.rating}', style: Theme.of(context).textTheme.caption)]),
                                  Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 20),Text('${gameData.minPlayers}-${gameData.maxPlayers}',style: Theme.of(context).textTheme.caption)]),
                                  Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 20),Text('${gameData.minPlaytime}-${gameData.maxPlaytime}',style: Theme.of(context).textTheme.caption)]),
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          )
                        ),
                      //],
                    //),
                  ],
                ),
              ],
            )
      )
    );
  }
  openGame(context,BoardGame gameData){
    print('Game id from onTap');
    print(gameData.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData, false)));
  }
}
