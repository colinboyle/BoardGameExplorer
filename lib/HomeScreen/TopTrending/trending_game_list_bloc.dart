import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/HomeScreen/TopTrending/trending_game_card_repository.dart';
import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_repository.dart';
import 'package:board_game_app/api_response.dart';

class TrendingGameListBloc {
  TrendingGameListRepository _trendingGameListRepository;
  StreamController _trendingGameController;

  StreamSink<ApiResponse<List<BoardGame>>> get trendingGameSink => _trendingGameController.sink;
  Stream<ApiResponse<List<BoardGame>>> get trendingGameStream => _trendingGameController.stream;

  TrendingGameListBloc() { 
    _trendingGameController = StreamController<ApiResponse<List<BoardGame>>>();
    _trendingGameListRepository = TrendingGameListRepository();
    fetchTrendingGameList();
  }

 fetchTrendingGameList() async {
    trendingGameSink.add(ApiResponse.loading('Fetching games'));
    try {
      List<BoardGame> boardGames = await _trendingGameListRepository.fetchTrendingGameList();//.then((games) => _getTrendingGameIDs(games));
      
      //List<BoardGame> boardGames2 = [];
      //for(BoardGame game in boardGames){
      //  //BoardGame fullGame = await fetchTrendingGameData(game);
      //  //print("Got full data " + fullGame.name + " with company " + fullGame.boardGamePublisher);
      //  //boardGames2.add(fullGame);
      //  gameIDs.add(game.id);
      //  print(gameIDs);
      //}
      //boardGames.map((i) => gameIDs = gameIDs + i.id + ',');
      List<BoardGame> boardGamesFull = await fetchTrendingGameDataList(boardGames);
      
      //trendingGameSink.add(ApiResponse.partial(gameList))
      //gameList.map((e) => fetchTrendingGameData(e))
      trendingGameSink.add(ApiResponse.completed(boardGamesFull));
      //trendingGameSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      trendingGameSink.add(ApiResponse.error(e.toString()));
      print(e);
      //throw Exception(e);
    }
  }

  //_getTrendingGameIDs(games) async {
  //  String gameIDs = await games.reduce((String value, BoardGame element) => { value + element.id + ','});
  //
  //}

  Future<BoardGame> fetchTrendingGameData(BoardGame game) async {
    try {
      //print('in bloc with id');
      //print(game.id);
      BoardGame boardGame = await _trendingGameListRepository.fetchTrendingGameData(game.id);
      return boardGame;
    } catch (e) {
      //boardGameSink.add(ApiResponse.error(e.toString()));
      print(e);
      throw Exception(e);
    }
  }

  Future<List<BoardGame>> fetchTrendingGameDataList(List<BoardGame> games) async {
    try {
      String gameIDs = games.map((e) => e.id+',').join();
      //print('in bloc fetching full list with ids');
      //print(gameIDs);
      List<BoardGame> boardGames = await _trendingGameListRepository.fetchTrendingGameDataList(gameIDs);
      return boardGames;
    } catch (e) {
      //boardGameSink.add(ApiResponse.error(e.toString()));
      print(e);
      throw Exception(e);
    }
  }

  
  dispose() {
    _trendingGameController?.close();
  }
}