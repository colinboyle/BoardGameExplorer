class MarketOffers {
	Linkeditem linkeditem;
	String objecttype;
	String objectid;
	List<Products> products;
	Config config;

	MarketOffers({this.linkeditem, this.objecttype, this.objectid, this.products, this.config});

	MarketOffers.fromJson(Map<String, dynamic> json) {
		linkeditem = json['linkeditem'] != null ? new Linkeditem.fromJson(json['linkeditem']) : null;
		objecttype = json['objecttype'];
		objectid = json['objectid'];
		if (json['products'] != null) {
			products = new List<Products>();
			json['products'].forEach((v) { products.add(new Products.fromJson(v)); });
		}
		config = json['config'] != null ? new Config.fromJson(json['config']) : null;
	}
}

class Linkeditem {
	String type;
	String id;
	String name;
	String href;
	String label;
	String labelpl;
	int imageid;
	MOImage image;

	Linkeditem({this.type, this.id, this.name, this.href, this.label, this.labelpl, this.imageid, this.image});

	Linkeditem.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		id = json['id'];
		name = json['name'];
		href = json['href'];
		label = json['label'];
		labelpl = json['labelpl'];
		imageid = json['imageid'];
		image = json['image'] != null ? new MOImage.fromJson(json['image']) : null;
	}
}

class MOImage {
	String type;
	String id;
	Dimensions dimensions;
	int imageid;
	String caption;
	String postdate;
	String gallery;
	int uploader;
	String extension;
	bool blocksAds;
	bool hidden;
	Source source;
	String href;
	String canonicalLink;
	String browseHref;
	MOImages images;
	List<Links> links;

	MOImage({this.type, this.id, this.dimensions, this.imageid, this.caption, this.postdate, this.gallery, this.uploader, this.extension, this.blocksAds, this.hidden, this.source, this.href, this.canonicalLink, this.browseHref, this.images, this.links});

	MOImage.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		id = json['id'];
		dimensions = json['dimensions'] != null ? new Dimensions.fromJson(json['dimensions']) : null;
		imageid = json['imageid'];
		caption = json['caption'];
		postdate = json['postdate'];
		gallery = json['gallery'];
		uploader = json['uploader'];
		extension = json['extension'];
		blocksAds = json['blocks_ads'];
		hidden = json['hidden'];
		source = json['source'] != null ? new Source.fromJson(json['source']) : null;
		href = json['href'];
		canonicalLink = json['canonical_link'];
		browseHref = json['browse_href'];
		images = json['images'] != null ? new MOImages.fromJson(json['images']) : null;
		if (json['links'] != null) {
			links = new List<Links>();
			json['links'].forEach((v) { links.add(new Links.fromJson(v)); });
		}
	}
}

class Dimensions {
	int width;
	int height;

	Dimensions({this.width, this.height});

	Dimensions.fromJson(Map<String, dynamic> json) {
		width = json['width'];
		height = json['height'];
	}
}

class Source {
	String type;
	String id;

	Source({this.type, this.id});

	Source.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		id = json['id'];
	}
}

class MOImages {
	Micro micro;
	Mediacard small;
	Micro medium;
	Micro large;
	Mediacard square;
	Micro itempage;
	Micro imagepage;
	Micro imagepagezoom;
	Micro expanded;
	Micro crop100;
	Micro square200;
	Mediacard mediacard;
	Micro original;

	MOImages({this.micro, this.small, this.medium, this.large, this.square, this.itempage, this.imagepage, this.imagepagezoom, this.expanded, this.crop100, this.square200, this.mediacard, this.original});

	MOImages.fromJson(Map<String, dynamic> json) {
		micro = json['micro'] != null ? new Micro.fromJson(json['micro']) : null;
		small = json['small'] != null ? new Mediacard.fromJson(json['small']) : null;
		medium = json['medium'] != null ? new Micro.fromJson(json['medium']) : null;
		large = json['large'] != null ? new Micro.fromJson(json['large']) : null;
		square = json['square'] != null ? new Mediacard.fromJson(json['square']) : null;
		itempage = json['itempage'] != null ? new Micro.fromJson(json['itempage']) : null;
		imagepage = json['imagepage'] != null ? new Micro.fromJson(json['imagepage']) : null;
		imagepagezoom = json['imagepagezoom'] != null ? new Micro.fromJson(json['imagepagezoom']) : null;
		expanded = json['expanded'] != null ? new Micro.fromJson(json['expanded']) : null;
		crop100 = json['crop100'] != null ? new Micro.fromJson(json['crop100']) : null;
		square200 = json['square200'] != null ? new Micro.fromJson(json['square200']) : null;
		mediacard = json['mediacard'] != null ? new Mediacard.fromJson(json['mediacard']) : null;
		original = json['original'] != null ? new Micro.fromJson(json['original']) : null;
	}
}

