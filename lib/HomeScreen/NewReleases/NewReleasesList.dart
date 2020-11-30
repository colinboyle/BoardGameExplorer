//import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/DataTypes/NewRelease.dart';
//import 'package:board_game_app/DataTypes/NewReleases.dart';
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
    return StreamBuilder<ApiResponse<List<NewRelease>>>(
      stream: _bloc.newReleasesStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data.status) {
            case Status.LOADING:
                return 
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index){ 
                    return 
                    new LoadingCard();
                    },);
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

class LoadingCard extends StatelessWidget{
  @override 
  Widget build(BuildContext context) {
    return 
    Container(width: 250, height: 150, decoration: BoxDecoration(color: Colors.white, ), margin: EdgeInsets.all(5), child:
        Stack(children: <Widget>[
          Padding( padding: EdgeInsets.only(left: 5), child:
            Row(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                Container(width: 110, height: 120, color: Colors.grey[100])
              ]),
              //SizedBox(width: 10),
              Expanded(child:
                Padding( padding: EdgeInsets.fromLTRB(15, 15, 15, 10), child: 
                  SizedBox(height: 120, child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Row( children: [Container(width: 100, height: 15, color: Colors.grey[200],)]),
                      Row( children: [Container(width: 80, height: 18, color: Colors.grey[200],)]),
                      Row( children: [Container(width: 70, height: 12, color: Colors.grey[200],)]),
                      Spacer(),
                      Row(children: <Widget>[
                        Expanded( child: 
                          Column(crossAxisAlignment: CrossAxisAlignment.center ,children: <Widget>[
                              Container(
                                height: 15,
                                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Container(width: 40),)
                              ),
                              Container(
                                height: 15,
                                decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.all(Radius.circular(10))),
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2), child: Container(width: 60),)
                              )                          
                          ]),
                        ), 
                        //SizedBox(width: 25,)
                      ]),
                      Spacer(),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400] ,borderRadius: BorderRadius.all(Radius.circular(10))),),
                        Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400] ,borderRadius: BorderRadius.all(Radius.circular(10))),),
                        Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.grey[400] ,borderRadius: BorderRadius.all(Radius.circular(10))),),
                      ]),
                    ])
                  )
                )
              ),
            ]),
          ),
        ])
      );
  }
}