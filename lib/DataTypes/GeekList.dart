import 'package:board_game_app/DataTypes/BoardGame.dart';
import 'package:xml/xml.dart';
import 'package:html_unescape/html_unescape.dart';

class GeekList { 
  String id;
  String postdate;
  String editdate;
  String thumbs;
  String numitems;
  String username;
  String title;
  String description;
  List<GeekListItem> items;

  var unescape = new HtmlUnescape();


  //GeekList(this.id, this.rank, this.name, this.imageUrl);

  GeekList.fromXml(XmlDocument element){
    id = element.getAttribute('id');
    postdate = element.findAllElements('postdate').first.text;
    editdate = element.findAllElements('editdate').first.text.substring(0,16);
    thumbs = element.findAllElements('thumbs').first.text;
    numitems = element.findAllElements('numitems').first.text;
    username = element.findAllElements('username').first.text;
    title = element.findAllElements('title').first.text;
    description = element.findAllElements('description').first.text;
    if(element.findAllElements('item').length > 0) {
      items = new List<GeekListItem>();
      element.findAllElements('item').forEach((element) {
        items.add(new GeekListItem.fromXml(element));
      });
    }
  }
}

class GeekListItem extends BoardGame {
  String id;
  String objecttype;
  String subtype;
  String objectid;
  String objectname;
  String username;
  String postdate;
  String editdate;
  String thumbs;
  String imageid;
  String body;

  String imageUrl;
  String yearPublished;
  String recPlayers;
  String recPlaytime;
  String age;
  String rating;
  String weight;
  List<Ranks> ranks;


  GeekListItem.fromXml(XmlElement element){
    id = element.getAttribute('id');
    objecttype = element.getAttribute('objecttype');
    subtype = element.getAttribute('subtype');
    objectid = element.getAttribute('objectid');
    objectname = element.getAttribute('objectname');
    username = element.getAttribute('username');
    postdate = element.getAttribute('postdate');
    editdate = element.getAttribute('editdate');
    thumbs = element.getAttribute('thumbs');
    imageid = element.getAttribute('imageid');
    body = element.findAllElements('body').first.text;
  }

  addGameDetails(String imageurl, String yearpub, String recplayers, String recplaytime, String playage, String playrating, String playweight, List<Ranks> gameranks){
   this.imageUrl = imageurl;
   this.yearPublished = yearpub;
   this.recPlayers = recplayers;
   this.recPlaytime = recplaytime;
   this.age = playage;
   this.rating = playrating;
   this.weight = playweight;
   this.ranks = gameranks;
  }
}