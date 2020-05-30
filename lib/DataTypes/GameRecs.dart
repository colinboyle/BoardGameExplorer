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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recs != null) {
      data['recs'] = this.recs.map((v) => v.toJson()).toList();
    }
    data['numrecs'] = this.numrecs;
    return data;
  }
}

class Recs {
  RecItem recitem;

  Recs({this.recitem});

  Recs.fromJson(Map<String, dynamic> json) {

    recitem = json['item'] != null ? new RecItem.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recitem != null) {
      data['item'] = this.recitem.toJson();
    }
    return data;
  }
}

class RecItem {
  Item item;

  RecItem({this.item});

  RecItem.fromJson(Map<String, dynamic> json) {

    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    return data;
  }
}

class Item {
  String href;
  Primaryname primaryname;
  Images images;
  DynamicInfo dynamicinfo;

  Item({this.href, this.primaryname, this.images, this.dynamicinfo});

  Item.fromJson(Map<String, dynamic> json) {

    href = json['href'];
    primaryname = json['primaryname'] != null
        ? new Primaryname.fromJson(json['primaryname'])
        : null;
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    dynamicinfo = json['dynamicinfo'] != null
        ? new DynamicInfo.fromJson(json['dynamicinfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    if (this.primaryname != null) {
      data['primaryname'] = this.primaryname.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.dynamicinfo != null) {
      data['dynamicinfo'] = this.dynamicinfo.toJson();
    }
    return data;
  }
}

class Primaryname {
  String nameid;
  String name;
  String sortindex;
  String primaryname;
  String translit;

  Primaryname(
      {this.nameid,
      this.name,
      this.sortindex,
      this.primaryname,
      this.translit});

  Primaryname.fromJson(Map<String, dynamic> json) {

    nameid = json['nameid'];
    name = json['name'];
    sortindex = json['sortindex'];
    primaryname = json['primaryname'];
    translit = json['translit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameid'] = this.nameid;
    data['name'] = this.name;
    data['sortindex'] = this.sortindex;
    data['primaryname'] = this.primaryname;
    data['translit'] = this.translit;
    return data;
  }
}

class Images {
  String thumb;
  String micro;
  String square;
  String squarefit;
  String tallthumb;
  String previewthumb;
  String square200;

  Images(
      {this.thumb,
      this.micro,
      this.square,
      this.squarefit,
      this.tallthumb,
      this.previewthumb,
      this.square200});

  Images.fromJson(Map<String, dynamic> json) {

    thumb = json['thumb'];
    micro = json['micro'];
    square = json['square'];
    squarefit = json['squarefit'];
    tallthumb = json['tallthumb'];
    previewthumb = json['previewthumb'];
    square200 = json['square200'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['micro'] = this.micro;
    data['square'] = this.square;
    data['squarefit'] = this.squarefit;
    data['tallthumb'] = this.tallthumb;
    data['previewthumb'] = this.previewthumb;
    data['square200'] = this.square200;
    return data;
  }
}

class DynamicInfo {
  DynamicInfoItem item;

  DynamicInfo({this.item});

  DynamicInfo.fromJson(Map<String, dynamic> json) {

    item = json['item'] != null ? new DynamicInfoItem.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.item != null) {
      data['item'] = this.item.toJson();
    }
    return data;
  }
}

class DynamicInfoItem {
  List<Rankinfo> rankinfo;
  Polls polls;
  Stats stats;

  DynamicInfoItem({this.rankinfo, this.polls, this.stats});

  DynamicInfoItem.fromJson(Map<String, dynamic> json) {

    if (json['rankinfo'] != null) {
      rankinfo = new List<Rankinfo>();
      json['rankinfo'].forEach((v) {
        rankinfo.add(new Rankinfo.fromJson(v));
      });
    }
    polls = json['polls'] != null ? new Polls.fromJson(json['polls']) : null;
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rankinfo != null) {
      data['rankinfo'] = this.rankinfo.map((v) => v.toJson()).toList();
    }
    if (this.polls != null) {
      data['polls'] = this.polls.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    return data;
  }
}

class Rankinfo {
  String prettyname;
  String shortprettyname;
  String veryshortprettyname;
  String subdomain;
  String rankobjecttype;
  int rankobjectid;
  String rank;
  String baverage;

  Rankinfo(
      {this.prettyname,
      this.shortprettyname,
      this.veryshortprettyname,
      this.subdomain,
      this.rankobjecttype,
      this.rankobjectid,
      this.rank,
      this.baverage});

  Rankinfo.fromJson(Map<String, dynamic> json) {

    prettyname = json['prettyname'];
    shortprettyname = json['shortprettyname'];
    veryshortprettyname = json['veryshortprettyname'];
    subdomain = json['subdomain'];
    rankobjecttype = json['rankobjecttype'];
    rankobjectid = json['rankobjectid'];
    rank = json['rank'];
    baverage = json['baverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prettyname'] = this.prettyname;
    data['shortprettyname'] = this.shortprettyname;
    data['veryshortprettyname'] = this.veryshortprettyname;
    data['subdomain'] = this.subdomain;
    data['rankobjecttype'] = this.rankobjecttype;
    data['rankobjectid'] = this.rankobjectid;
    data['rank'] = this.rank;
    data['baverage'] = this.baverage;
    return data;
  }
}

class Polls {
  Userplayers userplayers;
  String playerage;
  String languagedependence;
  String subdomain;
  Boardgameweight boardgameweight;

