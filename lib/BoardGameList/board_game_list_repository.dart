import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/api_base_helper_xml.dart';
import 'package:board_game_app/BoardGameList/board_game_list_response.dart';

class BoardGameListRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<BoardGame>> fetchBoardGameList(String url) async {
    final response = await _helper.get(url);
    return BoardGameListResponse.fromXml(response).results;
  }
}