import 'dart:async';

import 'package:board_game_app/BoardGamePage/game_images_repository.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/api_response.dart';

class BoardGamePageBloc {
  GameImagesRepository _gameImagesRepository;
  StreamController _gameImagesController; 

  StreamSink<ApiResponse<GameImages>> get gameImagesSink => _gameImagesController.sink;
  Stream<ApiResponse<GameImages>> get gameImagesStream => _gameImagesController.stream.asBroadcastStream();

  BoardGamePageBloc(id) { 
    _gameImagesController = StreamController<ApiResponse<GameImages>>();
    _gameImagesRepository = GameImagesRepository();
    fetchGameImages(id);
  }

  fetchGameImages(String id) async {
    try {
      GameImages imageList= await _gameImagesRepository.fetchGameImages(id);
      gameImagesSink.add(ApiResponse.completed(imageList));
    } catch (e) {
      print(e);
      gameImagesSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _gameImagesController?.close();
  }
}