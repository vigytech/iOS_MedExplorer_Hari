import 'dart:ui' show Offset;
import '../../../features/device_catalog/domain/device_blueprint.dart';

/// Abstraction over coordinate snapping.
/// Phase 1: MockSnapEngine (grid heuristic).
/// Phase 2: CppSnapEngine (OpenCV FFI).
abstract class ISnapEngine {
  /// Takes normalized drop coordinates and returns snapped normalized coordinates.
  Future<Offset> calculateSnapPosition(
      Offset sceneDropPos, DeviceBlueprint device);
}
