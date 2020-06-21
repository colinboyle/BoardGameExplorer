import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/BoardGamePage/game_detail_response.dart';

class GameDetailRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<BoardGame> fetchGameDetail(String id) async {
    final response = await _helper.get("xmlapi2/thing?thing=boardgame&videos=1&stats=1&id=" + id);
    return GameDetailResponse.fromXml(response).result;
  }
}