class Micro {
	String url;
	String src;

	Micro({this.url, this.src});

	Micro.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		src = json['src'];
	}
}

class Small {
	String url;
	String src;
	String src2x;
	int width;
	int height;

	Small({this.url, this.src, this.src2x, this.width, this.height});

	Small.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		src = json['src'];
		src2x = json['src@2x'];
		width = json['width'];
		height = json['height'];
	}
}

class Medium {
	String url;
	String src;
	int width;
	int height;

	Medium({this.url, this.src, this.width, this.height});

	Medium.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		src = json['src'];
		width = json['width'];
		height = json['height'];
	}
}

class Mediacard {
	String url;
	String src;
	String src2x;

	Mediacard({this.url, this.src, this.src2x});

	Mediacard.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		src = json['src'];
		src2x = json['src@2x'];
	}
}

class Links {
	String rel;
	String uri;

	Links({this.rel, this.uri});

	Links.fromJson(Map<String, dynamic> json) {
		rel = json['rel'];
		uri = json['uri'];
	}
}

class Products {
	String productid;
	String objecttype;
	String objectid;
	String producthref;
	String price;
	String currency;
	String currencystring;
	String currencysymbol;
	String condition;
	String prettycondition;
	String conditioncode;
	String productstate;
	String flagimgurl;
	String listdate;
	String inventorytype;
	String quantity;
	List<Null> shipmethods;
	Version version;
	Linkeditem objectlink;
	List<ActualImages> images;
	//Linkeduser linkeduser;
	//LinkeduserGeekMarket linkeduserGeekMarket;

	Products({this.productid, this.objecttype, this.objectid, this.producthref, this.price, this.currency, this.currencystring, this.currencysymbol, this.condition, this.prettycondition, this.conditioncode, this.productstate, this.flagimgurl, this.listdate, this.inventorytype, this.quantity, this.shipmethods, this.version, this.objectlink, this.images}); //this.linkeduser}); //this.linkeduserGeekMarket});

	Products.fromJson(Map<String, dynamic> json) {
		productid = json['productid'];
		objecttype = json['objecttype'];
		objectid = json['objectid'];
		producthref = json['producthref'];
		price = json['price'];
		currency = json['currency'];
		currencystring = json['currencystring'];
		currencysymbol = json['currencysymbol'];
		condition = json['condition'];
		prettycondition = json['prettycondition'];
		conditioncode = json['conditioncode'];
		productstate = json['productstate'];
		flagimgurl = json['flagimgurl'];
		listdate = json['listdate'];
		inventorytype = json['inventorytype'];
		quantity = json['quantity'];
		//if (json['shipmethods'] != null) {
		//	shipmethods = new List<Null>();
		//	json['shipmethods'].forEach((v) { shipmethods.add(new ShipMethod.fromJson(v)); });
		//}
		version = json['version'] != null ? new Version.fromJson(json['version']) : null;
		objectlink = json['objectlink'] != null ? new Linkeditem.fromJson(json['objectlink']) : null;
		if (json['images'] != null) {
			images = new List<ActualImages>();
			json['images'].forEach((v) { images.add(new ActualImages.fromJson(v)); });
		}
		//linkeduser = json['linkeduser'] != null ? new Linkeduser.fromJson(json['linkeduser']) : null;
		//linkeduserGeekMarket = json['linkeduserGeekMarket'] != null ? new LinkeduserGeekMarket.fromJson(json['linkeduserGeekMarket']) : null;
	}
}

class Version {
	String type;
	String id;
	String name;
	String href;
	String label;
	String labelpl;
	int imageid;
	String yearpublished;
	Source associtem;

	Version({this.type, this.id, this.name, this.href, this.label, this.labelpl, this.imageid, this.yearpublished, this.associtem});

	Version.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		id = json['id'];
		name = json['name'];
		href = json['href'];
		label = json['label'];
		labelpl = json['labelpl'];
		imageid = json['imageid'];
		yearpublished = json['yearpublished'];
		associtem = json['associtem'] != null ? new Source.fromJson(json['associtem']) : null;
	}
}

class ActualImages {
	String type;
	String id;
	Dimensions dimensions;
	int imageid;
	String caption;
	String postdate;
	Null gallery;
	int uploader;
	String extension;
	bool blocksAds;
	bool hidden;
	Source source;
	String href;
	String canonicalLink;
	String browseHref;
	MOImages images;
	List<Links> links;

