//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/BoardGamePage/game_images_response.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/api_base_helper_xml.dart';
//import 'package:board_game_app/BoardGamePage/board_game_response.dart';

class GameImagesRepository {
  //final String _apiKey = "Paste your api key here";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GameImages> fetchGameImages(String gameId) async {
    final url = 'images?objectid=$gameId&objecttype=thing&showcount=17&size=crop100&sort=hot';
    final response = await _helper.getJSON(url);
    return GameImagesResponse.fromJSON(response).result;//response).result;
  }
}