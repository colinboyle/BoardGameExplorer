import 'package:xml/xml.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';

class GameDetailResponse {
  //int totalResults;
  BoardGame result;
  
  GameDetailResponse.fromXml(XmlDocument doc) {
    //totalResults = doc.findAllElements('item').length;
    //print('Printing result and doc');
    //print(result);
    if (doc.findAllElements('item').length != 0) {
      result = new BoardGame.fromNodeFullDetails(doc.findAllElements('item').first);
      //print(doc);
  }
}
}