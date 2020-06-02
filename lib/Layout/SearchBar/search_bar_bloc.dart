//import 'dart:async';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/Layout/SearchBar/search_result_repository.dart';
//import 'package:board_game_app/utils/api_response.dart';

class SearchBarBloc {
  SearchResultRepository _searchResultRepository;
  //StreamController _searchResultController;
  String query;

  //StreamSink<ApiResponse<List<BoardGame>>> get searchResultSink =>
  //    _searchResultController.sink;
  //Stream<ApiResponse<List<BoardGame>>> get searchResultStream =>
  //    _searchResultController.stream;

  SearchBarBloc() {
    //_searchResultController = StreamController<ApiResponse<List<BoardGame>>>();
    _searchResultRepository = SearchResultRepository();
    //fetchSearchResult(query);
  }

  fetchSearchResult(String query) async {
    //searchResultSink.add(ApiResponse.loading('Fetching search result..'));
    try {
      List<BoardGame> boardGames = await _searchResultRepository.fetchSearchResult(query);
      print('searched fro $query and found: ');
      print(boardGames);

      return boardGames;
    } catch (e) {
      //searchResultSink.add(ApiResponse.error(e.toString()));
      print(e);
      return null;
    }
  }

  //dispose() {
  //  _searchResultController?.close();
  //}
}