import 'package:flutter/material.dart';

class ErrorGameBox extends StatefulWidget {
  @override
  _ErrorGameBoxState createState() => _ErrorGameBoxState();
}

class _ErrorGameBoxState extends State<ErrorGameBox> 
  with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.1),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height -200,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SlideTransition(
            position: _offsetAnimation,
            child:
              Image(
                height: 165, 
                width: 320, 
                image: AssetImage('assets/ErrorGameBox.png')
              ),
          ),
          Container(
            width: 400,
            height: 400,
            color: Color.fromRGBO(255, 255, 255, .7),
          ),
          Positioned(
            bottom:140,
            child:Text('We lost some pieces..' ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black26),),
          ),
          Positioned(
            bottom:100,
            child:Text('Please reload.' ,style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black26),),
          )
      ])
    );
  }

  @override void dispose() {
    _controller.dispose();
    super.dispose();
  }
}