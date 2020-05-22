import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/BoardGameList/board_game_list_repository.dart';
import 'package:board_game_app/api_response.dart';

class BoardGameListBloc {
  BoardGameListRepository _boardGameRepository;
  StreamController _boardGameListController;
  String url;

  StreamSink<ApiResponse<List<BoardGame>>> get boardGameListSink =>
      _boardGameListController.sink;

  Stream<ApiResponse<List<BoardGame>>> get boardGameListStream =>
      _boardGameListController.stream;

  BoardGameListBloc(String url) {
    _boardGameListController = StreamController<ApiResponse<List<BoardGame>>>();
    _boardGameRepository = BoardGameListRepository();
    fetchBoardGameList(url);
  }

  fetchBoardGameList(String url) async {
    boardGameListSink.add(ApiResponse.loading('Fetching Board Games'));
    try {
      List<BoardGame> boardGames = await _boardGameRepository.fetchBoardGameList(url);
      boardGameListSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      boardGameListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _boardGameListController?.close();
  }
}