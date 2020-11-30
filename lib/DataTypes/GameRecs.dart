class GameRecs {
  List<Recs> recs;
  int numrecs;

  GameRecs({this.recs, this.numrecs});

  GameRecs.fromJson(Map<String, dynamic> json) {
    if (json['recs'] != null) {
      recs = new List<Recs>();
      json['recs'].forEach((v) {
        recs.add(new Recs.fromJson(v));
      });
    }
    numrecs = json['numrecs'];
  }
}

class Recs {
  String description;
  Item item;
  Square100 image;
  Square100 topImage;
  double rating;
  int rank;
  String yearpublished;
  int numfans;

  Recs(
      {this.description,
      this.item,
      this.image,
      this.topImage,
      this.rating,
      this.rank,
      this.yearpublished,
      this.numfans});

  Recs.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    image =
        json['image'] != null ? new Square100.fromJson(json['image']) : null;
    topImage = json['topImage'] != null
        ? new Square100.fromJson(json['topImage'])
        : null;
    rating = json['rating'];
    rank = json['rank'];
    yearpublished = json['yearpublished'];
    numfans = json['numfans'];
  }
}

class Item {
  String type;
  String id;
  String name;
  String href;
  String label;
  String labelpl;
  bool hasAngularLink;
  int imageid;
  ImageSets imageSets;

  Item(
      {this.type,
      this.id,
      this.name,
      this.href,
      this.label,
      this.labelpl,
      this.hasAngularLink,
      this.imageid,
      this.imageSets});

  Item.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    name = json['name'];
    href = json['href'];
    label = json['label'];
    labelpl = json['labelpl'];
    hasAngularLink = json['hasAngularLink'];
    imageid = json['imageid'];
    imageSets = json['imageSets'] != null
        ? new ImageSets.fromJson(json['imageSets'])
        : null;
  }
}

class ImageSets {
  Square100 square100;

  ImageSets({this.square100});

  ImageSets.fromJson(Map<String, dynamic> json) {
    square100 = json['square100'] != null
        ? new Square100.fromJson(json['square100'])
        : null;
  }
}

class Square100 {
  String src;
  String src2x;

  Square100({this.src, this.src2x});

  Square100.fromJson(Map<String, dynamic> json) {
    src = json['src'];
    src2x = json['src@2x'];
  }
}