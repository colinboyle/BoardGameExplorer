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
}