import 'package:xml/xml.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';

class BoardGameResponse {
  //int totalResults;
  BoardGame result;
  
  BoardGameResponse.fromXml(XmlDocument doc) {
    //totalResults = doc.findAllElements('item').length;
    if (doc.findAllElements('boardgame').length != 0) {
      //results = <BoardGame>[];
      result = new BoardGame.fromNodeFullDetails(doc.findAllElements('boardgame').first);
    }
  }
}