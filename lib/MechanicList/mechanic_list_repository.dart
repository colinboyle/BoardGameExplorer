import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/MechanicList/mechanic_list_response.dart';

class MechanicListRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<GameRecs> fetchMechanicList(String mechanicId) async {
    final response = await _helper.getJSON("api/geekitem/recs/boardgamemechanic?ajax=1&linkdata_index=boardgame&objectid=$mechanicId&objecttype=property&pageid=1");
    return MechanicListResponse.fromJson(response).results;
  }
}