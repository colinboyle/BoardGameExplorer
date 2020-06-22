//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/HotDealList.dart';

import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/HomeScreen/HotDealList/hot_deal_list_response.dart';

class HotDealListRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<HotDealList> fetchHotDealList() async {
    final response = await _helper.getJSON("forum/module?ajax=1&displayforums=53,153,74&filter=%7B%22languagefilter%22:0,%22categoryfilter%22:0%7D&filterforums=&filtergroups=&filterobjectids=&forumid=0&frontpin=&groupid=0&hidecontrols=&linkedforum_index=&moduleclass=&moduleid=22&moduletitle=&moduletype=&nosession=1&objectid=1&objectids=&objecttype=region&objecttypes=&pageid=1&postingallowed=0&showbrowse=&showcount=7&showlinkedforums=&showobjectlink=&showsearch=&sort=recent&subdomainid=0&subtype=&subtypes=&version=v5");
    return HotDealListResponse.fromJSON(response).results;
  }

  //Future<HotDealList> fetchHotDealListDataList(String ids) async {
  //  final response = await _helper.get("xmlapi2/thing?thing=boardgame&stats=1&id="+ids);
  //  return HotDealListResponse.fromXmlGameDataList(response).gameListResults;
  //}
}