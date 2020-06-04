import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:board_game_app/DataTypes/BoardGame.dart';

import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';
import 'package:board_game_app/Layout/SearchBar/BoardGameFamilySearch.dart';

import 'package:board_game_app/Layout/SearchBar/search_bar_bloc.dart';

import '../../main.dart';

class CustomSearchBar extends StatefulWidget {
  final bool hasFamilySearch;
  CustomSearchBar(this.hasFamilySearch);
  @override 
  _CustomSearchBarState createState() => _CustomSearchBarState();

}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _filter = new TextEditingController();
  SearchBarBloc _bloc;
  String _searchText = "";
  List<BoardGame> gameResults;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle;

  _CustomSearchBarState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          gameResults = null;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
        if(_searchText.length > 4){
          _getSearchResults();
        }
      }
    });
  }

  @override
  void initState() {
    _setAppBarToSearch(false);
    _bloc = SearchBarBloc();
    super.initState();
  }

  
  Widget build(BuildContext context) {
    return 
    Container( width: MediaQuery.of(context).size.width, child:
      Stack(
        children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: widget.hasFamilySearch ? 120 : 100,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(43, 79, 122, 1)
            ),
            Container(
              height: 15,
              width: MediaQuery.of(context).size.width,
              color: Color.fromRGBO(21, 47, 90, 1)
            ),
          ]),
          if(widget.hasFamilySearch) ...[
          Container(
            width: MediaQuery.of(context).size.width,
            //color: Colors.green,
            height: 220,
            child: Align( alignment: Alignment.bottomLeft, child: ListView(
              padding: EdgeInsetsDirectional.only(top:20),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                  BoardGameFamilySearch('Card Drafting', '2041'),
                  BoardGameFamilySearch('Worker Placement', '2082'),
                  BoardGameFamilySearch('Drafting', '2984'),
                  BoardGameFamilySearch('Role Playing', '2028'),
                  BoardGameFamilySearch('Co-op Game', '2023'),
              ],
            ),
            ),
          ),
          ],
          Container( 
            width:MediaQuery.of(context).size.width,
            child:Stack(
              children: <Widget>[
                _buildList(),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10) ,child:_buildBar(context)),
            ]),
          )
        ])
    );
  }

  Widget _buildBar(BuildContext context) {
    return
    Container(height: 110,child: 
      Row(mainAxisAlignment: MainAxisAlignment.start ,children: <Widget>[
        _appBarTitle,
        IconButton(icon: _searchIcon, onPressed: () {_searchPressed();},),
      ])
    );
  }

  Widget _buildList() {
    if(gameResults != null && gameResults.length >0){
      return 
      Column( children: <Widget>[
        SizedBox(height: 100,),
        Container(
        //padding: EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height -100,
        color: Colors.black87,
        child: ListView.builder(
          itemCount: gameResults.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  //_searchPressed(); 
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(gameResults[index].id, null, true)));
                },
                child:
                Container(
                  color: Colors.white, 
                  //width: MediaQuery.of(context).size.width - 60,
                  height: 100,
                  child: Row(children: <Widget>[
                    Container( alignment: Alignment.center, width: MediaQuery.of(context).size.width - 60, child:
                      AutoSizeText(gameResults[index].name, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3),
                    )
                  ])
                )
              ) 
            );
          })
      )]);
    }
    return Container();//child: Text('Looking for da games', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white))); //color: Colors.green, );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        _setAppBarToSearch(true);
        
      } else {
        this._searchIcon = new Icon(Icons.search);
        _setAppBarToSearch(false);
        _filter.clear();
      }
    });
  }

  _setAppBarToSearch(bool toSearch){
    //Search Bar
    if(toSearch){
      this._appBarTitle = 
      Expanded( child:
      Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        TextField(
            style: TextStyle(fontSize: 20),
            controller: _filter,
            decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: 'Search...'
            ),
          ) 
      ]));
    } 
    //App Header
    else {
    this._appBarTitle = 
      Expanded( child:
        Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));}, child:
          Row(children: <Widget>[
            Image(image: AssetImage('assets/FirstLogo.png')),
            SizedBox(width: 10,),
            Text('Geek Explorer', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w600)),
            Spacer(),
          ])),
        ])
      );
    }
  }

  void _getSearchResults() async {
    final response = await _bloc.fetchSearchResult(_searchText);
    print(response);
    setState(() {
      gameResults = response;
    });
  }


}