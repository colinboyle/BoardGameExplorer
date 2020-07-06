import 'package:flutter/material.dart';

List<Widget> parseBBCode(String codeStr){
  RegExp bracketRegEx = new RegExp(r'\[(.*?)\]');
  RegExp endBracketRegEx = new RegExp(r'\[/');
  RegExp atrRegEx = new RegExp(r'\=(.*?)\]');

  List<BbcodeMatch> matchesbb = [];
  List<List<dynamic>> strBreaks = [];
  List<Widget> textParsed = [];
  int index = 0;

  List<String> selfClosing = ['hr','imageid', 'microbadge', 'geeklist'];


  Iterable matches = bracketRegEx.allMatches(codeStr);

  if(matches.length == 0 ) { return 
  [Row( children: [Expanded( child: Text(
        codeStr,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(42, 72, 120, 1),
            fontWeight: FontWeight.w300,
            letterSpacing: 1, 
        )
    ))])];
  }

  //Data on the bracket used to define how they change the text
  matches.forEach((match) {
    int start = match.start;
    int end = match.end;
    String fullContent = codeStr.substring(start, end);
    bool isEndTag = endBracketRegEx.hasMatch(fullContent);
    bool hasAtr = atrRegEx.hasMatch(fullContent);
    String content = isEndTag ? codeStr.substring(match.start+2, match.end-1) : hasAtr ? codeStr.substring(match.start+1, match.start+atrRegEx.firstMatch(fullContent).start) : codeStr.substring(match.start+1, match.end-1);
    String atr = hasAtr ? fullContent.substring(atrRegEx.firstMatch(fullContent).start+1,atrRegEx.firstMatch(fullContent).end-1) : '';
    int openTagStart = isEndTag ? matchesbb.reduce((c,n) => n.content == content && !n.isEndTag ? n : c).start : 0;
    int openTagIndex = isEndTag ? matchesbb.reduce((c,n) => n.content == content && !n.isEndTag ? n : c).index : 0;
    matchesbb.add(new BbcodeMatch(start, end, fullContent, isEndTag, content, hasAtr, atr, index, openTagStart, openTagIndex));
    index ++;
  });

  //list of text outside of brackets
  if(matchesbb[0].start != 0){
    strBreaks.add([0,matchesbb[0].start]);
  }
  matchesbb.asMap().forEach((i,_) {
    if(i == matchesbb.length-1){
      if(_.end != codeStr.length) strBreaks.add([_.end,codeStr.length]);
    }
    else {
      if(_.end != matchesbb[i+1].start) strBreaks.add([_.end,matchesbb[i+1].start]);
    }
  });

  //decorate each of the text based on what tags enclose them
  strBreaks.asMap().forEach((i,textContent) {
    BbcodeTextSpan newSpan = new BbcodeTextSpan();
    newSpan.text = codeStr.substring(textContent[0], textContent[1]);
    matchesbb.where((bbcode) => bbcode.isEndTag && bbcode.openTagStart < textContent[0] && bbcode.end > textContent[1]).forEach((appliedBbcode) { 
    //bbcode.start < textContent[0] && bbcode.start > strBreaks[i-1][0] && !bbcode.isEndTag)
        switch(appliedBbcode.content.toLowerCase()){
          case 'b':
            return newSpan.weight = FontWeight.bold;
          case 'i':
            return newSpan.decoration = TextDecoration.underline;
          case 'center':
            return newSpan.align = TextAlign.center;
          case 'size':
            double test = double.parse(matchesbb[appliedBbcode.openTagIndex].atr);
            return newSpan.size = test;
          case 'color':
            return newSpan.color = Color(int.parse(matchesbb[appliedBbcode.openTagIndex].atr.replaceAll('#', '0xff')));
          case 'bgcolor':
            return newSpan.bgcolor = Color(int.parse(matchesbb[appliedBbcode.openTagIndex].atr.replaceAll('#', '0xff')));
        }
    });
    textParsed.add(newSpan.getTextSpan());
  });

  matchesbb.forEach((textModifier) {
    if( selfClosing.contains(textModifier.content.toLowerCase())){
      Widget specialWidget = createSpecialWidget(textModifier);
      int insertIndex = strBreaks.indexOf(strBreaks.firstWhere((element) => element[0]>=textModifier.start, orElse: () => null));
      insertIndex = insertIndex != -1 ? insertIndex : strBreaks.length;
      textParsed.insert(insertIndex, specialWidget);
    }
  });

  return textParsed;
  //RichText(
  //  text: TextSpan(
  //    children: textParsed,
  //    style: TextStyle(
  //      color: Colors.black, 
  //      fontSize: 20
  //    )
  //  ),
  //);
}



class BbcodeMatch {
  int start;
  int end;
  String fullContent;
  bool isEndTag;
  String content;
  bool hasAtr;
  String atr;
  int index;
  int openTagStart;
  int openTagIndex;

  BbcodeMatch(this.start, this.end, this.fullContent, this.isEndTag, this.content, this.hasAtr, this.atr, this.index, this.openTagStart, this.openTagIndex);
}

class BbcodeTextSpan {
  double size = 12;
  Color color = Color.fromRGBO(42, 72, 120, 1);
  FontWeight weight = FontWeight.w300;
  TextAlign align = TextAlign.left;
  String text = '';
  TextDecoration decoration = TextDecoration.none;
  Color bgcolor = Colors.white;

  Widget getTextSpan(){
    return Row( children: [Expanded( child: Text(
        text,
        textAlign: align,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: weight,
            letterSpacing: 1, 
            decoration: decoration,
            backgroundColor: bgcolor
        )
    ))]);
  }
}

Widget createSpecialWidget(BbcodeMatch specialModifier){
  switch (specialModifier.content) {
    case 'geeklist':
      return Text('Geek List ${specialModifier.atr}');
    default:
      return Text('Not a geeklist. ${specialModifier.content}');
  }
}