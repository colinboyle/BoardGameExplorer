import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewReleases.dart';
import 'package:board_game_app/HomeScreen/NewReleases/NewReleaseCard.dart';
import 'package:board_game_app/HomeScreen/NewReleases/new_releases_bloc.dart';
import 'package:board_game_app/utils/api_response.dart';
//import 'package:board_game_app/HomeScreen/NewReleases/NewReleasesCard.dart';
import 'package:flutter/material.dart';

class NewReleasesList extends StatefulWidget {
  @override
  _NewReleasesListState createState() => _NewReleasesListState();
}


class _NewReleasesListState extends State<NewReleasesList> {
  NewReleasesBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = NewReleasesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<BoardGame>>>(
      stream: _bloc.newReleasesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                return Text('Loading...', style: TextStyle(color: Colors.black));
            case Status.COMPLETED:
                return 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    new NewReleaseCard(snapshot.data.data[index]);
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