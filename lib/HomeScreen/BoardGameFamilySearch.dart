import 'package:board_game_app/utils/getHasColors.dart';
import 'package:board_game_app/utils/getSplitWords.dart';
import 'package:flutter/material.dart';

class BoardGameFamilySearch extends StatelessWidget {
  var _hashColors = new GetHashColors();
  var _splitWords = new GetSplitWords();
  String mechanic; // = 'Worker Placement';
  String id;

  BoardGameFamilySearch(this.mechanic, this.id);

  @override 
  Widget build(BuildContext context){
    _splitWords.splitWords(mechanic);
    return Align(
      alignment: Alignment.bottomLeft,
      child:Container( 
        height: 100,
        width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: _hashColors.getHashColors(mechanic)[3],),
        margin: EdgeInsets.all(10.0),
        alignment: Alignment.bottomLeft,
        //child: Positioned.fill(
          child:Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child:Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(color: _hashColors.getHashColors(mechanic)[1], borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: Text('Find More', style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
              ),
              ),
              Align(alignment: Alignment.center, child:Text('${_splitWords.firstChar}    ', style: TextStyle(color: _hashColors.getHashColors(mechanic)[2], fontSize: 70, fontWeight: FontWeight.w900))), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if(_splitWords.firstWords != null) Text(_splitWords.firstWords, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(_splitWords.lastWord, style: TextStyle(color: Colors.white, fontSize: 24 ,fontWeight: FontWeight.w800)),
                  ],
                ),
              ),
            ],
            ),
        //),
        ),
      );
  }

}