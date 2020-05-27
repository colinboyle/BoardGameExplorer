//import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_repository.dart';
import 'package:xml/xml.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';

class TrendingGameListResponse {
  int totalResults;
  List<BoardGame> results;
  BoardGame resultExtraData;
  
  TrendingGameListResponse.fromXml(XmlDocument doc) {
    totalResults = doc.findAllElements('item').length;
    if (totalResults != 0) {
      results = new List<BoardGame>();
      doc.findAllElements('item').forEach((v) {
        //TrendingGameListRepository.fetchTrendingGameData("1000");
        results.add(new BoardGame.fromNode(v));
      });
    }
  }

  TrendingGameListResponse.fromXmlGameData(XmlDocument doc) {
    XmlElement gameData = doc.findAllElements("item").first;
    resultExtraData = new BoardGame.fromNodeFullDetails(gameData);
  }

  TrendingGameListResponse.fromXmlGameDataList(XmlDocument doc) {
    totalResults = doc.findAllElements('item').length;
    if (totalResults != 0) {
      results = new List<BoardGame>();
      doc.findAllElements('item').forEach((v) {
        //TrendingGameListRepository.fetchTrendingGameData("1000");
        results.add(new BoardGame.fromNodeFullDetails(v));
      });
    //XmlElement gameData = doc.findAllElements("item")
    //resultExtraData = new BoardGame.fromNodeFullDetails(gameData);
    }
  }
}