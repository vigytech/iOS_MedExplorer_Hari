import 'dart:ui' show Color, Offset;

/// A single freehand annotation stroke drawn on the canvas overlay.
/// Points are stored as normalized (0.0–1.0) coordinates.
class StrokeEntity {
  final String id;
  final List<Offset> normalizedPoints;
  final Color color;
  final double strokeWidth;

  const StrokeEntity({
    required this.id,
    required this.normalizedPoints,
    required this.color,
    required this.strokeWidth,
  });

  StrokeEntity copyWithAddedPoint(Offset point) {
    return StrokeEntity(
      id: id,
      normalizedPoints: [...normalizedPoints, point],
      color: color,
      strokeWidth: strokeWidth,
    );
  }
}
