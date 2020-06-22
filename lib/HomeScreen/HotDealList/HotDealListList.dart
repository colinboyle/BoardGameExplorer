import 'package:flutter/material.dart';

import 'package:board_game_app/DataTypes/HotDealList.dart';
import 'package:board_game_app/HomeScreen/HotDealList/HotDealCard.dart';
import 'package:board_game_app/HomeScreen/HotDealList/hot_deal_list_bloc.dart';
import 'package:board_game_app/utils/api_response.dart';

class HotDealListList extends StatefulWidget {
  @override
  _HotDealListListState createState() => _HotDealListListState();
}


class _HotDealListListState extends State<HotDealListList> {
  HotDealListBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _bloc = HotDealListBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<HotDealList>>(
      stream: _bloc.hotDealListStream,
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
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    color: Colors.black,
                    height: 1,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.data.threads.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                      new HotDealCard(snapshot.data.data.threads[index]);
                  },
                );
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