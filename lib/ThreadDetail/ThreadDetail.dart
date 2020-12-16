import 'package:flutter/material.dart';

import 'package:board_game_app/utils/bbcode_parser.dart';
import 'package:board_game_app/utils/api_response.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:board_game_app/DataTypes/Thread.dart';
import 'package:board_game_app/ThreadDetail/thread_detail_bloc.dart';

import 'package:board_game_app/Common/LoadingLogo.dart';
import 'package:board_game_app/Common/ErrorGameBox.dart';


class ThreadDetail extends StatefulWidget {
  final thread;

  ThreadDetail(this.thread);

  @override
  _ThreadDetailState createState() => _ThreadDetailState();
}


class _ThreadDetailState extends State<ThreadDetail> {
  ThreadDetailBloc _bloc;
  String url;
  String loadingMessage;
  String errorMessage;
  var ThreadDetailStream;

  @override
  void initState() {
    super.initState();
    _bloc = ThreadDetailBloc();
    _bloc.fetchThread(widget.thread.threadid);
    ThreadDetailStream = _bloc.ThreadDetailStream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        SingleChildScrollView(scrollDirection: Axis.vertical, child:
          Column( mainAxisSize: MainAxisSize.min, children: <Widget>[
            Container(height: 120),
            StreamBuilder<ApiResponse<Thread>>(
              stream: ThreadDetailStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return LoadingLogo();
                    case Status.COMPLETED:
                       return 
                        Column(children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(10,0,10,0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(height: 30,),
                                    Row(children: [Expanded(child: Text(widget.thread.subject, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline2,),),]),
                                    Row(children: [Expanded(child: Text(widget.thread.threadPostdate.substring(0,10), textAlign: TextAlign.center,),),]),
                                    Container(height: 20,),
                                    ...parseBBCode(snapshot.data.data.articles[0].body, context),
                                    Container(height: 10,),
                                  ]),
                              ),
                              Container( color: Colors.black12, child: 
                              Column(children: [
                              Container(height: 20,),
                              Text('Comments', style: TextStyle(color: Colors.black, fontSize: 20),),
                              
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: (snapshot.data.data.articles.length - 1), //Only need the comments and index 0 is the main post
                                itemBuilder:  (BuildContext context, int index){ 
                                  return Container(
                                          //height: 150, 
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))), 
                                          margin: EdgeInsets.all(5), 
                                          child:
                                          Stack(children: <Widget>[
                                            Padding( padding: EdgeInsets.only(left: 5), child:
                                              Row(crossAxisAlignment: CrossAxisAlignment.start ,mainAxisSize: MainAxisSize.max, children: <Widget>[
                                                  Padding( padding: EdgeInsets.fromLTRB(15, 15, 15, 10), child: 
                                                      Column(mainAxisSize: MainAxisSize.min ,crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                                        Row(mainAxisSize: MainAxisSize.max ,children: <Widget>[
                                                          Container( width: MediaQuery.of(context).size.width - 45 , child:
                                                          Column(children: <Widget>[
                                                            ...parseBBCode(snapshot.data.data.articles[index+1].body, context),
                                                          ],)
                                                          ),
                                                        ]), 
                                                      ])
                                                  )
                                              ]),
                                            ),
                                          ])
                                      );
                                }
                              )
                            ],)
                            )],);
                    case Status.ERROR:
                      return  ErrorGameBox(); //Text('Error', style: TextStyle(color: Colors.black, fontSize: 12)); //Text('error', style: TextStyle(color: Colors.black));
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