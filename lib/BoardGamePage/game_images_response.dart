import 'dart:convert';

import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:xml/xml.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';

class GameImagesResponse {
  //int totalResults;
  GameImages result;
  
  GameImagesResponse.fromXml(XmlDocument doc) {
    //totalResults = doc.findAllElements('item').length;
    //if (doc.findAllElements('boardgame').length != 0) {
      //results = <BoardGame>[];
      //result = new BoardGame.fromNodeFullDetails(doc.findAllElements('boardgame').first);
    //}
  }

  GameImagesResponse.fromJSON(response){
    print('Response from GI response');
    print(response);
    result = new GameImages.fromJson(json.decode(response));
  }

}