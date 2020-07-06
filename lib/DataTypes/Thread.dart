class Thread {
  List<Articles> articles;
  int pageid;
  int perPage;
  int total;

  Thread({this.articles, this.pageid, this.perPage, this.total});

  Thread.fromJson(Map<String, dynamic> json) {
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
    pageid = json['pageid'];
    perPage = json['perPage'];
    total = json['total'];
  }
}

class Articles {
  String type;
  String id;
  //Source source;
  bool firstPost;
  String href;
  bool collapsed;
  bool rollsEnabled;
  //AdminStatus adminStatus;
  //List<Links> links;
  int author;
  String postdate;
  String editdate;
  String body;
  String bodyXml;
  int rollsCount;

  Articles(
      {this.type,
      this.id,
      //this.source,
      this.firstPost,
      this.href,
      this.collapsed,
      this.rollsEnabled,
      //this.adminStatus,
      //this.links,
      this.author,
      this.postdate,
      this.editdate,
      this.body,
      this.bodyXml,
      this.rollsCount});

  Articles.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    //source =
    //    json['source'] != null ? new Source.fromJson(json['source']) : null;
    firstPost = json['firstPost'];
    href = json['href'];
    collapsed = json['collapsed'];
    rollsEnabled = json['rollsEnabled'];
    //adminStatus = json['adminStatus'] != null
    //    ? new AdminStatus.fromJson(json['adminStatus'])
    //    : null;
    //if (json['links'] != null) {
    //  links = new List<Links>();
    //  json['links'].forEach((v) {
    //    links.add(new Links.fromJson(v));
    //  });
    //}
    author = json['author'];
    postdate = json['postdate'];
    editdate = json['editdate'];
    body = json['body'];
    bodyXml = json['bodyXml'];
    rollsCount = json['rollsCount'];
  }
}

//class Source {
//  String type;
//  String id;
//
//  Source({this.type, this.id});
//
//  Source.fromJson(Map<String, dynamic> json) {
//    type = json['type'];
//    id = json['id'];
//  }
//}

//class AdminStatus {
//  String visibility;
//  String stub;
//
//  AdminStatus({this.visibility, this.stub});
//
//  AdminStatus.fromJson(Map<String, dynamic> json) {
//    visibility = json['visibility'];
//    stub = json['stub'];
//  }
//}

//class Links {
//  String rel;
//  String uri;
//
//  Links({this.rel, this.uri});
//
//  Links.fromJson(Map<String, dynamic> json) {
//    rel = json['rel'];
//    uri = json['uri'];
//  }
//}
