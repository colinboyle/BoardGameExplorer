//import 'package:http/http.dart' as http;
//import 'package:xml/xml.dart' as xml;  
//import './BoardGame.dart';
  

//List<BoardGame> getHotItems() {
//  return [];
//}



//List<BoardGame> getHotItems() {
//  List<BoardGame> games = <BoardGame>[];
//  gettingHotItems().then((result) => games = result).then((){
//  return games;
//  });  
//}
//
//Future<List<BoardGame>> gettingHotItems() async {
//  List<BoardGame> boardGames = <BoardGame>[];
//  var url = 'https://www.boardgamegeek.com/xmlapi2/hot?type=boardgame';
//  var response = await http.get(url);
//
//  if (response.statusCode == 200) {
//    final document = xml.parse(response.body);
//    final items = document.findAllElements('item').toList();
//    items
//      .map((node){
//        var id = node.getAttribute('id');
//        var rank = node.getAttribute('rank');
//        var name = node.findElements('name').first.getAttribute('value');
//        //var imageUrl = node.findElements('thumbnail').first.getAttribute('value');
//        return BoardGame(id, rank, name);
//      })
//      .forEach((element) {boardGames.add(element);});
//    return boardGames;
//  } else {
//
//    return boardGames;
//  }
//}