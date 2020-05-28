//import 'package:xml/xml.dart';

class GameImages {
  List<Images> images;

  GameImages({this.images});

  GameImages.fromJson(Map<String, dynamic> json) {
    if (json['images'] != null) {
      images = new List<Images>();
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String imageid;
  String imageurlLg;
  String name;
  String caption;
  String numrecommend;
  String numcomments;
  User user;
  String imageurl;
  String href;

  Images(
      {this.imageid,
      this.imageurlLg,
      this.name,
      this.caption,
      this.numrecommend,
      this.numcomments,
      this.user,
      this.imageurl,
      this.href});

  Images.fromJson(Map<String, dynamic> json) {
    imageid = json['imageid'];
    imageurlLg = json['imageurl_lg'];
    name = json['name'];
    caption = json['caption'];
    numrecommend = json['numrecommend'];
    numcomments = json['numcomments'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    imageurl = json['imageurl'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageid'] = this.imageid;
    data['imageurl_lg'] = this.imageurlLg;
    data['name'] = this.name;
    data['caption'] = this.caption;
    data['numrecommend'] = this.numrecommend;
    data['numcomments'] = this.numcomments;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['imageurl'] = this.imageurl;
    data['href'] = this.href;
    return data;
  }
}

class User {
  String username;
  String avatar;
  String avatarfile;

  User({this.username, this.avatar, this.avatarfile});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    avatarfile = json['avatarfile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['avatarfile'] = this.avatarfile;
    return data;
  }
}