import 'package:xml/xml.dart';

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
  String mechanic; //many
  String category; //many
  //String integration; //think this is expansions...?


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
    this.boardGamePublisher,
    this.mechanic, 
    //this.category 
  );

  BoardGame.fromNode(XmlElement node){
    id = node.getAttribute('id');
    rank = node.getAttribute('rank');
    imageUrl = node.findElements('thumbnail').first.getAttribute('value');
    name = node.findElements('name').first.getAttribute('value');
  }

  BoardGame.fromNodeFullDetails(XmlElement node){
    id = node.getAttribute('objectid');
    name = node.findAllElements('name').where((element) => element.getAttribute('type') == 'primary').first.getAttribute('value');
    imageUrl = node.findAllElements('thumbnail').first.text;
    fullImageUrl = node.findAllElements('image').first.text;
    yearPublished = node.findAllElements('yearpublished').first.getAttribute('value');
    minPlayers = node.findAllElements('minplayers').first.getAttribute('value');
    maxPlayers = node.findAllElements('maxplayers').first.getAttribute('value');
    minPlaytime = node.findAllElements('minplaytime').first.getAttribute('value');
    maxPlaytime = node.findAllElements('maxplaytime').first.getAttribute('value');
    age = node.findAllElements('minage').first.getAttribute('value');
    description = node.findAllElements('description').first.text;
    boardGamePublisher = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamepublisher').first.getAttribute('value');
    mechanic = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamemechanic').first.getAttribute('value');
    category = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamecategory').first.getAttribute('value');
  }
}