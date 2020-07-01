//import 'package:bbob_dart/bbob_dart.dart' as bbob;
//import 'package:flutter/material.dart' as mat;
import 'package:flutter/material.dart';

List<Widget> parseBBCode(String codeStr){
  //const validTags = {'url','b'};
  //
  ////const visitor = new NodeVisitor()
  //
  //
  //var nodes = bbob.parse(
  //  codeStr,
  //  onError: (msg) {
  //    print(msg);
  //  },
  //  openTag: '[',
  //  closeTag: ']',
  //  enableEscapeTags: false,
  //  validTags: validTags,
  //);
  //nodes.forEach((element) {
  //  if (element.children.tag != 'b'){
  //    print(element.toString());
  //  }
  //});
  String codeStrOld = '[hr] [center][ImageID=2373684 medium][/center] [center][size=24][b][COLOR=#CC00CC]Welcome to Solitaire Games on Your Table July 2020[/COLOR][/b][/size]'; // = 'is [center][b]bold[/b][/center] and [url=working][/url]';

  RegExp bracketRegEx = new RegExp(r'\[(.*?)\]');
  RegExp endBracketRegEx = new RegExp(r'\[/');
  RegExp atrRegEx = new RegExp(r'\=(.*?)\]');

  List<BbcodeMatch> matchesbb = [];
  //List<String> textContents = [];
  List<List<dynamic>> strBreaks = [];
  List<Widget> textParsed = [];
  int index = 0;

  List<String> selfClosing = ['hr','imageid'];


  Iterable matches = bracketRegEx.allMatches(codeStr);

  matches.forEach((match) {
    int start = match.start;
    int end = match.end;
    String fullContent = codeStr.substring(start, end);
    bool isEndTag = endBracketRegEx.hasMatch(fullContent);
    bool hasAtr = atrRegEx.hasMatch(fullContent);
    String content = isEndTag ? codeStr.substring(match.start+2, match.end-1) : hasAtr ? codeStr.substring(match.start+1, match.start+atrRegEx.firstMatch(fullContent).start) : codeStr.substring(match.start+1, match.end-1);
    String atr = hasAtr ? fullContent.substring(atrRegEx.firstMatch(fullContent).start+1,atrRegEx.firstMatch(fullContent).end-1) : '';
    print('fullContent: $fullContent, endTag: $isEndTag, content: $content, hasAtr: $hasAtr, atr: $atr, start: $start, end: $end, index: $index');
    matchesbb.add(new BbcodeMatch(start, end, fullContent, isEndTag, content, hasAtr, atr, index));
    index ++;
  });
  //print('test: ${codeStr.substring(0,0)}');

  if(matchesbb[0].start != 0){
    strBreaks.add([0,matchesbb[0].start]);
  }
  matchesbb.asMap().forEach((i,_) {
    if(i == matchesbb.length-1){

    }
    else {
      if(_.end != matchesbb[i+1].start) strBreaks.add([_.end,matchesbb[i+1].start]);
    }
  });

  matchesbb.removeWhere((match) => selfClosing.contains(match.content.toLowerCase()));


  strBreaks.asMap().forEach((i,textContent) { 
    //String styleChanges = '';
    BbcodeTextSpan newSpan = new BbcodeTextSpan();
    newSpan.text = codeStr.substring(textContent[0], textContent[1]);
    
    matchesbb.where((bbcode) => bbcode.start < textContent[0] && bbcode.start > strBreaks[i-1][0] && !bbcode.isEndTag).forEach((appliedBbcode) { 
        switch(appliedBbcode.content.toLowerCase()){
          case 'b':
            return newSpan.weight = FontWeight.bold;
          case 'center':
            return newSpan.align = TextAlign.center;
          case 'size':
            double test = double.parse(appliedBbcode.atr);
            return newSpan.size = test;
          case 'color':
            return Color(int.parse(appliedBbcode.atr.replaceAll('#', '0xff')));
        }
    });
    textParsed.add(newSpan.getTextSpan());
  });

  //String tested = 'b center';
  //strBreaks.forEach((_) {
  //  textParsed.add(
  //    TextSpan(
  //      text: codeStr.substring(_[0], _[1]),
  //      style: TextStyle(
  //          fontSize: 12,
  //          color: _[2].contains('b ') ? Colors.red : Color.fromRGBO(42, 72, 120, 1),
  //          fontWeight: _[2].contains('b ') ? FontWeight.bold : FontWeight.w300,
  //          letterSpacing: 1
  //      )
  //  ));
  // });

  // print('tested: $tested');

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

  BbcodeMatch(this.start, this.end, this.fullContent, this.isEndTag, this.content, this.hasAtr, this.atr, this.index);
}

class BbcodeTextSpan {
  double size = 12;
  Color color = Color.fromRGBO(42, 72, 120, 1);
  FontWeight weight = FontWeight.w300;
  TextAlign align = TextAlign.start;
  String text = '';

  Text getTextSpan(){
    return Text(
        text,
        textAlign: align,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: weight,
            letterSpacing: 1,  
        )
    );
  }

  //setSize(double s){
  //  this.size = s;
  //}
  //setColor(Color c){
  //  this.color = c;
  //}
  //
  //setWeight(FontWeight w){
  //  this.color = c;
  //}
}