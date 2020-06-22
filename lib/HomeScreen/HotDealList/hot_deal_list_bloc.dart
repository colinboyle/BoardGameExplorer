import 'dart:async';

import 'package:board_game_app/DataTypes/HotDealList.dart';

import 'package:board_game_app/HomeScreen/HotDealList/hot_deal_list_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class HotDealListBloc {
  HotDealListRepository _hotDealListRepository;
  StreamController _hotDealListController;

  StreamSink<ApiResponse<HotDealList>> get hotDealListSink => _hotDealListController.sink;
  Stream<ApiResponse<HotDealList>> get hotDealListStream => _hotDealListController.stream;

  HotDealListBloc() { 
    _hotDealListController = StreamController<ApiResponse<HotDealList>>();
    _hotDealListRepository = HotDealListRepository();
    fetchHotDealList();
  }

 fetchHotDealList() async {
    hotDealListSink.add(ApiResponse.loading('Fetching deals..'));
    try {
      HotDealList deallist = await _hotDealListRepository.fetchHotDealList();
      hotDealListSink.add(ApiResponse.completed(deallist));
    } catch (e) {
      hotDealListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  
  dispose() {
    _hotDealListController?.close();
  }
}