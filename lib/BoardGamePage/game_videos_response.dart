import 'dart:convert';
import 'package:board_game_app/DataTypes/GameVideos.dart';

class GameVideosResponse {
  GameVideos result;

  GameVideosResponse.fromJSON(response){
    result = new GameVideos.fromJson(json.decode(response));
  }
}