import 'package:flutter/material.dart';
import 'package:flutter_painting_app_4/painter.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset?> points = [];
  Color color = Colors.black;
  StrokeCap strokeCap = StrokeCap.round;
  double strokeWidth = 5.0;
  List<Painter> painters = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              RenderBox object = context.findRenderObject() as RenderBox;
              Offset localPosition =
                  object.globalToLocal(details.globalPosition);
              points = new List.from(points);
              points.add(localPosition);
            });
          },
          onPanEnd: (details) => points.add(null),
          child: CustomPaint(
            painter: Painter(
              points: points,
              color: color,
              strokeCap: strokeCap,
              strokeWidth: strokeWidth,
              painters: painters,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.clear),
                onPressed: () {
                  points.clear();

                  for (Painter painter in painters) {
                    painter.points.clear();
                  }

                  // painters.clear();
                },
              ),
            ),
          ),
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.lens),
                onPressed: () async {
                  double? temp;
                  temp = await showDialog(
                    context: context,
                    builder: (context) => WidthDialog(strokeWidth: strokeWidth),
                  );

                  if (temp != null) {
                    setState(() {
                      painters.add(
                        Painter(
                          points: points.toList(),
                          color: color,
                          strokeCap: strokeCap,
                          strokeWidth: strokeWidth,
                        ),
                      );
                      points.clear();
                      strokeWidth = temp!;
                    });
                  }
                },
              ),
            ),
          ),
          Container(
            height: 70.0,
            width: 56.0,
            alignment: FractionalOffset.topCenter,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animationController,
                curve: Interval(0.0, 1.0 - 0 / 3 / 2.0, curve: Curves.easeOut),
              ),
              child: FloatingActionButton(
                mini: true,
                child: Icon(Icons.color_lens),
                onPressed: () async {
                  Color? temp;
                  temp = await showDialog(
                    context: context,
                    builder: (context) => ColorDialog(),
                  );

                  if (temp != null) {
                    setState(() {
                      painters.add(
                        Painter(
                          points: points.toList(),
                          color: color,
                          strokeCap: strokeCap,
                          strokeWidth: strokeWidth,
                        ),
                      );
                      points.clear();
                      color = temp!;
                    });
                  }
                },
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              if (animationController.isDismissed) {
                animationController.forward();
              } else {
                animationController.reverse();
              }
            },
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.rotationZ(
                      animationController.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(Icons.brush),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class WidthDialog extends StatefulWidget {
  WidthDialog({
    Key? key,
    required this.strokeWidth,
  }) : super(key: key);
  final double strokeWidth;

  @override
  _WidthDialogState createState() => _WidthDialogState();
}

class _WidthDialogState extends State<WidthDialog> {
  late double strokeWidth;

  @override
  void initState() {
    super.initState();
    strokeWidth = widget.strokeWidth;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Brush thickness'),
      contentPadding: const EdgeInsets.all(12.0),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
          child: Container(
            width: strokeWidth,
            height: strokeWidth,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Slider(
          value: strokeWidth,
          min: 1.0,
          max: 20.0,
          onChanged: (d) {
            setState(() {
              strokeWidth = d;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: ThemeData().accentColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(strokeWidth);
              },
              child: Text(
                'Accept',
                style: TextStyle(
                  color: ThemeData().accentColor,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class ColorDialog extends StatefulWidget {
  ColorDialog({Key? key}) : super(key: key);

  @override
  _ColorDialogState createState() => _ColorDialogState();
}

class _ColorDialogState extends State<ColorDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Brush Color'),
      contentPadding: const EdgeInsets.all(12.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.pink,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.pink);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.red,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.red);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.deepOrange,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.deepOrange);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.orange,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.orange);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.amber,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.amber);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.yellow,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.yellow);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.lightGreen,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.lightGreen);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.green,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.green);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.teal,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.teal);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.cyan,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.cyan);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.lightBlue,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.lightBlue);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.blue,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.blue);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.indigo,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.indigo);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.purple,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.purple);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.deepPurple,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.deepPurple);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.blueGrey,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.blueGrey);
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.brown,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.brown);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.grey,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.grey);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.black,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.black);
              },
            ),
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              elevation: 1.0,
              onPressed: () {
                Navigator.of(context).pop(Colors.white);
              },
            ),
          ],
        ),
      ],
    );
  }
}
