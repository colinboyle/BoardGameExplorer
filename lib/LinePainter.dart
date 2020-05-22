import 'package:flutter/material.dart';

class LinePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

      Path path = Path();
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);

      canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}