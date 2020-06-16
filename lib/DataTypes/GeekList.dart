class GeekList {
  List<Lists> lists;
  Config config;

  GeekList({this.lists, this.config});

  GeekList.fromJson(Map<String, dynamic> json) {
    if (json['lists'] != null) {
      lists = new List<Lists>();
      json['lists'].forEach((v) {
        lists.add(new Lists.fromJson(v));
      });
    }
    config =
        json['config'] != null ? new Config.fromJson(json['config']) : null;
  }
}

class Lists {
  String href;
  String numpositive;
  String username;
  String numitems;
  String title;
  Null postdate;
  Null lastreplydate;
  String pagination;

  Lists(
      {this.href,
      this.numpositive,
      this.username,
      this.numitems,
      this.title,
      this.postdate,
      this.lastreplydate,
      this.pagination});

  Lists.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    numpositive = json['numpositive'];
    username = json['username'];
    numitems = json['numitems'];
    title = json['title'];
    postdate = json['postdate'];
    lastreplydate = json['lastreplydate'];
    pagination = json['pagination'];
  }
}

class Config {
  String showcontrols;
  List<Sorttypes> sorttypes;
  Null numitems;
  int endpage;

  Config({this.showcontrols, this.sorttypes, this.numitems, this.endpage});

  Config.fromJson(Map<String, dynamic> json) {
    showcontrols = json['showcontrols'];
    if (json['sorttypes'] != null) {
      sorttypes = new List<Sorttypes>();
      json['sorttypes'].forEach((v) {
        sorttypes.add(new Sorttypes.fromJson(v));
      });
    }
    numitems = json['numitems'];
    endpage = json['endpage'];
  }
}

class Sorttypes {
  String name;
  String type;

  Sorttypes({this.name, this.type});

  Sorttypes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
  }
}