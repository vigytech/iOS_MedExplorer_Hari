import '../../../features/device_catalog/domain/device_blueprint.dart';

/// Abstraction over device catalog data source.
/// Phase 1: MockDeviceRepository (in-memory JSON parsing).
/// Phase 2: SqliteDeviceRepository (encrypted local DB).
abstract class IDeviceRepository {
  Future<List<DeviceBlueprint>> fetchCatalog();
}
