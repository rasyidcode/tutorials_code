import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painting_app_2/current_path_paint.dart';
import 'package:flutter_painting_app_2/current_path_paint2.dart';
import 'package:flutter_painting_app_2/points_state.dart';
import 'package:provider/provider.dart';

class DrawCanvas extends StatelessWidget {
  const DrawCanvas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CanvasPathState>(
      builder: (_, model, child) {
        return Stack(
          children: [
            RepaintBoundary(
              child: CustomPaint(
                isComplex: true,
                painter: DrawCanvasPainter(model.points),
                child: Container(),
              ),
            ),
            child!
          ],
        );
      },
      child: ChangeNotifierProvider(
        create: (_) => CurrentPathState(),
        child: const CurrentPathPaint(),
      ),
    );
  }
}

class DrawCanvasPainter extends CustomPainter {
  DrawCanvasPainter(this.points);
  List<List<Offset>> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 8.0
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (final pointsSet in points) {
      canvas.drawPoints(PointMode.polygon, pointsSet, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
