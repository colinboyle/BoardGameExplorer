import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewReleases.dart';

import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/HomeScreen/NewReleases/new_releases_response.dart';

class NewReleasesRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<NewReleases> fetchNewReleases() async {
    final response = await _helper.getJSON("item/module?ajax=1&domain=boardgame&filter=%7B%22languagefilter%22:0,%22categoryfilter%22:0%7D&moduleid=57&nosession=1&pageid=1&releasestatus=released&showcount=10&sort=hot&subtype=boardgameversion&version=v5");
    return NewReleasesResponse.fromJSON(response).results;
  }

  Future<List<BoardGame>> fetchNewReleasesDataList(String ids) async {
    final response = await _helper.get("xmlapi2/thing?thing=boardgame&stats=1&videos=1&id="+ids);
    return NewReleasesResponse.fromXmlGameDataList(response).gameListResults;
  }
}