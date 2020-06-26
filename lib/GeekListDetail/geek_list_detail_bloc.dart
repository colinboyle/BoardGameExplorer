import 'dart:async';

import 'package:board_game_app/DataTypes/GeekList.dart';

import 'package:board_game_app/GeekListDetail/geek_list_detail_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class GeekListDetailBloc {
  GeekListDetailRepository _GeekListDetailRepository;
  StreamController _GeekListDetailController;

  StreamSink<ApiResponse<GeekList>> get GeekListDetailSink => _GeekListDetailController.sink;
  Stream<ApiResponse<GeekList>> get GeekListDetailStream => _GeekListDetailController.stream;

  GeekListDetailBloc() { 
    _GeekListDetailController = StreamController<ApiResponse<GeekList>>();
    _GeekListDetailRepository = GeekListDetailRepository();
  }

 fetchGeekList(String geekListId) async {
   var waitCount = 1;
    GeekListDetailSink.add(ApiResponse.loading('Fetching geek list detail'));
    try {
      GeekList boardGames = await _GeekListDetailRepository.fetchGeekList(geekListId);//.then((games) => _getTrendingGameIDs(games));
      GeekListDetailSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      
      if(e.prefix == "Accepted Request: "){
        waitCount ++;
        Timer(Duration(seconds: waitCount), () => fetchGeekList(geekListId));
      } else {
      GeekListDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
      }
    }
  }
  
  dispose() {
    _GeekListDetailController?.close();
  }
}