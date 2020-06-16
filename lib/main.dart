import 'package:board_game_app/DataTypes/GeekList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:board_game_app/HomeScreen/TopTrending/TrendingGameList.dart';

import 'HomeScreen/GameVideos/GameVideosList.dart';
import 'HomeScreen/GeekList/GeekListList.dart';
import 'HomeScreen/NewReleases/NewReleasesList.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game Geek',
      theme: ThemeData(
        textTheme: TextTheme(  
          subtitle1: TextStyle(fontSize: 10, color: Colors.white),
          subtitle2: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1
          ),
          bodyText2: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(42, 72, 120, 1),
            fontWeight: FontWeight.w300,
            letterSpacing: 1
          ),
          headline2: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(21, 47, 90, 1)),
          headline3: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color.fromRGBO(21, 47, 90, 1)),
          headline5: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(42, 72, 120, 1),
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w300,
            letterSpacing: 1,
          ),
          caption: TextStyle(fontSize: 6, color: Colors.black),
        ),
        primaryColor: Colors.purple[900],
        iconTheme: IconThemeData(color: Colors.white, size: 28),
      ),
      home: Home()
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(191, 199, 209, 1),
      body: 
        Stack( children: <Widget>[
          Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(height: 220),
              Container( height: MediaQuery.of(context).size.height-220, width: MediaQuery.of(context).size.width,child:
              ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                addAutomaticKeepAlives: true,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0) ,
                children: <Widget>[
                  //Container( height: 10, color: Colors.red),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('TOP TRENDING', style: Theme.of(context).textTheme.headline5,),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: TrendingGameList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('REVIEWS', style: Theme.of(context).textTheme.headline5,),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: GameVideosList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('NEW RELEASES', style: Theme.of(context).textTheme.headline5,),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: NewReleasesList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  //Row(
                  //  children: <Widget>[
                  //    Column(
                  //      crossAxisAlignment: CrossAxisAlignment.start,
                  //      children: <Widget>[
                  //        Text('HOT DEALS', style: Theme.of(context).textTheme.headline5,),
                  //        Container(
                  //          height: 150,
                  //          width: MediaQuery.of(context).size.width,
                  //          child:
                  //          ListView.builder(
                  //            scrollDirection: Axis.horizontal,
                  //            itemCount: 12,
                  //            itemBuilder: (BuildContext context, int index){ 
                  //              return Container(
                  //                width: 100,
                  //                height: 125,
                  //                margin: EdgeInsets.all(5),
                  //                color: Colors.blueGrey[50],
                  //                child: Text('TODO game box',style: TextStyle(color:Colors.black))
                  //              );
                  //            }
                  //          )
                  //        )
                  //      ],
                  //    ),
                  //  ] 
                  //),
                  Row(
                    children: <Widget>[
                      Container(
                       height: 300,
                       width: MediaQuery.of(context).size.width,
                       child: Column(children: <Widget>[
                          Text('GEEK LISTS', style: Theme.of(context).textTheme.headline5,),
                          Container(height: 200, child: 
                            GeekListList(),
                          ),
                       ],) 
                      )
                    ] 
                  ),
                ],
              )
            )],)
          ),
          CustomSearchBar(true)
        ])
    );
  }
}