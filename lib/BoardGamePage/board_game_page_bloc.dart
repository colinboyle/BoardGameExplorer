import 'dart:async';

import 'package:board_game_app/BoardGamePage/game_detail_repository.dart';
import 'package:board_game_app/BoardGamePage/game_images_repository.dart';
import 'package:board_game_app/BoardGamePage/game_market_offers_repository.dart';
import 'package:board_game_app/BoardGamePage/game_recs_repository.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameImages.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/DataTypes/GameVideos.dart';
import 'package:board_game_app/DataTypes/MarketOffers.dart';
import 'package:board_game_app/utils/api_response.dart';

import 'game_videos_repository.dart';

class BoardGamePageBloc {
  GameRecsRepository _gameRecsRepository;
  StreamController _gameRecsController; 

  GameImagesRepository _gameImagesRepository;
  StreamController _gameImagesController; 

  MarketOffersRepository _marketOffersRepository;
  StreamController _marketOffersController; 

  GameVideosRepository _gameVideosRepository;
  StreamController _gameVideosController; 

  GameDetailRepository _gameDetailRepository;


  StreamSink<ApiResponse<GameImages>> get gameImagesSink => _gameImagesController.sink;
  Stream<ApiResponse<GameImages>> get gameImagesStream => _gameImagesController.stream.asBroadcastStream();

  StreamSink<ApiResponse<GameRecs>> get gameRecsSink => _gameRecsController.sink;
  Stream<ApiResponse<GameRecs>> get gameRecsStream => _gameRecsController.stream;

  StreamSink<ApiResponse<MarketOffers>> get marketOffersSink => _marketOffersController.sink;
  Stream<ApiResponse<MarketOffers>> get marketOffersStream => _marketOffersController.stream;

  StreamSink<ApiResponse<GameVideos>> get gameVideosSink => _gameVideosController.sink;
  Stream<ApiResponse<GameVideos>> get gameVideosStream => _gameVideosController.stream;


  BoardGamePageBloc(id) { 
    _gameImagesController = StreamController<ApiResponse<GameImages>>();
    _gameImagesRepository = GameImagesRepository();
    
    _gameDetailRepository = GameDetailRepository();

    _gameRecsController = StreamController<ApiResponse<GameRecs>>();
    _gameRecsRepository = GameRecsRepository();

    _marketOffersController = StreamController<ApiResponse<MarketOffers>>();
    _marketOffersRepository = MarketOffersRepository();

    _gameVideosController = StreamController<ApiResponse<GameVideos>>();
    _gameVideosRepository = GameVideosRepository();

    fetchGameImages(id);
    fetchGameRecs(id);
    fetchMarketOffers(id);
    fetchGameVideos(id);
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

  fetchGameRecs(String id) async {
    try {
      GameRecs recList= await _gameRecsRepository.fetchGameRecs(id);
      gameRecsSink.add(ApiResponse.completed(recList));
    } catch (e) {
      print(e);
      gameRecsSink.add(ApiResponse.error(e.toString()));
    }
  }

  fetchMarketOffers(String id) async {
    try {
      MarketOffers offerList= await _marketOffersRepository.fetchMarketOffers(id);
      marketOffersSink.add(ApiResponse.completed(offerList));
    } catch (e) {
      print(e);
      marketOffersSink.add(ApiResponse.error(e.toString()));
    }
  }

  fetchGameVideos(String id) async {
    try {
      GameVideos videoList= await _gameVideosRepository.fetchGameVideos(id);
      gameVideosSink.add(ApiResponse.completed(videoList));
    } catch (e) {
      print(e);
      gameVideosSink.add(ApiResponse.error(e.toString()));
    }
  }

  Future<BoardGame> fetchGameDetails(String id) async {
    try {
      BoardGame gamedata = await _gameDetailRepository.fetchGameDetail(id);
      return gamedata;
    } catch (e) {
      print(e);
      return null;
    }
  }

  dispose() {
    _gameRecsController?.close();
    _gameImagesController?.close();
    _marketOffersController?.close();
    _gameVideosController?.close();
  }
}