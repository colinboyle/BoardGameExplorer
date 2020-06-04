import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/DataTypes/GameRecs.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/utils/api_response.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/MechanicList/MechanicList.dart';
import 'package:board_game_app/MechanicList/mechanic_list_bloc.dart';

class MechanicList extends StatefulWidget {
  final String mechanicId;
  final String mechanicName;

  MechanicList(this.mechanicId, this.mechanicName);

  @override
  _MechanicListState createState() => _MechanicListState();
}


class _MechanicListState extends State<MechanicList> {
  MechanicListBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;
  var mechanicListStream;

  @override
  void initState() {
    super.initState();
    _bloc = MechanicListBloc();
    _bloc.fetchMechanicList(widget.mechanicId);
    mechanicListStream = _bloc.mechanicListStream;
  }

  openGame(context, String href) async{
    String id = href.split('/')[2];
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(id, null, true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(191, 199, 209, 1),
      body:Stack(children: <Widget>[
        Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child:
          Column(children: <Widget>[
            Container(height: 120),
            Text(widget.mechanicName, style: Theme.of(context).textTheme.headline3,),
            StreamBuilder<ApiResponse<GameRecs>>(
              stream: mechanicListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
                    case Status.COMPLETED:
                      if(snapshot.data.data.numrecs > 0){
                       return 
                       Container(height: MediaQuery.of(context).size.height -150, child:
                       ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.data.recs.length,
                          itemBuilder:  (BuildContext context, int index){ 
                            return 
                            Container(width: MediaQuery.of(context).size.width, height: 100, child:
                            InkWell(
                              onTap: (){ openGame(context, snapshot.data.data.recs[index].recitem.item.href);},
                              child:
                              Container(height: 100, color: Colors.white, child:
                                Padding(padding: EdgeInsets.all(10), child:
                                Row( children: <Widget>[
                                  Container( height: 100, width: 100, child: Image.network(snapshot.data.data.recs[index].recitem.item.images.square200, height: 100,)),
                                  Expanded( child: Column( children: <Widget>[
                                    AutoSizeText(snapshot.data.data.recs[index].recitem.item.primaryname.name, maxLines: 1, style: Theme.of(context).textTheme.headline2,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
                                      Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 26,),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:(snapshot.data.data.recs[index].recitem.item.dynamicinfo.item.stats.average + '.00').substring(0,3), style: Theme.of(context).textTheme.bodyText2),TextSpan(text:'\nstars', style: TextStyle(fontSize: 8, color: Colors.grey))]))]),
                                      Column(children: <Widget>[Icon(Icons.fitness_center, color: Colors.grey, size: 26,),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:(snapshot.data.data.recs[index].recitem.item.dynamicinfo.item.polls.boardgameweight.averageweight.toString() + '.00').substring(0,3), style: Theme.of(context).textTheme.bodyText2),TextSpan(text:'\nstars', style: TextStyle(fontSize: 8, color: Colors.grey))]))]),
                                      
                                      //Text((snapshot.data.data.recs[index].recitem.item.dynamicinfo.item.polls.boardgameweight.averageweight.toString() + '.00').substring(0,3))
                                    ]),
                                  ]))
                                ],
                                ),
                              ),
                            )));
                          }
                        ));} 
                      return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No offers available'),),);
                    case Status.ERROR:
                      return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('error', style: TextStyle(color: Colors.black));
                    case Status.PARTIAL:
                      return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));//Text('partial', style: TextStyle(color: Colors.black));
                  }
                }
                return Container();
              }
            ),
          ])
        ),
        CustomSearchBar(false),
      ])
    );
  }

  @override 
    void dispose() {
    _bloc.dispose();
    super.dispose();
  }

}