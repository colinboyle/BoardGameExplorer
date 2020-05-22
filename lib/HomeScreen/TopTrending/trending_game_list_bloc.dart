import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/HomeScreen/TopTrending/trending_game_card_repository.dart';
import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_repository.dart';

class TrendingGameListBloc {
  TrendingGameListRepository _trendingGameListRepository;
  //StreamController _boardGameController;
  //String url;

  //StreamSink<ApiResponse<BoardGame>> get boardGameSink =>
  //    _boardGameController.sink;

  //Stream<ApiResponse<BoardGame>> get boardGameStream =>
  //    _boardGameController.stream;

  TrendingGameListBloc( ) { //String id) {
    //_boardGameController = StreamController<ApiResponse<BoardGame>>();
    _trendingGameListRepository = TrendingGameListRepository();
    //fetchBoardGame(id);
  }

  Future<List<BoardGame>> fetchTrendingGameList() async {
    //boardGameSink.add(ApiResponse.loading('Fetching Board Game'));
    try {
      //print('Trying to pull from bloc');
      //print(id);
      List<BoardGame> boardGames = await _trendingGameListRepository.fetchTrendingGameList();
      //boardGameSink.add(ApiResponse.completed(boardGame));
      return boardGames;
    } catch (e) {
      //boardGameSink.add(ApiResponse.error(e.toString()));
      print(e);
      throw Exception(e);
    }
  }

  //dispose() {
  //  _boardGameController?.close();
  //}
}