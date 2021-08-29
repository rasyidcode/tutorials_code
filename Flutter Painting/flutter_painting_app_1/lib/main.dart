import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:statsfl/statsfl.dart';

void main() {
  runApp(StatsFl(align: Alignment.bottomCenter, child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Painting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CanvasPainting(),
    );
  }
}

class CanvasPainting extends StatefulWidget {
  CanvasPainting({Key? key}) : super(key: key);

  @override
  _CanvasPaintingState createState() => _CanvasPaintingState();
}

class _CanvasPaintingState extends State<CanvasPainting> {
  List<TouchPoints?> points = [];

  double opacity = 1.0;
  StrokeCap strokeType = StrokeCap.round;
  double strokeWidth = 3.0;
  Color selectedColor = Colors.black;

  List<int> touchLengths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GestureDetector(
            onPanStart: (details) {
              setState(() {
                RenderBox? renderBox = context.findRenderObject() as RenderBox;
                points.add(TouchPoints(
                    paint: Paint()
                      ..strokeCap = strokeType
                      ..isAntiAlias = true
                      ..color = selectedColor.withOpacity(opacity)
                      ..strokeWidth = strokeWidth,
                    points: renderBox.globalToLocal(details.globalPosition)));
              });
            },
            onPanUpdate: (details) {
              setState(() {
                RenderBox? renderBox = context.findRenderObject() as RenderBox;
                points.add(TouchPoints(
                    paint: Paint()
                      ..strokeCap = strokeType
                      ..isAntiAlias = true
                      ..color = selectedColor.withOpacity(opacity)
                      ..strokeWidth = strokeWidth,
                    points: renderBox.globalToLocal(details.globalPosition)));
              });
            },
            onPanEnd: (details) {
              touchLengths.add(points.length);
              setState(() {
                points.add(null);
              });
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: MyPainter(
                pointsList: points,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Change stroke width
          FloatingActionButton(
            onPressed: () async {
              var sStroke = await showDialog<double>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select stroke width'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                              onPressed: () {
                                Navigator.pop(context, 1.0);
                              },
                              child: Text('1x'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                              onPressed: () {
                                Navigator.pop(context, 5.0);
                              },
                              child: Text('5x'),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                              ),
                              onPressed: () {
                                Navigator.pop(context, 10.0);
                              },
                              child: Text('10x'),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );

              if (sStroke != null) {
                setState(() {
                  strokeWidth = sStroke;
                });
              }
            },
            child: Icon(Icons.edit),
          ),
          SizedBox(height: 8.0),
          // Change paint color
          FloatingActionButton(
            backgroundColor: selectedColor,
            onPressed: () async {
              var sColor = await showDialog<Color>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text('Select color'),
                      content: _buildColorDialogContent(context));
                },
              );

              if (sColor != null) {
                setState(() {
                  selectedColor = sColor;
                });
              }
            },
            child: Icon(Icons.color_lens),
          ),
          SizedBox(height: 8.0),
          FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {
              // TODO: implement remove previous line
            },
            child: Icon(Icons.remove_rounded),
          ),
          SizedBox(height: 8.0),
          // Reset all drawing
          FloatingActionButton(
            onPressed: () {
              setState(() {
                selectedColor = Colors.black;
                points.clear();
              });
            },
            child: Icon(Icons.delete),
          )
        ],
      ),
    );
  }

  Widget _buildColorDialogContent(BuildContext dialogContext) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectableColor(dialogContext: dialogContext, color: Colors.red),
              SelectableColor(
                  dialogContext: dialogContext, color: Colors.yellow),
              SelectableColor(dialogContext: dialogContext, color: Colors.blue),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectableColor(
                  dialogContext: dialogContext, color: Colors.brown),
              SelectableColor(
                  dialogContext: dialogContext, color: Colors.orange),
              SelectableColor(dialogContext: dialogContext, color: Colors.grey),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SelectableColor(
                  dialogContext: dialogContext, color: Colors.green),
              SelectableColor(
                  dialogContext: dialogContext, color: Colors.purple),
              SelectableColor(dialogContext: dialogContext, color: Colors.pink),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context, Colors.black);
            },
            child: Container(),
          ),
        ],
      );
}

class SelectableColor extends StatelessWidget {
  const SelectableColor({
    Key? key,
    required this.dialogContext,
    required this.color,
  }) : super(key: key);

  final BuildContext dialogContext;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        primary: color,
      ),
      onPressed: () {
        Navigator.pop(dialogContext, color);
      },
      child: Container(),
    );
  }
}

class TouchPoints {
  final Paint paint;
  final Offset points;
  TouchPoints({required this.paint, required this.points});
}

class MyPainter extends CustomPainter {
  MyPainter({required this.pointsList});
  List<TouchPoints?> pointsList;
  List<Offset> _offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        canvas.drawLine(pointsList[i]!.points, pointsList[i + 1]!.points,
            pointsList[i]!.paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        _offsetPoints.clear();
        _offsetPoints.add(pointsList[i]!.points);
        _offsetPoints.add(Offset(
            pointsList[i]!.points.dx + 0.1, pointsList[i]!.points.dy + 0.1));

        canvas.drawPoints(
            PointMode.points, _offsetPoints, pointsList[i]!.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
