//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/utils/api_response.dart';
//import 'package:board_game_app/DataTypes/BoardGame.dart';
//import 'package:board_game_app/GeekListDetail/GeekListDetail.dart';
import 'package:board_game_app/GeekListDetail/geek_list_detail_bloc.dart';

import 'package:board_game_app/utils/bbcode_parser.dart';

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

  openGame(context, gameData){
    print('Game id from onTap');
    print(gameData.objectid);
    Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.objectid, null, true)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,//Color.fromRGBO(191, 199, 209, 1),
      body: Stack(children: <Widget>[
        SingleChildScrollView(scrollDirection: Axis.vertical, child:
        //Column(children: <Widget>[
        //  Container(height: 200, color: Colors.green,),
        //  Container(height: 300, color: Colors.blue,),
        //  Container(height: 400, color: Colors.yellow,),
        //],)
        //Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child:
          Column( mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(height: 120),
            //Text(parseBBCode('is this [b]Bold[/b]?')),
            //parseBBCode('is this [b]Bold[/b]?'),
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
                            Column(children: <Widget>[
                              Container(child:
                                Column(children: <Widget>[
                                  Text(snapshot.data.data.title, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline2,),
                                  Text(snapshot.data.data.editdate),
                                  ...parseBBCode(snapshot.data.data.description),
                                  //Text(snapshot.data.data.description, style: Theme.of(context).textTheme.bodyText2,)
                                ]),
                              ),
                              //Container(height: 1000,)
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.data.items.length,
                                itemBuilder:  (BuildContext context, int index){ 
                                  return InkWell(
                                        onTap: () {openGame(context, snapshot.data.data.items[index]);},
                                        child: 
                                        Container(
                                          //height: 150, 
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(color: Colors.white, ), 
                                          margin: EdgeInsets.all(5), 
                                          child:
                                          Stack(children: <Widget>[
                                            Padding( padding: EdgeInsets.only(left: 5), child:
                                              Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                                                Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                  Image.network(snapshot.data.data.items[index].imageUrl, width: 110, height: 120, fit: BoxFit.contain)
                                                ]),
                                                //SizedBox(width: 10),
                                                //Expanded(child:
                                                  Padding( padding: EdgeInsets.fromLTRB(15, 15, 15, 10), child: 
                                                    //SizedBox(height: 100, child:
                                                      Column(mainAxisSize: MainAxisSize.min ,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                        Row(
                                                          mainAxisSize: MainAxisSize.max, 
                                                          children: [
                                                            Container( width: MediaQuery.of(context).size.width - 155 , child:
                                                              AutoSizeText(snapshot.data.data.items[index].objectname, maxLines: 1, wrapWords: false, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800,color: Color.fromRGBO(21, 47, 90, 1)))
                                                            )
                                                        ]),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Column(children: <Widget>[Icon(Icons.star, color: Colors.yellow, size: 14,),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:'${snapshot.data.data.items[index].rating}',style: TextStyle(fontSize: 7, color: Colors.black54)),TextSpan(text:'\nstars', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                                                            Column(children: <Widget>[Icon(Icons.group, color: Colors.grey, size: 14),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:snapshot.data.data.items[index].recPlayers, style: TextStyle(fontSize: 7, color: Colors.black54)), TextSpan(text:'\nplayers', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                                                            Column(children: <Widget>[Icon(Icons.timer, color: Colors.blue, size: 14),RichText(textAlign: TextAlign.center, text: TextSpan(children: [TextSpan(text:snapshot.data.data.items[index].recPlaytime,style: TextStyle(fontSize: 7, color: Colors.black54)),TextSpan(text:'\nmins', style: TextStyle(fontSize: 5, color: Colors.grey))]))]),
                                                        ]),
                                                        Row(mainAxisSize: MainAxisSize.max ,children: <Widget>[
                                                          Container( width: MediaQuery.of(context).size.width - 155 , child:
                                                            AutoSizeText(snapshot.data.data.items[index].body, 
                                                              //softWrap: true,
                                                              maxLines: 25,
                                                              overflow: TextOverflow.ellipsis, 
                                                              minFontSize: 8,
                                                              style: Theme.of(context).textTheme.bodyText2,
                                                            ),
                                                          ),
                                                        ]), 
                                                        
                                                      ])
                                                 //   )
                                                  )
                                               // ),
                                              ]),
                                            ),
                                            Positioned(top: 0, left: 0, child: GestureDetector( onTap: () {}, child: Container(width: 30, height: 30, decoration: BoxDecoration(color:Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),child: Icon(Icons.favorite_border, color: Colors.black, size: 15,)))),
                                            if(snapshot.data.data.items[index].ranks.length > 0 && snapshot.data.data.items[index].ranks[0].value != 'Not Ranked' && int.parse(snapshot.data.data.items[index].ranks[0].value) < 1000) ...[
                                              Positioned(top: 0, right: 5, child: Row(children: [Container(decoration: BoxDecoration(color: Colors.grey[200] ,borderRadius: BorderRadius.all(Radius.circular(5))) , child: Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5) ,child:Text('Overall: ${snapshot.data.data.items[index].ranks[0].value}')))]))
                                            ]
                                          ])
                                        )
                                      );
                                }
                               //),
                               //),
                              )
                            ],);
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
        //),
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