	ActualImages({this.type, this.id, this.dimensions, this.imageid, this.caption, this.postdate, this.gallery, this.uploader, this.extension, this.blocksAds, this.hidden, this.source, this.href, this.canonicalLink, this.browseHref, this.images, this.links});

	ActualImages.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		id = json['id'];
		dimensions = json['dimensions'] != null ? new Dimensions.fromJson(json['dimensions']) : null;
		imageid = json['imageid'];
		caption = json['caption'];
		postdate = json['postdate'];
		gallery = json['gallery'];
		uploader = json['uploader'];
		extension = json['extension'];
		blocksAds = json['blocks_ads'];
		hidden = json['hidden'];
		source = json['source'] != null ? new Source.fromJson(json['source']) : null;
		href = json['href'];
		canonicalLink = json['canonical_link'];
		browseHref = json['browse_href'];
		images = json['images'] != null ? new MOImages.fromJson(json['images']) : null;
		if (json['links'] != null) {
			links = new List<Links>();
			json['links'].forEach((v) { links.add(new Links.fromJson(v)); });
		}
	}
}

//class Linkeduser {
//	String type;
//	String id;
//	int userid;
//	String username;
//	String href;
//	String firstname;
//	String lastname;
//	String city;
//	String state;
//	String country;
//	String isocountry;
//	String regdate;
//	int designerid;
//	int publisherid;
//	bool hideSupporter;
//	List<Null> adminBadges;
//	List<UserMicrobadges> userMicrobadges;
//	List<String> supportYears;
//	bool hideName;
//	List<Links> links;
//	Micro flag;
//	Avatar avatar;
//	BadgeUrls badgeUrls;
//
//	Linkeduser({this.type, this.id, this.userid, this.username, this.href, this.firstname, this.lastname, this.city, this.state, this.country, this.isocountry, this.regdate, this.designerid, this.publisherid, this.hideSupporter, this.adminBadges, this.userMicrobadges, this.supportYears, this.hideName, this.links, this.flag, this.avatar, this.badgeUrls});
//
//	Linkeduser.fromJson(Map<String, dynamic> json) {
//		type = json['type'];
//		id = json['id'];
//		userid = json['userid'];
//		username = json['username'];
//		href = json['href'];
//		firstname = json['firstname'];
//		lastname = json['lastname'];
//		city = json['city'];
//		state = json['state'];
//		country = json['country'];
//		isocountry = json['isocountry'];
//		regdate = json['regdate'];
//		designerid = json['designerid'];
//		publisherid = json['publisherid'];
//		hideSupporter = json['hideSupporter'];
//		//if (json['adminBadges'] != null) {
//		//	adminBadges = new List<Null>();
//		//	json['adminBadges'].forEach((v) { adminBadges.add(new AdminBadge.fromJson(v)); });
//		//}
//		if (json['userMicrobadges'] != null) {
//			userMicrobadges = new List<UserMicrobadges>();
//			json['userMicrobadges'].forEach((v) { userMicrobadges.add(new UserMicrobadges.fromJson(v)); });
//		}
//		supportYears = json['supportYears'].cast<String>();
//		hideName = json['hideName'];
//		if (json['links'] != null) {
//			links = new List<Links>();
//			json['links'].forEach((v) { links.add(new Links.fromJson(v)); });
//		}
//		flag = json['flag'] != null ? new Micro.fromJson(json['flag']) : null;
//		avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
//		badgeUrls = json['badgeUrls'] != null ? new BadgeUrls.fromJson(json['badgeUrls']) : null;
//	}
//}
//
//class UserMicrobadges {
//	int slot;
//	int badgeid;
//	String userRedirect;
//
//	UserMicrobadges({this.slot, this.badgeid, this.userRedirect});
//
//	UserMicrobadges.fromJson(Map<String, dynamic> json) {
//		slot = json['slot'];
//		badgeid = json['badgeid'];
//		userRedirect = json['userRedirect'];
//	}
//
//	Map<String, dynamic> toJson() {
//		final Map<String, dynamic> data = new Map<String, dynamic>();
//		data['slot'] = this.slot;
//		data['badgeid'] = this.badgeid;
//		data['userRedirect'] = this.userRedirect;
//		return data;
//	}
//}

//class Avatar {
//	Urls urls;
//	int height;
//	int width;
//
//	Avatar({this.urls, this.height, this.width});
//
//	Avatar.fromJson(Map<String, dynamic> json) {
//		urls = json['urls'] != null ? new Urls.fromJson(json['urls']) : null;
//		height = json['height'];
//		width = json['width'];
//	}
//}

