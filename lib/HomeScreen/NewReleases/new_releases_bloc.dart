import 'dart:async';

import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewRelease.dart';
import 'package:board_game_app/DataTypes/NewReleases.dart';

import 'package:board_game_app/HomeScreen/NewReleases/new_releases_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class NewReleasesBloc {
  NewReleasesRepository _newReleasesRepository;
  StreamController _newReleasesController;

  StreamSink<ApiResponse<List<NewRelease>>> get newReleasesSink => _newReleasesController.sink;
  Stream<ApiResponse<List<NewRelease>>> get newReleasesStream => _newReleasesController.stream;

  NewReleasesBloc() { 
    _newReleasesController = StreamController<ApiResponse<List<NewRelease>>>();
    _newReleasesRepository = NewReleasesRepository();
    fetchNewReleases();
  }

 fetchNewReleases() async {
    newReleasesSink.add(ApiResponse.loading('Fetching games'));
    try {
      NewReleases releases = await _newReleasesRepository.fetchNewReleases();
      List<BoardGame> boardGames = await fetchNewReleaseData(releases);
      List<NewRelease> releaseList = []; 
      boardGames.forEach((game) {
        releases.items.forEach((release) {
          if(game.id == release.parent.objectid){
            releaseList.add( new NewRelease(
                id:                   game.id, 
                name:                 game.name, 
                imageUrl:             game.imageUrl, 
                fullImageUrl:         game.fullImageUrl, 
                yearPublished:        game.yearPublished, 
                minPlayers:           game.minPlayers, 
                maxPlayers:           game.maxPlayers,
                minPlaytime:          game.minPlaytime,
                maxPlaytime:          game.maxPlaytime,
                age:                  game.age,
                description:          game.description,
                designer:             game.designer,
                boardGamePublisher:   game.boardGamePublisher,
                mechanic:             game.mechanic, 
                rating:               game.rating,
                weight:               game.weight,
                ranks:                game.ranks,
                recPlayers:           game.recPlayers,
                recPlaytime:          game.recPlaytime,
                videos:               game.videos,
                versionId:            release.version.objectid, 
                versionName:          release.version.name, 
                releaseDate:          release.date, 
                numwish:              release.numwish
            ));
          }
        });
      });
      newReleasesSink.add(ApiResponse.completed(releaseList));
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