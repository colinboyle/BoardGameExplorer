class NewReleases {
  List<Items> items;

  NewReleases({this.items});

  NewReleases.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }
}

class Items {
  String parentlink;
  Parent parent;
  Parent version;
  String versionlink;
  String date;
  String numwish;

  Items(
      {this.parentlink,
      this.parent,
      this.version,
      this.versionlink,
      this.date,
      this.numwish});

  Items.fromJson(Map<String, dynamic> json) {
    parentlink = json['parentlink'];
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    version =
        json['version'] != null ? new Parent.fromJson(json['version']) : null;
    versionlink = json['versionlink'];
    date = json['date'];
    numwish = json['numwish'];
  }
}

class Parent {
  String objecttype;
  String objectid;
  String name;
  String href;

  Parent({this.objecttype, this.objectid, this.name, this.href});

  Parent.fromJson(Map<String, dynamic> json) {
    objecttype = json['objecttype'];
    objectid = json['objectid'];
    name = json['name'];
    href = json['href'];
  }
}