//class Urls {
//	String md;
//	String sm;
//	String defaultUrl;
//
//	Urls({this.md, this.sm, this.defaultUrl});
//
//	Urls.fromJson(Map<String, dynamic> json) {
//		md = json['md'];
//		sm = json['sm'];
//		defaultUrl = json['default'];
//	}
//}

//class BadgeUrls {
//	String defaultBadge;
//
//	BadgeUrls({this.defaultBadge});
//
//	BadgeUrls.fromJson(Map<String, dynamic> json) {
//		defaultBadge = json['default'];
//	}
//}

//class LinkeduserGeekMarket {
//	String feedbackrating;
//	bool vacation;
//	bool adminsuspend;
//	String itemsig;
//
//	LinkeduserGeekMarket({this.feedbackrating, this.vacation, this.adminsuspend, this.itemsig});
//
//	LinkeduserGeekMarket.fromJson(Map<String, dynamic> json) {
//		feedbackrating = json['feedbackrating'];
//		vacation = json['vacation'];
//		adminsuspend = json['adminsuspend'];
//		itemsig = json['itemsig'];
//	}
//}

class Config {
	int numitems;
	int itemsperpage;
	Null nShiparea;
	Null nShipareas;

	Config({this.numitems, this.itemsperpage, this.nShiparea, this.nShipareas});

	Config.fromJson(Map<String, dynamic> json) {
		numitems = json['numitems'];
		itemsperpage = json['itemsperpage'];
		nShiparea = json['_shiparea'];
		nShipareas = json['_shipareas'];
	}
}

//class Images {
//	Micro micro;
//	Mediacard small;
//	Micro medium;
//	Micro large;
//	Small square;
//	Micro itempage;
//	Micro imagepage;
//	Micro imagepagezoom;
//	Micro expanded;
//	Micro crop100;
//	Micro square200;
//	Mediacard mediacard;
//	Medium original;
//
//	Images({this.micro, this.small, this.medium, this.large, this.square, this.itempage, this.imagepage, this.imagepagezoom, this.expanded, this.crop100, this.square200, this.mediacard, this.original});
//
//	Images.fromJson(Map<String, dynamic> json) {
//		micro = json['micro'] != null ? new Micro.fromJson(json['micro']) : null;
//		small = json['small'] != null ? new Mediacard.fromJson(json['small']) : null;
//		medium = json['medium'] != null ? new Micro.fromJson(json['medium']) : null;
//		large = json['large'] != null ? new Micro.fromJson(json['large']) : null;
//		square = json['square'] != null ? new Small.fromJson(json['square']) : null;
//		itempage = json['itempage'] != null ? new Micro.fromJson(json['itempage']) : null;
//		imagepage = json['imagepage'] != null ? new Micro.fromJson(json['imagepage']) : null;
//		imagepagezoom = json['imagepagezoom'] != null ? new Micro.fromJson(json['imagepagezoom']) : null;
//		expanded = json['expanded'] != null ? new Micro.fromJson(json['expanded']) : null;
//		crop100 = json['crop100'] != null ? new Micro.fromJson(json['crop100']) : null;
//		square200 = json['square200'] != null ? new Micro.fromJson(json['square200']) : null;
//		mediacard = json['mediacard'] != null ? new Mediacard.fromJson(json['mediacard']) : null;
//		original = json['original'] != null ? new Medium.fromJson(json['original']) : null;
//	}
//}

