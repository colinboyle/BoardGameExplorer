import 'dart:convert';

//import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';

class GameRecsResponse {
  //int totalResults;
  GameRecs result;

  GameRecsResponse.fromJSON(response){
    //print('Response from GI response');
    //print(response);
    result = new GameRecs.fromJson(json.decode(response));
  }

}