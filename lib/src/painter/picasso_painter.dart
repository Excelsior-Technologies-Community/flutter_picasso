import 'package:flutter/material.dart';
import '../models/stroke.dart';
import '../models/draw_point.dart';

class PicassoPainter extends CustomPainter {

  final List<Stroke> strokes;
  final List<DrawPoint> currentPoints;

  final bool isEraser;
  final Color currentColor;
  final double currentWidth;

  PicassoPainter({
    required this.strokes,
    required this.currentPoints,
    required this.isEraser,
    required this.currentColor,
    required this.currentWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {

    // IMPORTANT: required for transparent erasing
    canvas.saveLayer(null, Paint());

    /// Draw saved strokes
    for (final stroke in strokes) {
      _drawStroke(canvas, stroke);
    }

    /// Draw live stroke (this fixes colored preview bug)
    if (currentPoints.length > 1) {
      final liveStroke = Stroke(
        points: currentPoints,
        color: currentColor,
        width: currentWidth,
        isEraser: isEraser,
      );

      _drawStroke(canvas, liveStroke);
    }

    canvas.restore();
  }

  void _drawStroke(Canvas canvas, Stroke stroke) {

    if (stroke.points.length < 2) return;

    final paint = Paint()
      ..strokeWidth = stroke.width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    // ⭐ REAL ERASER
    if (stroke.isEraser) {
      paint.blendMode = BlendMode.clear;
    } else {
      paint.color = stroke.color;
    }

    final path = Path();

    path.moveTo(
      stroke.points.first.offset.dx,
      stroke.points.first.offset.dy,
    );

    for (int i = 1; i < stroke.points.length; i++) {
      final p1 = stroke.points[i - 1].offset;
      final p2 = stroke.points[i].offset;

      final mid = Offset(
        (p1.dx + p2.dx) / 2,
        (p1.dy + p2.dy) / 2,
      );

      path.quadraticBezierTo(p1.dx, p1.dy, mid.dx, mid.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PicassoPainter oldDelegate) => true;
}
