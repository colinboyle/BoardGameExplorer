import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/MechanicList/MechanicList.dart';
import 'package:board_game_app/utils/getHashColors.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';

class TrendingGameCard extends StatelessWidget{
  final BoardGame gameData;
  TrendingGameCard(this.gameData);
  final _stringSplit = new GetSplitWords();
  final _hashColors = new GetHashColors();
  //final myGroup = AutoSizeGroup();

  @override 
  Widget build(BuildContext context){
    _stringSplit.splitWords(gameData.name);
    return InkWell(
      onTap: () {openGame(context, gameData);},
      child: 
      Container(width: 250, height: 150, decoration: BoxDecoration(color: Colors.white, ), margin: EdgeInsets.all(5), child:
        Stack(children: <Widget>[
          Padding( padding: EdgeInsets.only(left: 5), child:
            Row(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Image.network(gameData.imageUrl, width: 110, height: 120, fit: BoxFit.contain)
              ]),
              //SizedBox(width: 10),
              Expanded(child:
                Padding( padding: EdgeInsets.fromLTRB(15, 15, 15, 10), child: 
                  SizedBox(height: 120, child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      if(_stringSplit.firstWords != null) Row( children: [Expanded( child:AutoSizeText(_stringSplit.firstWords, maxLines: 1, wrapWords: false, style: TextStyle(fontSize: 14,color: Color.fromRGBO(21, 47, 90, 1)),))]),
                      Row( children: [Expanded( child:AutoSizeText(_stringSplit.lastWords, maxLines: 1, wrapWords: false, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Color.fromRGBO(21, 47, 90, 1))))]),
                      Row( children: [Expanded( child:AutoSizeText(gameData.boardGamePublisher, maxLines: 1, wrapWords: false, style: TextStyle(fontSize: 8, color: Colors.black54)))]),
                      Spacer(),
                      if(gameData.mechanic.length >= 2) ...[
                      Row(children: <Widget>[
                        Expanded( child: 
                          Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
                            GestureDetector(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicList(gameData.mechanic[0].id,gameData.mechanic[0].name)));},child:
                              Container(
                                height: 15,
                                decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.mechanic[0].name)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.mechanic[0].name}', style: Theme.of(context).textTheme.caption,),)
                              )
                            ),
                            GestureDetector(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => MechanicList(gameData.mechanic[1].id,gameData.mechanic[1].name)));},child:
                              Container(
                                height: 15,
                                decoration: BoxDecoration(color: _hashColors.getHashColors(gameData.mechanic[1].name)[0], borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Text('${gameData.mechanic[1].name}', style: Theme.of(context).textTheme.caption,),)
                              )
                            ),
                          ]),
                        ), 
                        //SizedBox(width: 25,)
                      ]),
                      ],
                      Spacer(),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 14,),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:'${gameData.rating}',style: TextStyle(fontSize: 7, color: Colors.black54)),TextSpan(text:'\nstars', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                        Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 14),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:gameData.recPlayers, style: TextStyle(fontSize: 7, color: Colors.black54)), TextSpan(text:'\nplayers', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                        Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 14),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:gameData.recPlaytime,style: TextStyle(fontSize: 7, color: Colors.black54)),TextSpan(text:'\nmins', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                      ]),
                    ])
                  )
                )
              ),
            ]),
          ),
          //
          //Removed Favorite button
          //
          //Positioned(top: 0, left: 0, child: GestureDetector( onTap: () {}, child: Container(width: 30, height: 30, decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),child: Icon(Icons.favorite_border, color: Colors.black, size: 15,)))),
          if(gameData.ranks.length > 0 && gameData.ranks[0].value != 'Not Ranked' && int.parse(gameData.ranks[0].value) < 1000) ...[
            Positioned(top: 0, right: 5, child: Row(children: [Container(decoration: BoxDecoration(color: Colors.grey[200] ,borderRadius: BorderRadius.all(Radius.circular(5))) , child: Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5) ,child:Text('Overall: ${gameData.ranks[0].value}')))]))
          ]
        ])
      )
    );
  }
  openGame(context,BoardGame gameData){
    print('Game id from onTap');
    print(gameData.id);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.id, gameData, false)));
  }
}
