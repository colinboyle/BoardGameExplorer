import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:board_game_app/HomeScreen/TopTrending/TrendingGameList.dart';
import 'package:board_game_app/HomeScreen/HotDealList/HotDealListList.dart';
import 'package:board_game_app/HomeScreen/GameVideos/GameVideosList.dart';
import 'package:board_game_app/HomeScreen/GeekList/GeekListList.dart';
import 'package:board_game_app/HomeScreen/NewReleases/NewReleasesList.dart';

import 'HomeScreen/HotDealList/HotDealListList.dart';




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
            //backgroundColor: Color.fromRGBO(191, 199, 209, 1) ,
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
      backgroundColor: Colors.grey.shade200,//Color.fromRGBO(191, 199, 209, 1),
      body: 
        Stack( children: <Widget>[
          Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child:
            Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Container(height: 220),
              Container( height: MediaQuery.of(context).size.height-220, width: MediaQuery.of(context).size.width,child:
              ListView(
                //shrinkWrap: true,
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
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                            ),
                            child: Text('TOP TRENDING', style: Theme.of(context).textTheme.headline5,),
                          ),
                          Container(
                            color: Color.fromRGBO(191, 199, 209, 1),//Colors.grey.shade400,
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: TrendingGameList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                            ),
                            child: Text('REVIEWS', style: Theme.of(context).textTheme.headline5,))
                          ,
                          Container(
                            color: Color.fromRGBO(191, 199, 209, 1),
                            padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: GameVideosList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                            ),
                            child: Text('NEW RELEASES', style: Theme.of(context).textTheme.headline5,)
                          ),
                          Container(
                            color: Color.fromRGBO(191, 199, 209, 1),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: NewReleasesList()
                          )
                        ],
                      ),
                    ] ,
                  ),
                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      Container(
                       height: 221,
                       width: MediaQuery.of(context).size.width,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                            ),
                            child: Text('GEEK LISTS', style: Theme.of(context).textTheme.headline5,)
                           ),
                            Container(
                              color: Color.fromRGBO(191, 199, 209, 1),        
                              padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                              height: 190, 
                              child: GeekListList(),
                            ),
                          ],
                        ) 
                      )
                    ] 
                  ),
                  Container(height: 20,),
                  Row(
                    children: <Widget>[
                      Container(
                       height: 221,
                       width: MediaQuery.of(context).size.width,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 15.0, 0),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
                            ),
                            child: Text('HOT DEALS', style: Theme.of(context).textTheme.headline5,)
                           ),
                            Container(
                              color: Color.fromRGBO(191, 199, 209, 1),
                              padding: EdgeInsets.fromLTRB(0,5.0,0,5.0),
                              height: 190, 
                              child: HotDealListList(),
                            ),
                          ],
                        ) 
                      )
                    ] 
                  ),
                  Container(height: 10,),
                ],
              )
            )],)
          ),
          CustomSearchBar(true)
        ])
    );
  }
}