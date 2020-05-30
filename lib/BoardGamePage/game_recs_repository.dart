//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/BoardGamePage/game_recs_response.dart';
//import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
//import 'package:board_game_app/BoardGamePage/board_game_response.dart';

class GameRecsRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GameRecs> fetchGameRecs(String gameId) async {
    final url = 'geekitem/recs?ajax=1&objectid=$gameId&objecttype=thing&pageid=1';
    final response = await _helper.getJSON(url);
    return GameRecsResponse.fromJSON(response).result;//response).result;
  }
}