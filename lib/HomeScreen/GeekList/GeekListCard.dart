//import 'package:video_player/video_player.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/DataTypes/GeekList.dart';
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
      onTap: () {},//openGame(context, geekListData);},
      child: 
      Container(height: 50, decoration: BoxDecoration(color: Colors.white, ), margin: EdgeInsets.all(5), child:
        Text(geekListData.title)
      )
    );
  }
  //openGame(context,BoardGame gameData){
  //  print('Game id from onTap');
  //  print(gameData.id);
  //  Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.id, gameData, false)));
  //}
}