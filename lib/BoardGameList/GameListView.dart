
import 'package:flutter/material.dart';
import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:board_game_app/LinePainter.dart';
//import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';

class GameListView extends StatelessWidget {
  final String title;
  final List<BoardGame> games;

  const GameListView({Key key, @required this.title, @required this.games}) : super(key: key);

 @override 
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(title, style: Theme.of(context).textTheme.subtitle2),
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: games.length,
                itemBuilder: (BuildContext context, int index){
                  return GameCard( 
                    file: games[index]
                  );
                },
              )
          )
        ],
      )
    );
  }
}

class GameCard extends StatelessWidget {

  final BoardGame file;
  //static const filePath = "https://www.placehold.it/100x150";
  const GameCard({Key key, @required this.file}) : super(key: key);

  @override 
  Widget build(BuildContext context){
    return 
    InkWell(
      onTap: () {
        navigateToSubPage(context, file.id);
      },
      child: Container(  
        //width: 200,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration( 
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              offset: Offset(4,5),
              blurRadius: 5
            )
          ]
        ),
        child: Image.network(file.imageUrl) ,
    )
    );   
  }
}

Future navigateToSubPage(context, id) async {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(id)));
}