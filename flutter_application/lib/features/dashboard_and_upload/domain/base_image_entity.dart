/// Represents a selectable background anatomical image for the canvas.
class BaseImageEntity {
  final String id;
  final String displayName;
  final String assetPath;

  const BaseImageEntity({
    required this.id,
    required this.displayName,
    required this.assetPath,
  });
}
