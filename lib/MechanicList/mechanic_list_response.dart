import 'dart:convert';

import 'package:board_game_app/DataTypes/GameRecs.dart';

class MechanicListResponse {
  int totalResults;
  GameRecs results;
  
  MechanicListResponse.fromJson(response) {
    results = new GameRecs.fromJson(json.decode(response));
  }
}