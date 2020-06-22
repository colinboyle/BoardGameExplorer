//import 'package:video_player/video_player.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/DataTypes/HotDeal.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HotDealCard extends StatelessWidget {
  final  hotDealData;
  HotDealCard(this.hotDealData);
  //var _stringSplit = new GetSplitWords();
  //var _hashColors = new GetHashColors();
  
  @override 
  Widget build(BuildContext context){
    //_stringSplit.splitWords(geekListData.name);
    return
      InkWell(
      onTap: () {},//openGame(context, geekListData);},
      child: 
      Container(
        height: 52, 
        decoration: BoxDecoration(color: Colors.white, ), 
        margin: EdgeInsets.symmetric(horizontal: 5), 
        padding: EdgeInsets.all(5),
        child:
        Column(
          children: <Widget>[
            Row( 
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width -20,
                  child: AutoSizeText(
                    hotDealData.subject, 
                    maxLines: 2, 
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ]
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Text(hotDealData.user.username),
                SizedBox(width: 10,),
                Icon(Icons.calendar_today, color: Colors.grey, size: 10),Text('${hotDealData.threadPostdate}'),
                //SizedBox(width: 10,),
                //Icon(Icons.list, color: Colors.grey, size: 10),Text(hotDealData.numitems),
                SizedBox(width: 10,),
                Icon(Icons.thumb_up, color: Colors.grey, size: 10),Text('${hotDealData.numrecommend.toString()}'),
              ]
            ),
          ],
        ),
      )
    );
  }
  //openGame(context,BoardGame gameData){
  //  print('Game id from onTap');
  //  print(gameData.id);
  //  Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.id, gameData, false)));
  //}
}