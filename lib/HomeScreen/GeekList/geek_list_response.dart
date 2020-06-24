import 'dart:convert';
//import 'package:xml/xml.dart';

//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekLists.dart';

class GeekListResponse {
  GeekLists results;
  //int totalResults;
  //List<BoardGame> gameListResults;
  
  GeekListResponse.fromJSON(dynamic response) {
    results = new GeekLists.fromJson(json.decode(response));
  }

  //GeekListResponse.fromXmlGameDataList(XmlDocument doc) {
  //  totalResults = doc.findAllElements('item').length;
  //  if (totalResults != 0) {
  //    gameListResults = new List<BoardGame>();
  //    doc.findAllElements('item').forEach((v) {
  //      gameListResults.add(new BoardGame.fromNodeFullDetails(v));
  //    });
  //  }
  //}
}