  Polls(
      {this.userplayers,
      this.playerage,
      this.languagedependence,
      this.subdomain,
      this.boardgameweight});

  Polls.fromJson(Map<String, dynamic> json) {
    
    userplayers = json['userplayers'] != null
        ? new Userplayers.fromJson(json['userplayers'])
        : null;
    playerage = json['playerage'];
    languagedependence = json['languagedependence'];
    subdomain = json['subdomain'];
    boardgameweight = json['boardgameweight'] != null
        ? new Boardgameweight.fromJson(json['boardgameweight'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userplayers != null) {
      data['userplayers'] = this.userplayers.toJson();
    }
    data['playerage'] = this.playerage;
    data['languagedependence'] = this.languagedependence;
    data['subdomain'] = this.subdomain;
    if (this.boardgameweight != null) {
      data['boardgameweight'] = this.boardgameweight.toJson();
    }
    return data;
  }
}

class Userplayers {
  List<Best> best;
  //List<Recommended> recommended;
  String totalvotes;

  Userplayers({this.best, this.totalvotes}); //this.recommended,

  Userplayers.fromJson(Map<String, dynamic> json) {
    if (json['best'] != null) {
      best = new List<Best>();
      json['best'].forEach((v) {
        best.add(new Best.fromJson(v));
      });
    }
    //if (json['recommended'] != null) {
      //recommended = new List<Recommended>();
      //json['recommended'].forEach((v) {
      //  recommended.add(new Recommended.fromJson(v));
      //});
    //}
    totalvotes = json['totalvotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.best != null) {
      data['best'] = this.best.map((v) => v.toJson()).toList();
    }
    //if (this.recommended != null) {
    //  data['recommended'] = this.recommended.map((v) => v.toJson()).toList();
    //}
    data['totalvotes'] = this.totalvotes;
    return data;
  }
}

class Best {
  int min;
  int max;

  Best({this.min, this.max});

  Best.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}

class Boardgameweight {
  double averageweight;
  String votes;

  Boardgameweight({this.averageweight, this.votes});

  Boardgameweight.fromJson(Map<String, dynamic> json) {
    averageweight = json['averageweight'] + 0.0;
    votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageweight'] = this.averageweight;
    data['votes'] = this.votes;
    return data;
  }
}

class Stats {
  String usersrated;
  String average;
  String baverage;
  String stddev;
  String avgweight;
  String numweights;
  String numgeeklists;
  String numtrading;
  String numwanting;
  String numwish;
  String numowned;
  String numprevowned;
  String numcomments;
  String numwishlistcomments;
  String numhasparts;
  String numwantparts;
  String views;
  String playmonth;
  String numplays;
  var numplaysMonth;
  int numfans;

  Stats(
      {this.usersrated,
      this.average,
      this.baverage,
      this.stddev,
      this.avgweight,
      this.numweights,
      this.numgeeklists,
      this.numtrading,
      this.numwanting,
      this.numwish,
      this.numowned,
      this.numprevowned,
      this.numcomments,
      this.numwishlistcomments,
      this.numhasparts,
      this.numwantparts,
      this.views,
      this.playmonth,
      this.numplays,
      this.numplaysMonth,
      this.numfans});

  Stats.fromJson(Map<String, dynamic> json) {
    usersrated = json['usersrated'];
    average = json['average'];
    baverage = json['baverage'];
    stddev = json['stddev'];
    avgweight = json['avgweight'];
    numweights = json['numweights'];
    numgeeklists = json['numgeeklists'];
    numtrading = json['numtrading'];
    numwanting = json['numwanting'];
    numwish = json['numwish'];
    numowned = json['numowned'];
    numprevowned = json['numprevowned'];
    numcomments = json['numcomments'];
    numwishlistcomments = json['numwishlistcomments'];
    numhasparts = json['numhasparts'];
    numwantparts = json['numwantparts'];
    views = json['views'];
    playmonth = json['playmonth'];
    numplays = json['numplays'];
    numplaysMonth = json['numplays_month'];
    numfans = json['numfans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['usersrated'] = this.usersrated;
    data['average'] = this.average;
    data['baverage'] = this.baverage;
    data['stddev'] = this.stddev;
    data['avgweight'] = this.avgweight;
    data['numweights'] = this.numweights;
    data['numgeeklists'] = this.numgeeklists;
    data['numtrading'] = this.numtrading;
    data['numwanting'] = this.numwanting;
    data['numwish'] = this.numwish;
    data['numowned'] = this.numowned;
    data['numprevowned'] = this.numprevowned;
    data['numcomments'] = this.numcomments;
    data['numwishlistcomments'] = this.numwishlistcomments;
    data['numhasparts'] = this.numhasparts;
    data['numwantparts'] = this.numwantparts;
    data['views'] = this.views;
    data['playmonth'] = this.playmonth;
    data['numplays'] = this.numplays;
    data['numplays_month'] = this.numplaysMonth;
    data['numfans'] = this.numfans;
    return data;
  }
}