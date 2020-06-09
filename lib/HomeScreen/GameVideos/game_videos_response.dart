import 'dart:convert';

import 'package:board_game_app/DataTypes/GameVideos.dart';

class GameVideosResponse {
  GameVideos results;
  
  GameVideosResponse.fromJSON(dynamic response) {
    results = new GameVideos.fromJson(json.decode(response));
  }
}