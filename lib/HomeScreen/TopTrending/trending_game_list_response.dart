import 'package:xml/xml.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';

class TrendingGameListResponse {
  int totalResults;
  List<BoardGame> results;
  
  TrendingGameListResponse.fromXml(XmlDocument doc) {
    totalResults = doc.findAllElements('item').length;
    if (doc.findAllElements('item').length != 0) {
      results = new List<BoardGame>();
      doc.findAllElements('item').forEach((v) {
        print(v);
        results.add(new BoardGame.fromNode(v));
      });
    }
  }
}