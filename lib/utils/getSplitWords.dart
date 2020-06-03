class GetSplitWords {
  String firstChar;
  String firstWords;
  String lastWords;


  void splitWords(String name){
    firstChar = name.substring(0,1);
    if(name.split(' ').length >= 4){
      var length = name.split(' ').length;
      firstWords = name.split(' ').take(length -2).join(' ');
      lastWords = name.split(' ').skip(length - 2).join(' '); //.toUpperCase();
    }
    else if (name.split(' ').length > 1){
      firstWords = name.substring(0,name.lastIndexOf(' '));
      lastWords = name.split(' ').last.toUpperCase();
    }
    else {
      lastWords = name.toUpperCase();
      firstWords = null;
    }
  }
}