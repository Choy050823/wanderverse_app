import 'package:flutter/material.dart';

class TimelinePainter extends CustomPainter {
  TimelinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          const Color(0xFFE5E7EB) // Using theme's lightGrey
      ..strokeWidth = 2.0;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
