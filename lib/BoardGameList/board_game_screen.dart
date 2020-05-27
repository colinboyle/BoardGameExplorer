import 'package:flutter/material.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
//import './board_game_repository.dart';
import 'package:board_game_app/api_response.dart';
import 'package:board_game_app/BoardGameList/board_game_list_bloc.dart';
import 'package:board_game_app/BoardGameList/GameListView.dart';

import 'package:board_game_app/Common/Loading.dart';

class BoardGameScreen extends StatefulWidget {
  final String url;
  final String title;

  BoardGameScreen(this.title, this.url);

  @override
  _BoardGameScreenState createState() => _BoardGameScreenState();//title, url);
}

class _BoardGameScreenState extends State<BoardGameScreen> {
  BoardGameListBloc _bloc;
  //String title;
  String url;
  String loadingMessage;
  String errorMessage;

  //_BoardGameScreenState();//this.title, this.url);

  @override
  void initState() {
    super.initState();
    _bloc = BoardGameListBloc(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => _bloc.fetchBoardGameList(widget.url),
        child: StreamBuilder<ApiResponse<List<BoardGame>>>(
          stream: _bloc.boardGameListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    //loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.PARTIAL:
                  return Text('Have a partial', style: TextStyle(color: Colors.black));
                case Status.COMPLETED:
                  return GameListView(title: widget.title, games: snapshot.data.data);//boardGameList: snapshot.data.data);
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}



class Error extends StatelessWidget {
  //const String errorMessage;
  //Error({String errorMessage});
  @override 
  Widget build(BuildContext context) {
    return Text('Error loading.. Please try again.');
  }
}

//class BoardGameList extends StatelessWidget {
//  @override 
//  Widget build(BuildContext context) {
//    return GameListView(title: 'Hot Games', games:context)
//  }
//}