import 'package:flutter/material.dart';

class LoadingLogo extends StatefulWidget {
  @override
  _LoadingLogoState createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo> 
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
      end: const Offset(0.0, -0.35),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    //final double onBox = 180;
    //final double offBox = 30;
    //final Size biggest = constraints.biggest;
    //final Size biggest = Size(0.0,0.0);

    return 
    Container(
      height: MediaQuery.of(context).size.height -200,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            //top: 180, 
            child:Image(
              height: 165,
              width: 220,
              image: AssetImage('assets/BottomLogoBox.png')
            ),
          ),
          SlideTransition(
            position: _offsetAnimation,
            child:
              Image(
                height: 165, 
                width: 220, 
                image: AssetImage('assets/TopLogoBox.png')
              ),
          ),
          Container(
            width: 300,
            height: 400,
            color: Color.fromRGBO(255, 255, 255, .7),
          ),
          Positioned(
            bottom:100,
            child:Text('Loading...', style: TextStyle(fontSize: 46, fontWeight: FontWeight.w600, color: Colors.black26),),
          )
      ])
    );
  }

  @override void dispose() {
    _controller.dispose();
    super.dispose();
  }
}