//class Products {
//	String productid;
//	String objecttype;
//	String objectid;
//	String producthref;
//	String price;
//	String currency;
//	String currencystring;
//	String currencysymbol;
//	String condition;
//	String prettycondition;
//	String conditioncode;
//	String productstate;
//	String flagimgurl;
//	String listdate;
//	String inventorytype;
//	String quantity;
//	List<Null> shipmethods;
//	Version version;
//	Linkeditem objectlink;
//	List<Images> images;
//	//Linkeduser linkeduser;
//	//LinkeduserGeekMarket linkeduserGeekMarket;
//
//	Products({this.productid, this.objecttype, this.objectid, this.producthref, this.price, this.currency, this.currencystring, this.currencysymbol, this.condition, this.prettycondition, this.conditioncode, this.productstate, this.flagimgurl, this.listdate, this.inventorytype, this.quantity, this.shipmethods, this.version, this.objectlink, this.images}); //this.linkeduser, this.linkeduserGeekMarket});
//
//	Products.fromJson(Map<String, dynamic> json) {
//		productid = json['productid'];
//		objecttype = json['objecttype'];
//		objectid = json['objectid'];
//		producthref = json['producthref'];
//		price = json['price'];
//		currency = json['currency'];
//		currencystring = json['currencystring'];
//		currencysymbol = json['currencysymbol'];
//		condition = json['condition'];
//		prettycondition = json['prettycondition'];
//		conditioncode = json['conditioncode'];
//		productstate = json['productstate'];
//		flagimgurl = json['flagimgurl'];
//		listdate = json['listdate'];
//		inventorytype = json['inventorytype'];
//		quantity = json['quantity'];
//		//if (json['shipmethods'] != null) {
//		//	shipmethods = new List<Null>();
//		//	json['shipmethods'].forEach((v) { shipmethods.add(new Null.fromJson(v)); });
//		//}
//		version = json['version'] != null ? new Version.fromJson(json['version']) : null;
//		objectlink = json['objectlink'] != null ? new Linkeditem.fromJson(json['objectlink']) : null;
//		if (json['images'] != null) {
//			images = new List<Images>();
//			json['images'].forEach((v) { images.add(new Images.fromJson(v)); });
//		}
//		//linkeduser = json['linkeduser'] != null ? new Linkeduser.fromJson(json['linkeduser']) : null;
//		//linkeduserGeekMarket = json['linkeduserGeekMarket'] != null ? new LinkeduserGeekMarket.fromJson(json['linkeduserGeekMarket']) : null;
//	}
//}

//class Version {
//	String type;
//	String id;
//	String name;
//	String href;
//	String label;
//	String labelpl;
//	int imageid;
//	String yearpublished;
//	Source associtem;
//
//	Version({this.type, this.id, this.name, this.href, this.label, this.labelpl, this.imageid, this.yearpublished, this.associtem});
//
//	Version.fromJson(Map<String, dynamic> json) {
//		type = json['type'];
//		id = json['id'];
//		name = json['name'];
//		href = json['href'];
//		label = json['label'];
//		labelpl = json['labelpl'];
//		imageid = json['imageid'];
//		yearpublished = json['yearpublished'];
//		associtem = json['associtem'] != null ? new Source.fromJson(json['associtem']) : null;
//	}
//}
//
//class Linkeduser {
//	String type;
//	String id;
//	int userid;
//	String username;
//	String href;
//	String firstname;
//	String lastname;
//	String city;
//	String state;
//	String country;
//	String isocountry;
//	String regdate;
//	int designerid;
//	int publisherid;
//	bool hideSupporter;
//	List<Null> adminBadges;
//	List<UserMicrobadges> userMicrobadges;
//	List<String> supportYears;
//	bool hideName;
//	List<Links> links;
//	Micro flag;
//	Avatar avatar;
//	BadgeUrls badgeUrls;
//
//	Linkeduser({this.type, this.id, this.userid, this.username, this.href, this.firstname, this.lastname, this.city, this.state, this.country, this.isocountry, this.regdate, this.designerid, this.publisherid, this.hideSupporter, this.adminBadges, this.userMicrobadges, this.supportYears, this.hideName, this.links, this.flag, this.avatar, this.badgeUrls});
//
//	Linkeduser.fromJson(Map<String, dynamic> json) {
//		type = json['type'];
//		id = json['id'];
//		userid = json['userid'];
//		username = json['username'];
//		href = json['href'];
//		firstname = json['firstname'];
//		lastname = json['lastname'];
//		city = json['city'];
//		state = json['state'];
//		country = json['country'];
//		isocountry = json['isocountry'];
//		regdate = json['regdate'];
//		designerid = json['designerid'];
//		publisherid = json['publisherid'];
//		hideSupporter = json['hideSupporter'];
//		if (json['adminBadges'] != null) {
//			adminBadges = new List<Null>();
//			json['adminBadges'].forEach((v) { adminBadges.add(new Null.fromJson(v)); });
//		}
//		if (json['userMicrobadges'] != null) {
//			userMicrobadges = new List<UserMicrobadges>();
//			json['userMicrobadges'].forEach((v) { userMicrobadges.add(new UserMicrobadges.fromJson(v)); });
//		}
//		supportYears = json['supportYears'].cast<String>();
//		hideName = json['hideName'];
//		if (json['links'] != null) {
//			links = new List<Links>();
//			json['links'].forEach((v) { links.add(new Links.fromJson(v)); });
//		}
//		flag = json['flag'] != null ? new Micro.fromJson(json['flag']) : null;
//		avatar = json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
//		badgeUrls = json['badgeUrls'] != null ? new BadgeUrls.fromJson(json['badgeUrls']) : null;
//	}
//}