import 'dart:convert';
import 'package:xml/xml.dart';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewReleases.dart';

class NewReleasesResponse {
  NewReleases results;
  int totalResults;
  List<BoardGame> gameListResults;
  
  NewReleasesResponse.fromJSON(dynamic response) {
    results = new NewReleases.fromJson(json.decode(response));
  }

  NewReleasesResponse.fromXmlGameDataList(XmlDocument doc) {
    totalResults = doc.findAllElements('item').length;
    if (totalResults != 0) {
      gameListResults = new List<BoardGame>();
      doc.findAllElements('item').forEach((v) {
        gameListResults.add(new BoardGame.fromNodeFullDetails(v));
      });
    }
  }
}