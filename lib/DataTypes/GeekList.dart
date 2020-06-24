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
    editdate = element.findAllElements('editdate').first.text;
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

class GeekListItem {
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
}