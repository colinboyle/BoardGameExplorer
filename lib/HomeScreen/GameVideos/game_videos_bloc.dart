import 'dart:async';

import 'package:board_game_app/DataTypes/GameVideos.dart';

import 'package:board_game_app/HomeScreen/GameVideos/game_videos_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class GameVideosBloc {
  GameVideosRepository _gameVideosRepository;
  StreamController _gameVideosController;

  StreamSink<ApiResponse<GameVideos>> get gameVideosSink => _gameVideosController.sink;
  Stream<ApiResponse<GameVideos>> get gameVideosStream => _gameVideosController.stream;

  GameVideosBloc() { 
    _gameVideosController = StreamController<ApiResponse<GameVideos>>();
    _gameVideosRepository = GameVideosRepository();
    fetchGameVideos();
  }

 fetchGameVideos() async {
    gameVideosSink.add(ApiResponse.loading('Fetching games'));
    try {
      GameVideos videos = await _gameVideosRepository.fetchGameVideos();
      gameVideosSink.add(ApiResponse.completed(videos));
    } catch (e) {
      gameVideosSink.add(ApiResponse.error(e.toString()));
      print(e);
      //throw Exception(e);
    }
  }

  
  dispose() {
    _gameVideosController?.close();
  }
}