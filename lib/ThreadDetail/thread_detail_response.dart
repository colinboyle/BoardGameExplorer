import 'dart:convert';

import 'package:board_game_app/DataTypes/Thread.dart';

class ThreadDetailResponse {
  Thread results;
  ThreadDetailResponse.fromJson( doc) {
    results = new Thread.fromJson(json.decode(doc));
  }
}