import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    return Container( 
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(Icons.refresh),
          Icon(Icons.person_outline),
          Icon(Icons.info_outline)
        ],
      ),
    );
  }
}