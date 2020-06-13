import 'package:flutter/material.dart';
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
  List<Mechanic> mechanic; //many
  List<String> category; //many
  String rating;
  String weight;
  List<Ranks> ranks;
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
    this.rating,
    this.weight
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
    imageUrl = node.findAllElements('thumbnail').length>0 ? node.findAllElements('thumbnail').first.text : 'https://via.placeholder.com/200x150?text=No%20Image%20Available';
    fullImageUrl = node.findAllElements('image').length>0 ? node.findAllElements('image').first.text : 'https://via.placeholder.com/200x150?text=No%20Image%20Available';
    yearPublished = node.findAllElements('yearpublished').first.getAttribute('value');
    minPlayers = node.findAllElements('minplayers').first.getAttribute('value');
    maxPlayers = node.findAllElements('maxplayers').first.getAttribute('value');
    minPlaytime = node.findAllElements('minplaytime').first.getAttribute('value');
    maxPlaytime = node.findAllElements('maxplaytime').first.getAttribute('value');
    age = node.findAllElements('minage').first.getAttribute('value');
    description = unescape.convert(node.findAllElements('description').first.text);
    designer = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamedesigner').first.getAttribute('value') ?? '';
    boardGamePublisher = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamepublisher').first.getAttribute('value');
    mechanic = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamemechanic').map((n) => new Mechanic.fromNode(n)).toList();//n.getAttribute('value')).toList();//.addAll((i) => i.getAttribute('value'));
    category = node.findAllElements('link').where((element) => element.getAttribute('type') == 'boardgamecategory').map((n) => n.getAttribute('value')).toList();
    rating = (node.findAllElements('ratings').first.findAllElements('average').first.getAttribute('value')+'.00').substring(0,3); //Maybe should be using a float or something since this feels hacky...
    weight = (node.findAllElements('ratings').first.findAllElements('averageweight').first.getAttribute('value')+'.00').substring(0,3); 
    if(node.findAllElements('statistics').first.findAllElements('ratings').first.findAllElements('ranks').first.findAllElements('rank') != null ){
      ranks = new List<Ranks>();
      node.findAllElements('statistics').first.findAllElements('ratings').first.findAllElements('ranks').first.findAllElements('rank').forEach((e) => ranks.add( new Ranks.fromXml(e)));
    }
  }
}

class Mechanic {
  String name;
  String id;

  Mechanic(this.name, this.id);

  Mechanic.fromNode(XmlElement node){
    name = node.getAttribute('value');
    id = node.getAttribute('id');
  }
}

class Ranks {
  String id;
  String name;
  String value;

  Ranks(this.id, this.name, this.value);

  Ranks.fromXml(XmlElement rank){
    id = rank.getAttribute('id');
    value = rank.getAttribute('value');
    name = rank.getAttribute('friendlyname').replaceAll(' Rank', '');
  }
}