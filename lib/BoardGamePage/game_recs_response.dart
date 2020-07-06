import 'dart:convert';

import 'package:board_game_app/DataTypes/GameRecs.dart';

class GameRecsResponse {
  GameRecs result;

  GameRecsResponse.fromJSON(response){
    result = new GameRecs.fromJson(json.decode(response));
  }

}