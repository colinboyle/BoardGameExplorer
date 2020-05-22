import 'package:flutter/material.dart';

class BoardGameFamilySearch extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.bottomLeft,
      child:Container( 
        height: 100,
        width: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15.0)), color: Colors.red[300],),
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
                  decoration: BoxDecoration(color: Colors.red[500], borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                  child: Text('Find More', style: TextStyle(fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
              ),
              ),
              Align(alignment: Alignment.center, child:Text('W    ', style: TextStyle(color: Colors.red[400], fontSize: 70, fontWeight: FontWeight.w500))), 
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Worker', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                    Text('PLACEMENT', style: TextStyle(color: Colors.white, fontSize: 24 ,fontWeight: FontWeight.w800)),
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