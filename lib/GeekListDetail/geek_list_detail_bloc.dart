import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';

import 'package:board_game_app/GeekListDetail/geek_list_detail_repository.dart';
import 'package:board_game_app/utils/api_exceptions.dart';
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
      List<BoardGame> boardGamesFull = await fetchListDetails(boardGames);
      boardGames.items.forEach((game) {
        boardGamesFull.forEach((gameExtended) {
          if (game.objectid == gameExtended.id) {
            game.addGameDetails(gameExtended.imageUrl, gameExtended.yearPublished, gameExtended.recPlayers, gameExtended.recPlaytime, gameExtended.age, gameExtended.rating, gameExtended.weight, gameExtended.ranks);
          }
        });
      });

      GeekListDetailSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      print('Type of e: ${e.runtimeType}');
      if(e.runtimeType is AcceptedProcessingException){
        waitCount ++;
        Timer(Duration(seconds: waitCount), () => fetchGeekList(geekListId));
      } else {
        GeekListDetailSink.add(ApiResponse.error(e.toString()));
        print(e);
      }
    }
  }

  Future<List<BoardGame>> fetchListDetails(GeekList list) async {
    try {
      String gameIDs =
      list.items.map((e) => e.objectid + ',').join();
      List<BoardGame> boardGames =
      await _GeekListDetailRepository.fetchListDetails(gameIDs);
      return boardGames;
    } catch (e) {
      print(e);
      throw Exception(e);
    }

  }
  
  dispose() {
    _GeekListDetailController?.close();
  }
}