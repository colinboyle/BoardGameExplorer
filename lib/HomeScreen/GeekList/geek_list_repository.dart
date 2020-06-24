//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekLists.dart';

import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/HomeScreen/GeekList/geek_list_response.dart';

class GeekListRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GeekLists> fetchGeekList() async {
    final response = await _helper.getJSON("geeklist/module?ajax=1&domain=boardgame&filter=%7B%22languagefilter%22:0,%22categoryfilter%22:0%7D&moduleid=1&nosession=1&objectid=0&objecttype=&pageid=1&showcontrols=1&showcount=12&sort=hot&tradelists=0&version=v5");
    return GeekListResponse.fromJSON(response).results;
  }

  //Future<GeekList> fetchGeekListDataList(String ids) async {
  //  final response = await _helper.get("xmlapi2/thing?thing=boardgame&stats=1&id="+ids);
  //  return GeekListResponse.fromXmlGameDataList(response).gameListResults;
  //}
}