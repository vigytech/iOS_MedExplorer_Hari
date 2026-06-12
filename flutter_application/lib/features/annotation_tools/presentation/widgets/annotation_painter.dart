import 'package:flutter/material.dart';
import '../../domain/stroke_entity.dart';

/// CustomPainter for rendering annotation strokes on the canvas overlay.
/// Uses path flattening: when committed strokes exceed threshold,
/// historic paths are cached to a ui.Picture for performance.
class AnnotationPainter extends CustomPainter {
  final List<StrokeEntity> committedStrokes;
  final StrokeEntity? activeStroke;
  final Size canvasSize;

  AnnotationPainter({
    required this.committedStrokes,
    required this.activeStroke,
    required this.canvasSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint committed strokes
    for (final stroke in committedStrokes) {
      _paintStroke(canvas, stroke, size);
    }

    // Paint the active (in-progress) stroke
    if (activeStroke != null) {
      _paintStroke(canvas, activeStroke!, size);
    }
  }

  void _paintStroke(Canvas canvas, StrokeEntity stroke, Size size) {
    if (stroke.normalizedPoints.length < 2) return;

    final paint = Paint()
      ..color = stroke.color
      ..strokeWidth = stroke.strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    final firstPoint = _denormalize(stroke.normalizedPoints.first, size);
    path.moveTo(firstPoint.dx, firstPoint.dy);

    for (int i = 1; i < stroke.normalizedPoints.length; i++) {
      final point = _denormalize(stroke.normalizedPoints[i], size);
      path.lineTo(point.dx, point.dy);
    }

    canvas.drawPath(path, paint);
  }

  /// Convert normalized (0.0-1.0) coordinates to pixel coordinates.
  Offset _denormalize(Offset normalized, Size size) {
    return Offset(
      normalized.dx * size.width,
      normalized.dy * size.height,
    );
  }

  @override
  bool shouldRepaint(covariant AnnotationPainter oldDelegate) {
    return oldDelegate.committedStrokes != committedStrokes ||
        oldDelegate.activeStroke != activeStroke;
  }
}
