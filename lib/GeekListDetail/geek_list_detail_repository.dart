import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/GeekListDetail/geek_list_detail_response.dart';

class GeekListDetailRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GeekList> fetchGeekList(String geekListId) async {
    final response = await _helper.get("xmlapi/geeklist/$geekListId");
    return GeekListDetailResponse.fromXml(response).results;
  }

  Future<List<BoardGame>> fetchListDetails(String ids) async {
    final response = await _helper.get("xmlapi2/thing?thing=boardgame&stats=1&videos=1&id="+ids);
    return GeekListDetailResponse.fromXmlGameDataList(response).gameListResults;
  }
}