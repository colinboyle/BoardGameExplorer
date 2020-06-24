//import 'package:video_player/video_player.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/GeekListDetail/GeekListDetail.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';

//import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GeekListCard extends StatelessWidget {
  final  geekListData;
  GeekListCard(this.geekListData);
  var _stringSplit = new GetSplitWords();
  //var _hashColors = new GetHashColors();
  
  @override 
  Widget build(BuildContext context){
    //_stringSplit.splitWords(geekListData.name);
    return
      InkWell(
      onTap: () {openGeekListDetail(context, geekListData.href, geekListData.numitems);},//openGame(context, geekListData);},
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
                    geekListData.title, 
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
                Text(geekListData.username),
                SizedBox(width: 10,),
                Icon(Icons.calendar_today, color: Colors.grey, size: 10),Text('${geekListData.postdate}'),
                SizedBox(width: 10,),
                Icon(Icons.list, color: Colors.grey, size: 10),Text(geekListData.numitems),
                SizedBox(width: 10,),
                Icon(Icons.thumb_up, color: Colors.grey, size: 10),Text(geekListData.numpositive),
              ]
            ),
          ],
        ),
      )
    );
  }
  openGeekListDetail(context,String geekListHref, String numItems){
    //print('Game id from onTap');
    //print(gameData.id);
    String id = geekListHref.split('/')[2];
    Navigator.push(context, MaterialPageRoute(builder: (context) => GeekListDetail(id,numItems)));
  }
}