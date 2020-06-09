import 'package:board_game_app/DataTypes/GameVideos.dart';

import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/HomeScreen/GameVideos/game_videos_response.dart';

class GameVideosRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GameVideos> fetchGameVideos() async {
    final response = await _helper.getJSON("video/module?ajax=1&domain=boardgame&filter={%22languagefilter%22:0,%22categoryfilter%22:0}&filter_objecttype=&gallery=review&languageid=0&moduleid=41&nosession=1&objectid=0&objecttype=&pageid=1&showcount=20&sort=hot&subdomainid=0&version=v5");
    return GameVideosResponse.fromJSON(response).results;
  }
}