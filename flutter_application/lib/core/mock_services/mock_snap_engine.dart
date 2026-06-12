import 'dart:ui' show Offset;
import '../../shared/domain/interfaces/i_snap_engine.dart';
import '../../features/device_catalog/domain/device_blueprint.dart';
import '../theme/app_theme.dart';

/// Phase 1 mock: snaps to nearest 0.1 grid vector.
/// Phase 2 replacement: CppVisionEngine via dart:ffi.
class MockSnapEngine implements ISnapEngine {
  @override
  Future<Offset> calculateSnapPosition(
      Offset pos, DeviceBlueprint device) async {
    const increment = AppTheme.gridSnapIncrement; // 0.1
    final snappedX = (pos.dx / increment).roundToDouble() * increment;
    final snappedY = (pos.dy / increment).roundToDouble() * increment;
    return Offset(
      snappedX.clamp(0.0, 1.0 - device.defaultWidthRatio),
      snappedY.clamp(0.0, 1.0 - device.defaultHeightRatio),
    );
  }
}
