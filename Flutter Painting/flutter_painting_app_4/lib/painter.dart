import 'package:flutter/material.dart';

class Painter extends CustomPainter {
  Painter({
    required this.points,
    required this.color,
    required this.strokeCap,
    required this.strokeWidth,
    this.painters = const [],
  });

  final List<Offset?> points;
  final Color color;
  final StrokeCap strokeCap;
  final double strokeWidth;
  final List<Painter> painters;

  @override
  void paint(Canvas canvas, Size size) {
    for (Painter painter in painters) {
      painter.paint(canvas, size);
    }

    final paint = Paint()
      ..color = color
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(Painter oldPainter) => oldPainter.points != points;
}
