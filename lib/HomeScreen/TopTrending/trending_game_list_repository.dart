import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/api_base_helper_xml.dart';
import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_response.dart';

class TrendingGameListRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<BoardGame>> fetchTrendingGameList() async {
    final response = await _helper.get("xmlapi2/hot?thing=boardgame");
    return TrendingGameListResponse.fromXml(response).results;
  }

  Future<BoardGame> fetchTrendingGameData(String id) async {
    final response = await _helper.get("xmlapi2/thing?id="+id+"&thing=boardgame");
    print('hitting single game at ' + "xmlapi2/thing?id="+id+"&thing=boardgame");
    return TrendingGameListResponse.fromXmlGameData(response).resultExtraData;
  }

  Future<List<BoardGame>> fetchTrendingGameDataList(String ids) async {
    final response = await _helper.get("xmlapi2/thing?thing=boardgame&stats=1&id="+ids);
    //print('hitting single game at ' + "xmlapi2/thing?id="+id+"&thing=boardgame");
    return TrendingGameListResponse.fromXmlGameDataList(response).results;
  }
}