class GameVideos {
  List<Videos> videos;

  GameVideos({this.videos});

  GameVideos.fromJson(Map<String, dynamic> json) {
    if (json['videos'] != null) {
      videos = new List<Videos>();
      json['videos'].forEach((v) {
        videos.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.videos != null) {
      data['videos'] = this.videos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Videos {
  String videoid;
  String objecttype;
  String videohost;
  String extvideoid;
  String objectid;
  String userid;
  String title;
  String languageid;
  String postdate;
  String numrecommend;
  String username;
  String objectlink;
  String objecthref;
  String objectname;
  String language;
  String numcomments;
  String imageurl;
  Images images;
  String href;

  Videos(
      {this.videoid,
      this.objecttype,
      this.videohost,
      this.extvideoid,
      this.objectid,
      this.userid,
      this.title,
      this.languageid,
      this.postdate,
      this.numrecommend,
      this.username,
      this.objectlink,
      this.objecthref,
      this.objectname,
      this.language,
      this.numcomments,
      this.imageurl,
      this.images,
      this.href});

  Videos.fromJson(Map<String, dynamic> json) {
    videoid = json['videoid'];
    objecttype = json['objecttype'];
    videohost = json['videohost'];
    extvideoid = json['extvideoid'];
    objectid = json['objectid'];
    userid = json['userid'];
    title = json['title'];
    languageid = json['languageid'];
    postdate = json['postdate'];
    numrecommend = json['numrecommend'];
    username = json['username'];
    objectlink = json['objectlink'];
    objecthref = json['objecthref'];
    objectname = json['objectname'];
    language = json['language'];
    numcomments = json['numcomments'];
    imageurl = json['imageurl'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['videoid'] = this.videoid;
    data['objecttype'] = this.objecttype;
    data['videohost'] = this.videohost;
    data['extvideoid'] = this.extvideoid;
    data['objectid'] = this.objectid;
    data['userid'] = this.userid;
    data['title'] = this.title;
    data['languageid'] = this.languageid;
    data['postdate'] = this.postdate;
    data['numrecommend'] = this.numrecommend;
    data['username'] = this.username;
    data['objectlink'] = this.objectlink;
    data['objecthref'] = this.objecthref;
    data['objectname'] = this.objectname;
    data['language'] = this.language;
    data['numcomments'] = this.numcomments;
    data['imageurl'] = this.imageurl;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['href'] = this.href;
    return data;
  }
}

class Images {
  String square;
  String thumb;
  String featured;

  Images({this.square, this.thumb, this.featured});

  Images.fromJson(Map<String, dynamic> json) {
    square = json['square'];
    thumb = json['thumb'];
    featured = json['featured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['square'] = this.square;
    data['thumb'] = this.thumb;
    data['featured'] = this.featured;
    return data;
  }
}