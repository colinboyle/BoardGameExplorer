import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/Layout/SearchBar/CustomSearchBar.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget{
  List<BoardGame> games;

  SearchResultPage(this.games);

  @override 
  Widget build(BuildContext context) {
    return 
    Scaffold(body: 
      SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.blue[800]
                    ),
                    //Container(
                    //  width: MediaQuery.of(context).size.width,
                    //  height: 200,
                    //  child: ListView(
                    //    scrollDirection: Axis.horizontal,
                    //    children: <Widget>[
                    //      BoardGameFamilySearch('Deck Building', '100'),
                    //      BoardGameFamilySearch('Worker Placement', '200'),
                    //      BoardGameFamilySearch('City Building', '300'),
                    //      BoardGameFamilySearch('Economic', '400'),
                    //      BoardGameFamilySearch('Adventure', '500'),
                    //    ],
                    //  ),
                    //),
                    Container( 
                      //height: 80, 
                      width:MediaQuery.of(context).size.width,
                      child:
                        CustomSearchBar(false)
                    ),
                  ],
                ),
              ],
            ),
            Expanded( 
              child:ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: games.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(games[index].name);
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}