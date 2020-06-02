import 'package:board_game_app/utils/api_response.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/HomeScreen/TopTrending/TrendingGameCard.dart';
import 'package:board_game_app/HomeScreen/TopTrending/trending_game_list_bloc.dart';
import 'package:flutter/material.dart';

class TrendingGameList extends StatefulWidget {
  @override
  _TrendingGameListState createState() => _TrendingGameListState();
}


class _TrendingGameListState extends State<TrendingGameList> {
  TrendingGameListBloc _bloc;
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
    //return //Text('Getting closer');
    //  FutureBuilder(
    //    future:  _bloc.fetchTrendingGameList(),
    //    //child: StreamBuilder<ApiResponse<List<BoardGame>>>(
    //      //stream: _bloc.boardGameListStream,
    //    builder: (context, snapshot) {
    //      switch (snapshot.connectionState) {
    //        case ConnectionState.waiting:
    //          {
    //            // here we are showing loading view in waiting state.
    //            return Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
    //          }
    //        case ConnectionState.active:
    //          {
    //            break;
    //          }
    //        case ConnectionState.none:
    //          {
    //            break;
    //          }
    //        case ConnectionState.done:
    //          {if (snapshot.hasData) {
    //            print(snapshot);
    //            return ListView.builder(
    //              scrollDirection: Axis.horizontal,
    //              itemCount: snapshot.data.length,
    //              itemBuilder: (BuildContext context, int index){ return TrendingGameCard(snapshot.data[index]);},);
    //            
    //          }
    //        }
    //      }
    //      return Container();
    //    },
    //    //),
    //  );
    return StreamBuilder<ApiResponse<List<BoardGame>>>(
      stream: _bloc.trendingGameStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                // here we are showing loading view in waiting state.
                return Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
            case Status.COMPLETED:
                return 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    new TrendingGameCard(snapshot.data.data[index]);
                    },);
            case Status.ERROR:
              return  Text('error', style: TextStyle(color: Colors.black));
            case Status.PARTIAL:
              return  Text('partial', style: TextStyle(color: Colors.black));
              }
            }
          return Container();
      });
     }

    @override 
    void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}