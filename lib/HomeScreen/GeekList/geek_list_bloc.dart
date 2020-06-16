import 'dart:async';

//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';
//import 'package:board_game_app/DataTypes/GeekLists.dart';

import 'package:board_game_app/HomeScreen/GeekList/geek_list_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class GeekListBloc {
  GeekListRepository _geekListRepository;
  StreamController _geekListController;

  StreamSink<ApiResponse<GeekList>> get geekListSink => _geekListController.sink;
  Stream<ApiResponse<GeekList>> get geekListStream => _geekListController.stream;

  GeekListBloc() { 
    _geekListController = StreamController<ApiResponse<GeekList>>();
    _geekListRepository = GeekListRepository();
    fetchGeekList();
  }

 fetchGeekList() async {
    geekListSink.add(ApiResponse.loading('Fetching games'));
    try {
      GeekList geeklist = await _geekListRepository.fetchGeekList();
      //List<BoardGame> boardGames = await fetchGeekListData(releases);
      geekListSink.add(ApiResponse.completed(geeklist));
    } catch (e) {
      geekListSink.add(ApiResponse.error(e.toString()));
      print(e);
      //throw Exception(e);
    }
  }

    //Future<List<BoardGame>> fetchGeekListData(GeekList geeklist) async {
    //try {
    //  String gameIDs = geeklist.items.map((e) => e.parent.objectid+',').join();
    //  //print('in bloc fetching full list with ids');
    //  //print(gameIDs);
    //  List<BoardGame> boardGames = await _geekListsRepository.fetchGeekListsDataList(gameIDs);
    //  return boardGames;
    //} catch (e) {
    //  //boardGameSink.add(ApiResponse.error(e.toString()));
    //  print(e);
    //  throw Exception(e);
    //}
  //}


  
  dispose() {
    _geekListController?.close();
  }
}