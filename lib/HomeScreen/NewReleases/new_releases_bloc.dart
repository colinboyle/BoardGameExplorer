import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewReleases.dart';

import 'package:board_game_app/HomeScreen/NewReleases/new_releases_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class NewReleasesBloc {
  NewReleasesRepository _newReleasesRepository;
  StreamController _newReleasesController;

  StreamSink<ApiResponse<List<BoardGame>>> get newReleasesSink => _newReleasesController.sink;
  Stream<ApiResponse<List<BoardGame>>> get newReleasesStream => _newReleasesController.stream;

  NewReleasesBloc() { 
    _newReleasesController = StreamController<ApiResponse<List<BoardGame>>>();
    _newReleasesRepository = NewReleasesRepository();
    fetchNewReleases();
  }

 fetchNewReleases() async {
    newReleasesSink.add(ApiResponse.loading('Fetching games'));
    try {
      NewReleases releases = await _newReleasesRepository.fetchNewReleases();
      List<BoardGame> boardGames = await fetchNewReleaseData(releases);
      newReleasesSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      newReleasesSink.add(ApiResponse.error(e.toString()));
      print(e);
      //throw Exception(e);
    }
  }

    Future<List<BoardGame>> fetchNewReleaseData(NewReleases releases) async {
    try {
      String gameIDs = releases.items.map((e) => e.parent.objectid+',').join();
      //print('in bloc fetching full list with ids');
      //print(gameIDs);
      List<BoardGame> boardGames = await _newReleasesRepository.fetchNewReleasesDataList(gameIDs);
      return boardGames;
    } catch (e) {
      //boardGameSink.add(ApiResponse.error(e.toString()));
      print(e);
      throw Exception(e);
    }
  }


  
  dispose() {
    _newReleasesController?.close();
  }
}