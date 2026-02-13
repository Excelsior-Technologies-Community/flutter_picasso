import 'package:flutter/material.dart';
import '../controller/picasso_controller.dart';
import '../painter/picasso_painter.dart';

class PicassoCanvas extends StatefulWidget {

  final PicassoController controller;
  final Color? backgroundColor;

  const PicassoCanvas({
    super.key,
    required this.controller,
    this.backgroundColor,
  });

  @override
  State<PicassoCanvas> createState() => _PicassoCanvasState();
}

class _PicassoCanvasState extends State<PicassoCanvas> {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {

        return AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {

            return GestureDetector(
              behavior: HitTestBehavior.translucent,

              onPanStart: (details) {
                widget.controller.startStroke(details.localPosition);
              },

              onPanUpdate: (details) {
                widget.controller.appendPoint(details.localPosition);
              },

              onPanEnd: (_) {
                widget.controller.endStroke();
              },

              child: Stack(
                children: [

                  /// Optional background
                  if (widget.backgroundColor != null)
                    Container(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                      color: widget.backgroundColor,
                    ),

                  /// Drawing layer
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    child: CustomPaint(
                      painter: PicassoPainter(
                        strokes: widget.controller.strokes,
                        currentPoints: widget.controller.currentPoints,
                        isEraser: widget.controller.isEraser,
                        currentColor: widget.controller.color,
                        currentWidth: widget.controller.strokeWidth,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
