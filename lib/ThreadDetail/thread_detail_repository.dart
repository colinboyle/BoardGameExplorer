import 'package:board_game_app/DataTypes/Thread.dart';
import 'package:board_game_app/utils/api_base_helper_xml.dart';
import 'package:board_game_app/ThreadDetail/thread_detail_response.dart';

class ThreadDetailRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Thread> fetchThread(String threadID) async {
    final response = await _helper.getJSON("api/articles?threadid=$threadID");
    return ThreadDetailResponse.fromJson(response).results;
  }
}