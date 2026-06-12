import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../shared/domain/interfaces/i_device_repository.dart';
import '../../shared/domain/interfaces/i_snap_engine.dart';
import '../../features/device_catalog/data/mock_device_repository.dart';
import '../mock_services/mock_snap_engine.dart';
import '../../features/device_catalog/domain/device_blueprint.dart';

/// Injects the Phase 1 mock implementations.
/// To swap for Phase 2 production, change only these two providers.
final deviceRepositoryProvider = Provider<IDeviceRepository>((ref) {
  return MockDeviceRepository();
});

final snapEngineProvider = Provider<ISnapEngine>((ref) {
  return MockSnapEngine();
});

/// Async catalog provider — all catalog consumers watch this.
final deviceCatalogProvider = FutureProvider<List<DeviceBlueprint>>((ref) async {
  final repository = ref.watch(deviceRepositoryProvider);
  return repository.fetchCatalog();
});
