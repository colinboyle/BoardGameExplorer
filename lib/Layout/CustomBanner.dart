import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return CustomPaint(
      //painter: LinePainter(),
      child: Container( 
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: 74,
        //color: Colors.red[800],
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline:  TextBaseline.alphabetic,
              children: <Widget>[
                Text('GAME GEEK', style: Theme.of(context).textTheme.headline6),
                Expanded(child: Container()),
                Icon(Icons.search),
              ],
            ),
          ],
        )
      )
    );
  }
}