import 'package:flutter/material.dart';

class CanvasPathState extends ChangeNotifier {
  List<List<Offset>> _points = [];

  CanvasPathState();

  List<List<Offset>> get points => _points;

  addPath(List<Offset> path) {
    _points.add(path);

    notifyListeners();
  }
}

class CurrentPathState extends ChangeNotifier {
  List<Offset> _points = [];

  CurrentPathState();

  List<Offset> get points => _points;

  addPoint(Offset point) {
    _points.add(point);

    notifyListeners();
  }

  resetPoints() {
    _points = [];

    notifyListeners();
  }
}
