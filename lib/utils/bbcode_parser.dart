//import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:board_game_app/BoardGamePage/BoardGamePage.dart';

List<Widget> parseBBCode(String codeStr, BuildContext context){
  RegExp bracketRegEx = new RegExp(r'\[(.*?)\]');
  RegExp endBracketRegEx = new RegExp(r'\[/');
  RegExp atrRegEx = new RegExp(r'\=(.*?)\]');

  //bbcode info encoded in the text
  List<BbcodeMatch> matchesbb = [];

  //Text found outside of bracket "bbcode"
  List<List<dynamic>> strBreaks = [];

  //A list of textSpans yet to be added into a richtext widget
  List<TextSpan> currentTexts = [];

  //Have to build after parsing everything with how this is currently built.
  //Can't create the richtext widgets until we have gone through the no text elements
  //currently parsing based on the text sections and throwing in the nontext.
  //Might make more sense to go through it some other way as this is getting out of hand...
  List<TextSpanGroup> textSpanGroups = [];

  //List of completed richtext elements
  //Seperated when there is a centered text element
  List<Widget> textParsed = [];

  //How many text spans in each richtext group.
  //Using this to determine where to add nontext elements into the text elements
  //Like links to "things" or "geeklists"
  //ie [thing=10012][/thing]
  //List<int> textSpanSpacing = [];

  int index = 0;

  List<String> selfClosing = ['gameid', 'hr','imageid', 'microbadge', 'geeklist', 'thing'];

  //Creates RighText Widgets from lists of textspans
  //TextSpans can include bold, colors, etc applied from the forums but cannot include centered text
  //A list of RichText should be able to encode most the forum styles
  //Each time something needs to be centered it will need it's own Centered rich text widget
  RichText newRichText(TextSpanGroup section){
    TextAlign align = section.isCentered ? TextAlign.center : TextAlign.left;
    return RichText(
      textAlign: align,
      text: TextSpan(
        children: section.spans
        ),
    );
  }


  Iterable matches = bracketRegEx.allMatches(codeStr);
  

  if(matches.length == 0 ) { return 
  [Row( children: [Expanded( child: 
  Text(
        codeStr,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 12,
            color: Color.fromRGBO(42, 72, 120, 1),
            fontWeight: FontWeight.w300,
            letterSpacing: 1, 
        )
    )
    )])];
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

  //if there is a string before a bracket add to strbreaks
  if(matchesbb[0].start != 0){
    strBreaks.add([0,matchesbb[0].start]);
  }
  matchesbb.asMap().forEach((i,_) {
    //if there is a string break after the strbreaks
    if(i == matchesbb.length-1){
      if(_.end != codeStr.length) strBreaks.add([_.end,codeStr.length]);
    }
    else {
      if(_.end != matchesbb[i+1].start) 
      strBreaks.add([_.end,matchesbb[i+1].start]);
    }
  });

  //decorate each of the text based on what tags enclose them
  strBreaks.asMap().forEach((i,textContent) {
    BbcodeTextSpan newSpan = new BbcodeTextSpan();

    newSpan.text = codeStr.substring(textContent[0], textContent[1]);
    matchesbb.where((bbcode) => bbcode.isEndTag && bbcode.openTagStart < textContent[0] && bbcode.end > textContent[1]).forEach((appliedBbcode) { 
    //bbcode.start < textContent[0] && bbcode.start > strBreaks[i-1][0] && !bbcode.isEndTag)
    if(appliedBbcode.content == "q"){
      print('Found quote');
    }
        switch(appliedBbcode.content.toLowerCase()){
          case 'b':
            return newSpan.weight = FontWeight.bold;
          case 'i':
            return newSpan.style = FontStyle.italic; //newSpan.decoration = TextDecoration.underline;
          case 'center':
            return newSpan.align = TextAlign.center;
          //case 'thing':
          //  newSpan.text = 'This should be a thing';
          //  newSpan.onTap = Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(matchesbb[appliedBbcode.openTagIndex].atr, null, true)));
          case 'size':
            double size = double.parse(matchesbb[appliedBbcode.openTagIndex].atr);
            return newSpan.size = size;
          case 'color':
            if(matchesbb[appliedBbcode.openTagIndex].atr.substring(0,1) == '#') {
              return newSpan.color = Color(int.parse(matchesbb[appliedBbcode.openTagIndex].atr.replaceAll('#', '0xff')));
            }
            else {
              return newSpan.color = newSpan.color;
            }
            break;
          case 'bgcolor':
            return newSpan.bgpaint = Paint()..color = Color(int.parse(matchesbb[appliedBbcode.openTagIndex].atr.replaceAll('#', '0xff')));
          case 'q':
            //Paint paint = Paint()
            //  ..color = Colors.blue
            //  ..style = PaintingStyle.stroke
            //  ..strokeWidth = 2.0
            //  ..strokeJoin = StrokeJoin.bevel
            //  ..blendMode = BlendMode.difference;
            return newSpan.text = '---' + newSpan.text.replaceAll('\n', '') +'\n';
            //return newSpan.bgpaint = paint;
        }
    });
    if(newSpan.align == TextAlign.center){
      //If it needs centered finish and add the previous spans to a richText element. Add the current span as a centered richText element
      textSpanGroups.add(new TextSpanGroup(currentTexts, false));
      textSpanGroups.add(new TextSpanGroup([newSpan.getTextSpan()], true));
      currentTexts = [];
    }
    else {
      currentTexts.add(newSpan.getTextSpan());
    }
    if(i == strBreaks.length-1){
      textSpanGroups.add(new TextSpanGroup(currentTexts, false));
    }
  });

  matchesbb.forEach((textModifier) {
    if( selfClosing.contains(textModifier.content.toLowerCase()) && !textModifier.isEndTag){
      TextSpan specialTextSpan = createSpecialWidget(textModifier, context);
      int textSpanInsertIndex = strBreaks.indexOf(strBreaks.firstWhere((element) => element[0]>=textModifier.start, orElse: () => null));
      textSpanInsertIndex = textSpanInsertIndex != -1 ? textSpanInsertIndex : strBreaks.length;
      int currentIndex = 0;
      textSpanGroups.asMap().forEach((i,element) {
        if(currentIndex < textSpanInsertIndex && textSpanGroups[i].spans.length + currentIndex >= textSpanInsertIndex){
          textSpanGroups[i].spans.insert(textSpanInsertIndex-currentIndex+textSpanGroups[i].insertedSpecialWidgets, specialTextSpan);
          textSpanGroups[i].insertedSpecialWidgets ++;
        }
        currentIndex += textSpanGroups[i].spans.length;
       });
      //textParsed.add(specialWidget); //insert(insertIndex, specialWidget);
    }
  });

  textSpanGroups.forEach((spanGroup) {textParsed.add(Row(children:[Expanded(child:newRichText(spanGroup))]));});

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
  //Color bgcolor = Colors.white;
  FontStyle style = FontStyle.normal;
  Paint bgpaint = Paint()..color = Colors.white;

  TextSpan getTextSpan(){
    return //Row( children: [Expanded( child: 
    TextSpan(
        text: text,
        //textAlign: align,
        style: TextStyle(
            fontSize: size,
            color: color,
            fontWeight: weight,
            letterSpacing: 1, 
            decoration: decoration,
            //backgroundColor: bgcolor,
            background: bgpaint,
            fontStyle: style
        )
    );//)]);
  }
}

class TextSpanGroup {
  List<TextSpan> spans;
  bool isCentered = false;
  int insertedSpecialWidgets = 0;

  TextSpanGroup(this.spans, this.isCentered);
}

TextSpan createSpecialWidget(BbcodeMatch specialModifier, BuildContext context){
  switch (specialModifier.content) {
    case 'geeklist':
      return TextSpan(text: 'Geek List ${specialModifier.atr}', style: TextStyle(color: Colors.black, fontSize: 12));
    case 'thing':
      return TextSpan(text: 'Tap to View Game', recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(specialModifier.atr, null, true))), style: TextStyle(color: Colors.black, fontSize: 12));
    case 'gameid':
      return TextSpan(text: 'Tap to View Game', recognizer: new TapGestureRecognizer()..onTap = () => Navigator.push(context, MaterialPageRoute(builder: (context) => BoardGamePage(specialModifier.atr, null, true))), style: TextStyle(color: Colors.black, fontSize: 12));
    default:
      return TextSpan(text: 'App unable to display',style: TextStyle(color: Color.fromRGBO(42, 72, 120, 1), fontSize: 12));
  }
}