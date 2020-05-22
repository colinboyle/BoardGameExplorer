import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/BoardGamePage/board_game_repository.dart';

class BoardGamePageBloc {
  BoardGameRepository _boardGameRepository;
  //StreamController _boardGameController;
  //String url;

  //StreamSink<ApiResponse<BoardGame>> get boardGameSink =>
  //    _boardGameController.sink;

  //Stream<ApiResponse<BoardGame>> get boardGameStream =>
  //    _boardGameController.stream;

  BoardGamePageBloc( ) { //String id) {
    //_boardGameController = StreamController<ApiResponse<BoardGame>>();
    _boardGameRepository = BoardGameRepository();
    //fetchBoardGame(id);
  }

  Future<BoardGame> fetchBoardGame(String id) async {
    //boardGameSink.add(ApiResponse.loading('Fetching Board Game'));
    try {
      print('Trying to pull from bloc');
      print(id);
      BoardGame boardGame = await _boardGameRepository.fetchBoardGame(id);
      //boardGameSink.add(ApiResponse.completed(boardGame));
      return boardGame;
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