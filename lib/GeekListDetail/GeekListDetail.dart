//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/utils/api_response.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/GeekListDetail/GeekListDetail.dart';
import 'package:board_game_app/GeekListDetail/geek_list_detail_bloc.dart';

class GeekListDetail extends StatefulWidget {
  final String geekListId;
  final String numItems;

  GeekListDetail(this.geekListId, this.numItems);

  @override
  _GeekListDetailState createState() => _GeekListDetailState();
}


class _GeekListDetailState extends State<GeekListDetail> {
  GeekListDetailBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;
  var GeekListDetailStream;

  @override
  void initState() {
    super.initState();
    _bloc = GeekListDetailBloc();
    _bloc.fetchGeekList(widget.geekListId);
    GeekListDetailStream = _bloc.GeekListDetailStream;
  }

  openGame() { //context, String href) async{
    //String id = href.split('/')[2];
    //Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(id, null, true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(191, 199, 209, 1),
      body: Stack(children: <Widget>[
        SingleChildScrollView(scrollDirection: Axis.vertical, child:
        Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child:
          Column(children: <Widget>[
            Container(height: 120),
            StreamBuilder<ApiResponse<GeekList>>(
              stream: GeekListDetailStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('Loading...', style: TextStyle(color: Colors.black));//loadingView();
                    case Status.COMPLETED:
                      //if(snapshot.data.data.numitems. > 0){
                       return 
                        //SingleChildScrollView(
                        //  scrollDirection: Axis.vertical, //physics: ScrollPhysics(),
                        //  child: 
                            Column( children: <Widget>[
                              Container(child:
                                Column(children: <Widget>[
                                  Text(snapshot.data.data.title, style: Theme.of(context).textTheme.headline2,),
                                  Text(snapshot.data.data.editdate),
                                  Text(snapshot.data.data.description, style: Theme.of(context).textTheme.subtitle1,)
                                ]),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.data.items.length,
                                itemBuilder:  (BuildContext context, int index){ 
                                  return Container(
                                    width: MediaQuery.of(context).size.width, 
                                    height: 100, 
                                    child:
                                      InkWell(
                                        onTap: (){ openGame();},//context, snapshot.data.data.recs[index].recitem.item.href);},
                                        child:
                                          Container(height: 100, color: Colors.white, child:
                                            Text(snapshot.data.data.items[index].objectname, style: TextStyle(color: Colors.black, fontSize: 20),)
                                          ),
                                      ),
                                  );
                                }
                               //),
                               //),
                            )],);
                        //);
                      //return Container( height: 100, color: Colors.blueGrey[100], child: Center(child: Text('No offers available'),),);
                    case Status.ERROR:
                      return  Text('Error', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('error', style: TextStyle(color: Colors.black));
                    case Status.PARTIAL:
                      return  Text('Partial', style: TextStyle(color: Colors.black, fontSize: 12));//Text('partial', style: TextStyle(color: Colors.black));
                  }
                }
                return Container();
              }
            ),
          ]),
        ),
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