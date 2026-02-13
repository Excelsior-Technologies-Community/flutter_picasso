import 'package:flutter/material.dart';
import 'draw_point.dart';

class Stroke {
  final List<DrawPoint> points;
  final Color color;
  final double width;
  final bool isEraser;

  Stroke({
    required this.points,
    required this.color,
    required this.width,
    this.isEraser = false,
  });
}
