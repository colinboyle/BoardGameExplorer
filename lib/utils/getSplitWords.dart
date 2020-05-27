class GetSplitWords {
  String firstChar;
  String firstWords;
  String lastWord;


  void splitWords(String name){
    firstChar = name.substring(0,1);
    if(name.split(' ').length > 1){
      firstWords = name.substring(0,name.lastIndexOf(' '));
      lastWord = name.split(' ').last.toUpperCase();
    }
    else {
      lastWord = name.toUpperCase();
      firstWords = null;
    }
  }
}