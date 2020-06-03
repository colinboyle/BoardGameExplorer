import 'package:xml/xml.dart';
import 'package:html_unescape/html_unescape.dart';

class BoardGame { 
  //Used for simple list board games
  String id;
  String rank;
  String name;
  String imageUrl;

  //Used in full board game details
  String fullImageUrl;
  String yearPublished;
  String minPlayers;
  String maxPlayers;
  String minPlaytime;
  String maxPlaytime;
  String age;
  String description;
  String boardGamePublisher;
  String designer;
  List<String> mechanic; //many
  List<String> category; //many
  String rating;
  //String integration; //think this is expansions...?

  var unescape = new HtmlUnescape();


  BoardGame(this.id, this.rank, this.name, this.imageUrl);

  BoardGame.fullDetails(
    this.id, 
    this.name, 
    this.imageUrl, 
    this.fullImageUrl, 
    this.yearPublished, 
    this.minPlayers, 
    this.maxPlayers,
    this.minPlaytime,
    this.maxPlaytime,
    this.age,
    this.description,
    this.designer,
    this.boardGamePublisher,
    this.mechanic, 
    this.rating
    //this.category 
  );

  BoardGame.fromTrending(XmlElement node){
    id = node.getAttribute('id');
    rank = node.getAttribute('rank');
    imageUrl = node.findElements('thumbnail').first.getAttribute('value');
    name = node.findElements('name').first.getAttribute('value');
  }

  BoardGame.fromSearch(XmlElement node){
    id = node.getAttribute('id');
    name = node.findElements('name').first.getAttribute('value');
    yearPublished = node.findElements('yearpublished').isNotEmpty ? node.findElements('yearpublished').first.getAttribute('value') : 'None';
  }

  BoardGame.fromNodeFullDetails(XmlElement node){
    id = node.getAttribute('id');
    name = node.findAllElements('name').where((element) => element.getAttribute('type') == 'primary').first.getAttribute('value');
    imageUrl = node.findAllElements('thumbnail').first.text;
    fullImageUrl = node.findAllElements('image').first.text;
    yearPublished = node.findAllElements('yearpublished').first.getAttribute('value');
    minPlayers = node.findAllElements('minplayers').first.getAttribute('value');
    maxPlayers = node.findAllElements('maxplayers').first.getAttribute('value');
    minPlaytime = node.findAllElements('minplaytime').first.getAttribute('value');
    maxPlaytime = node.findAllElements('maxplaytime').first.getAttribute('value');
    age = node.findAllElements('minage').first.getAttribute('value');
    description = unescape.convert(node.findAllElements('description').first.text);
    designer = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamedesigner').first.getAttribute('value');
    boardGamePublisher = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamepublisher').first.getAttribute('value');
    mechanic = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamemechanic').map((n) => n.getAttribute('value')).toList();//.addAll((i) => i.getAttribute('value'));
    category = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamecategory').map((n) => n.getAttribute('value')).toList();
    rating = (node.findAllElements('ratings').first.findAllElements('average').first.getAttribute('value')+'.00').substring(0,3); //Maybe should be using a float or something since this feels hacky...
  }
}