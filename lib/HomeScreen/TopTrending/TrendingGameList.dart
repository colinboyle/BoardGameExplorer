import 'package:board_game_app/Common/Loading.dart';
import 'package:board_game_app/Common/Error.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_bloc.dart';
import 'package:flutter/material.dart';

import 'package:board_game_app/api_response.dart';

class TrendingGameList extends StatefulWidget {
  @override
  _TrendingGameListState createState() => _TrendingGameListState();


}


class _TrendingGameListState extends State<TrendingGameList> {
  TrendingGameListBloc _bloc;
  //String title;
  String url;
  String loadingMessage;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = TrendingGameListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return //Text('Getting closer');
      RefreshIndicator(
        onRefresh: () => _bloc.fetchTrendingGameList(),
        child: StreamBuilder<ApiResponse<List<BoardGame>>>(
          //stream: _bloc.boardGameListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    //loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return Text('Did it');//GameListView(title: widget.title, games: snapshot.data.data);//boardGameList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    //errorMessage: snapshot.data.message,
                    //onRetryPressed: () => _bloc.fetchBoardGameList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      );
}
}