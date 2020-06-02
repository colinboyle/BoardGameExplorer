import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/Layout/SearchBar/search_result_response.dart';

class SearchResultRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<BoardGame>> fetchSearchResult(String query) async {
    String url = 'xmlapi2/search?query=$query&type=boardgame';
    final response = await _helper.get(url);
    return SearchResultResponse.fromXml(response).results;
  }
}