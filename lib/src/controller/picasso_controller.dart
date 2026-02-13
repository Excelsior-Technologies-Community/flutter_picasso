import 'dart:ui';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../models/stroke.dart';
import '../models/draw_point.dart';
import '../utils/image_exporter.dart';

class PicassoController extends ChangeNotifier {

  List<Stroke> _strokes = [];
  List<Stroke> _redoStack = [];

  Color _color = Colors.black;
  double _strokeWidth = 4.0;

  List<Stroke> get strokes => _strokes;
  Color get color => _color;
  double get strokeWidth => _strokeWidth;

  List<DrawPoint> _currentPoints = [];

  bool _eraserMode = false;

  bool get isEraser => _eraserMode;

  void enableEraser() {
    _eraserMode = true;
    notifyListeners();
  }

  void disableEraser() {
    _eraserMode = false;
    notifyListeners();
  }


  void startStroke(Offset point) {
    _currentPoints = [DrawPoint(point)];
  }

  void appendPoint(Offset point) {
    _currentPoints.add(DrawPoint(point));
    notifyListeners();
  }

  void endStroke() {
    if (_currentPoints.isEmpty) return;

    _strokes.add(
      Stroke(
        points: List.from(_currentPoints),
        color: _color,
        width: _strokeWidth,
        isEraser: _eraserMode,
      ),
    );


    _currentPoints.clear();
    _redoStack.clear();
    notifyListeners();
  }

  List<DrawPoint> get currentPoints => _currentPoints;

  // Tools

  void setColor(Color color) {
    _color = color;
    notifyListeners();
  }

  void setStrokeWidth(double width) {
    _strokeWidth = width;
    notifyListeners();
  }

  // Undo

  void undo() {
    if (_strokes.isNotEmpty) {
      _redoStack.add(_strokes.removeLast());
      notifyListeners();
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      _strokes.add(_redoStack.removeLast());
      notifyListeners();
    }
  }

  void clear() {
    _strokes.clear();
    _redoStack.clear();
    notifyListeners();
  }

  // Export image

  Future<Uint8List?> exportImage(GlobalKey key) async {
    return ImageExporter.export(key);
  }
}
