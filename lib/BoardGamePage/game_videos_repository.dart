import 'package:board_game_app/BoardGamePage/game_videos_response.dart';
import 'package:board_game_app/DataTypes/GameVideos.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';

class GameVideosRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GameVideos> fetchGameVideos(String gameId) async {
    final url = 'api/videos?ajax=1&gallery=all&nosession=1&objectid=$gameId&objecttype=thing&pageid=1&showcount=50&sort=hot';
    final response = await _helper.getJSON(url);
    return GameVideosResponse.fromJSON(response).result;
  }
}