//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:xml/xml.dart' as xml;
//
//class HotItems extends StatefulWidget {
//  @override
//  HotItemState createState() => HotItemState();
//}
//
//class HotItemState extends State<HotItems> {
//  List<BoardGame> _boardgames = <BoardGame>[];
//  bool _loading = true;
//  String _error;
//
//  @override
//  void initState() {
//    _boardgames = <BoardGame>[];
//    _loading = true;
//    _error = null;
//
//    getHotItems();
//    super.initState();
//  }
//
//  Future<Iterable<BoardGame>> getHotItems() async {
//    var url = 'https://www.boardgamegeek.com/xmlapi2/hot?type=boardgame';
//    // Await the http get response, then decode the xml
//    var response = await http.get(url);
//    print(response.statusCode);
//    if (response.statusCode == 200) {
//      final document = xml.parse(response.body);
//      final items = document.findAllElements('item').toList();
//      setState(() { _loading = false;});
//      items
//        .map((node){
//          var id = node.getAttribute('id');
//          var rank = node.getAttribute('rank');
//          var name = node.findElements('name').first.getAttribute('value');
//          //var imageUrl = node.findElements('thumbnail').first.getAttribute('value');
//          return BoardGame(id, rank, name);
//        })
//        .forEach((element) {setState((){_boardgames.add(element);});
//        });
//    } else {
//      setState(() { _error= "failed to fetch hot items";});
//      setState(() { _loading = false;});
//      //return null
//    }
//  }
//
//
//  Widget _buildList() {
//    return ListView.builder(
//      //padding: const EdgeInsets.all(4),
//      //itemCount: _boardgames.length * 2,
//      itemBuilder: (context, item) {
//        //if(item.isOdd) return Divider();
//
//        //final index = item ~/ 2;
//
//        //if(index >= _boardgames.length) {
//        //  _boardgames.addAll(getHotI;
//        //}
//
//        return _buildRow(_boardgames[item]);
//      }
//    );
//  }
//  
//   Widget _buildRow(BoardGame game) {
//    //print(_boardgames[index].imageUrl);
//    return ListTile(
//      leading: SizedBox(width: 200, height: 150, child: Image.network("https://www.placehold.it/200x150")),
//      title: Text(game.name, style: TextStyle(fontSize: 10)),
//    );
//  }
//
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Board Game Manager 3'),
//      ),
//
//      body: _buildList(),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () => {
//          getHotItems()
//        }
//      ),
//    );
//  }
//}

//class BoardGame {
//  final String id;
//  final String rank;
//  final String name;
//  //final String imageUrl;
//
//  BoardGame(this.id, this.rank, this.name);
//}