import 'dart:async';

//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
//import 'package:board_game_app/HomeScreen/TopTrending/trending_game_card_repository.dart';
import 'package:board_game_app/MechanicList/mechanic_list_repository.dart';
import 'package:board_game_app/utils/api_response.dart';

class MechanicListBloc {
  MechanicListRepository _mechanicListRepository;
  StreamController _mechanicListController;

  StreamSink<ApiResponse<GameRecs>> get mechanicListSink => _mechanicListController.sink;
  Stream<ApiResponse<GameRecs>> get mechanicListStream => _mechanicListController.stream;

  MechanicListBloc() { 
    _mechanicListController = StreamController<ApiResponse<GameRecs>>();
    _mechanicListRepository = MechanicListRepository();
  }

 fetchMechanicList(String mechanicId) async {
    mechanicListSink.add(ApiResponse.loading('Fetching mechanic games'));
    try {
      GameRecs boardGames = await _mechanicListRepository.fetchMechanicList(mechanicId);//.then((games) => _getTrendingGameIDs(games));
      
      mechanicListSink.add(ApiResponse.completed(boardGames));
    } catch (e) {
      mechanicListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }
  
  dispose() {
    _mechanicListController?.close();
  }
}