import 'dart:convert';

import 'package:board_game_app/DataTypes/HotDealList.dart';

class HotDealListResponse {
  HotDealList results;
  
  HotDealListResponse.fromJSON(dynamic response) {
    results = new HotDealList.fromJson(json.decode(response));
  }
}