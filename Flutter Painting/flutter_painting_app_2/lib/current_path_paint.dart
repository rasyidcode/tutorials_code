import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painting_app_2/points_state.dart';
import 'package:provider/provider.dart';

class OnlyOnePointerRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;

  // @override
  // void addPointer(PointerDownEvent event) {
  //   startTrackingPointer(event.pointer);
  //   // print(event.pointer);
  //   print('_p : $_p');
  //   if (_p == 0) {
  //     resolve(GestureDisposition.rejected);
  //     _p = event.pointer;
  //   } else {
  //     resolve(GestureDisposition.accepted);
  //   }
  // }

  @override
  void addAllowedPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      print('rejected');
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      print('allowed');
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  String get debugDescription => 'only one pointer recognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {
    print('did stop');
  }

  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      print('reset');
      _p = 0;
    }
  }
}

class CurrentPathPaint extends StatelessWidget {
  const CurrentPathPaint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CurrentPathState currentPathState =
        Provider.of<CurrentPathState>(context, listen: false);
    CanvasPathState canvasPathState =
        Provider.of<CanvasPathState>(context, listen: false);

    return Consumer<CurrentPathState>(
      builder: (_, model, child) => Stack(
        fit: StackFit.expand,
        children: [
          RepaintBoundary(
            child: CustomPaint(
              isComplex: true,
              painter: CurrentPathPainter(model.points),
              child: Container(),
            ),
          ),
          child!
        ],
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: (details) {
          currentPathState.addPoint(details.localPosition);
          currentPathState.addPoint(details.localPosition);
        },
        onPanUpdate: (details) {
          currentPathState.addPoint(details.localPosition);
        },
        onPanEnd: (details) {
          canvasPathState.addPath(currentPathState.points);
          currentPathState.resetPoints();
        },
      ),
    );
  }
}

class SingleTouchRecognizerWidget extends StatelessWidget {
  const SingleTouchRecognizerWidget({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        OnlyOnePointerRecognizer:
            GestureRecognizerFactoryWithHandlers<OnlyOnePointerRecognizer>(
          () => OnlyOnePointerRecognizer(),
          (OnlyOnePointerRecognizer instance) {},
        ),
      },
      child: child,
    );
  }
}

class CurrentPathPainter extends CustomPainter {
  CurrentPathPainter(this.points);
  List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
