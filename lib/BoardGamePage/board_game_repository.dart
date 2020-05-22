import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/api_base_helper_xml.dart';
import 'package:board_game_app/BoardGamePage/board_game_response.dart';

class BoardGameRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<BoardGame> fetchBoardGame(String gameId) async {
    final url = 'xmlapi/boardgame/' + gameId;
    print('repository with Url');
    print(url);
    final response = await _helper.get(url);
    return BoardGameResponse.fromXml(response).result;
  }
}