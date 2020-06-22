class HotDealList {
  List<Threads> threads;

  HotDealList(
    {this.threads}
  );

  HotDealList.fromJson(Map<String, dynamic> json) {
    if (json['threads'] != null) {
      threads = new List<Threads>();
      json['threads'].forEach((v) {
        threads.add(new Threads.fromJson(v));
      });
    }
  }
}

class Threads {
  String threadid;
  String shadowthreadid;
  String forumid;
  String objecttype;
  String objectid;
  String userid;
  String postdate;
  String numposts;
  String lastpostdate;
  String lastpostuserid;
  String lastpostarticleid;
  String hidden;
  String pin;
  String frontpin;
  String locked;
  String hidefrontpage;
  String subject;
  String threadPostdate;
  String threadLastpostdate;
  var numrecommend;
  String forumtitle;
  String forumuid;
  String linkname;
  User user;
  String lastpostusername;
  String objectlink;
  String forumlink;
  String forumHref;
  String forumName;
  String pagination;
  String href;
  String objecthref;
  String objectname;

  Threads(
      {this.threadid,
      this.shadowthreadid,
      this.forumid,
      this.objecttype,
      this.objectid,
      this.userid,
      this.postdate,
      this.numposts,
      this.lastpostdate,
      this.lastpostuserid,
      this.lastpostarticleid,
      this.hidden,
      this.pin,
      this.frontpin,
      this.locked,
      this.hidefrontpage,
      this.subject,
      this.threadPostdate,
      this.threadLastpostdate,
      this.numrecommend,
      this.forumtitle,
      this.forumuid,
      this.linkname,
      this.user,
      this.lastpostusername,
      this.objectlink,
      this.forumlink,
      this.forumHref,
      this.forumName,
      this.pagination,
      this.href,
      this.objecthref,
      this.objectname});

  Threads.fromJson(Map<String, dynamic> json) {
    threadid = json['threadid'];
    shadowthreadid = json['shadowthreadid'];
    forumid = json['forumid'];
    objecttype = json['objecttype'];
    objectid = json['objectid'];
    userid = json['userid'];
    postdate = json['postdate'];
    numposts = json['numposts'];
    lastpostdate = json['lastpostdate'];
    lastpostuserid = json['lastpostuserid'];
    lastpostarticleid = json['lastpostarticleid'];
    hidden = json['hidden'];
    pin = json['pin'];
    frontpin = json['frontpin'];
    locked = json['locked'];
    hidefrontpage = json['hidefrontpage'];
    subject = json['subject'];
    threadPostdate = json['thread_postdate'];
    threadLastpostdate = json['thread_lastpostdate'];
    numrecommend = json['numrecommend'];
    forumtitle = json['forumtitle'];
    forumuid = json['forumuid'];
    linkname = json['linkname'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    lastpostusername = json['lastpostusername'];
    objectlink = json['objectlink'];
    forumlink = json['forumlink'];
    forumHref = json['forum_href'];
    forumName = json['forum_name'];
    pagination = json['pagination'];
    href = json['href'];
    objecthref = json['objecthref'];
    objectname = json['objectname'];
  }
}

class User {
  String username;
  String avatar;
  String avatarfile;
  String avatarurlMd;

  User({this.username, this.avatar, this.avatarfile, this.avatarurlMd});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avatar = json['avatar'];
    avatarfile = json['avatarfile'];
    avatarurlMd = json['avatarurl_md'];
  }
}

class Forums {
  String forumid;
  String title;
  String groupid;
  String objecttype;
  String objectid;
  String description;
  String displayorder;
  String noposting;
  String geekmod;
  String adminonly;

  Forums(
      {this.forumid,
      this.title,
      this.groupid,
      this.objecttype,
      this.objectid,
      this.description,
      this.displayorder,
      this.noposting,
      this.geekmod,
      this.adminonly});

  Forums.fromJson(Map<String, dynamic> json) {
    forumid = json['forumid'];
    title = json['title'];
    groupid = json['groupid'];
    objecttype = json['objecttype'];
    objectid = json['objectid'];
    description = json['description'];
    displayorder = json['displayorder'];
    noposting = json['noposting'];
    geekmod = json['geekmod'];
    adminonly = json['adminonly'];
  }
}