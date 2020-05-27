import 'package:flutter/material.dart';

class GetHashColors {
  String hashString;
  Color mainColor;
  Color darkColorOne;
  Color darkColorTwo;
  Color lightColorOne;
  Color lightColorTwo;
  List<Color> colorList = [
    
    Colors.blue, 
    Colors.red, 
    Colors.green, 
    Colors.purple, 
    Colors.teal, 
    Colors.orange, 
    Colors.yellow, 
    Colors.deepOrange,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.blueGrey,
    
    Colors.blue[300], 
    Colors.red[300], 
    Colors.green[300], 
    Colors.purple[300], 
    Colors.teal[300], 
    Colors.orange[300], 
    Colors.yellow[300], 
    Colors.deepOrange[300],
    Colors.indigo[300],
    Colors.lime[300],
    Colors.amber[300],
    Colors.blueGrey[300],
    
    ];



  List<Color> getHashColors (String hashString){
    //Don't need to worry about collision density or anything only a few color choices.
    mainColor = colorList[hashString.codeUnits.reduce((a,b) => a+b) % 24];
    darkColorOne = darken(mainColor);
    darkColorTwo = darken(darkColorOne);
    lightColorOne = brighten(mainColor);
    lightColorTwo = brighten(lightColorOne);
    return [mainColor, darkColorOne, darkColorTwo, lightColorOne, lightColorTwo];
  } 

  Color darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(
        c.alpha,
        (c.red * f).round(),
        (c.green  * f).round(),
        (c.blue * f).round()
    );
  }

  Color brighten(Color c, [int percent = 10]) {
      assert(1 <= percent && percent <= 100);
      var p = percent / 100;
      return Color.fromARGB(
          c.alpha,
          c.red + ((255 - c.red) * p).round(),
          c.green + ((255 - c.green) * p).round(),
          c.blue + ((255 - c.blue) * p).round()
      );
  }
}