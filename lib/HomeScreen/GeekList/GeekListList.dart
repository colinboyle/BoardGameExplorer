//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';
//import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:board_game_app/HomeScreen/GeekList/GeekListCard.dart';
import 'package:board_game_app/HomeScreen/GeekList/geek_list_bloc.dart';
import 'package:board_game_app/utils/api_response.dart';
//import 'package:board_game_app/HomeScreen/GeekList/GeekListCard.dart';
import 'package:flutter/material.dart';

class GeekListList extends StatefulWidget {
  @override
  _GeekListListState createState() => _GeekListListState();
}


class _GeekListListState extends State<GeekListList> {
  GeekListBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = GeekListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<GeekList>>(
      stream: _bloc.geekListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                return 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    new LoadingCard();
                    },);
            case Status.COMPLETED:
                return 
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.data.lists.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    new GeekListCard(snapshot.data.data.lists[index]);
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

class LoadingCard extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return 
    Container(height: 150, decoration: BoxDecoration(color: Colors.white, ), margin: EdgeInsets.all(5), child:
        Text('Loading List')
      );
  }
}