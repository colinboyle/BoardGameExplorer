import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final double height;
  final double width;
  final double radius;

  Skeleton({Key key, this.height = 20, this.width = 200, this.radius = 0 }) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
     if (_controller.status == AnimationStatus.forward || _controller.status == AnimationStatus.reverse) { _controller.notifyStatusListeners(AnimationStatus.dismissed); }
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width:  widget.width,
        height: widget.height, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
          gradient: LinearGradient(
            begin: Alignment(gradientPosition.value, 0),
            end: Alignment(-1, 0),
            colors: [Colors.black12, Colors.black26, Colors.black12]
          )
        ),
    );
  }
}