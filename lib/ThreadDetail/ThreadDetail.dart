import 'package:auto_size_text/auto_size_text.dart';
import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/DataTypes/Thread.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:board_game_app/utils/api_response.dart';

import 'package:board_game_app/ThreadDetail/thread_detail_bloc.dart';

import 'package:board_game_app/utils/bbcode_parser.dart';

class ThreadDetail extends StatefulWidget {
  final thread;
  //final String threadId;
  //final String title;

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

  //openGame(context, gameData){
  //  print('Game id from onTap');
  //  print(gameData.objectid);
  //  Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameData.objectid, null, true)));
  //}

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
                      return Text('Loading', style: TextStyle(color: Colors.black, fontSize: 12));
                    case Status.COMPLETED:
                       return 
                        Column(children: <Widget>[
                        Row(children: [Expanded(child: Text(widget.thread.subject, textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline2,),),]),
                        Row(children: [Expanded(child: Text(widget.thread.threadPostdate,textAlign: TextAlign.center,),),]),
                        ...parseBBCode(snapshot.data.data.articles[0].body)
                        ],);
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