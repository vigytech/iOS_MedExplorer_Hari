import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../../../shared/domain/interfaces/i_device_repository.dart';
import '../../../core/constants/app_assets.dart';
import '../domain/device_blueprint.dart';

/// Phase 1 mock: Parses static JSON from bundled assets.
/// Simulates 300ms network latency for realistic UI loading states.
class MockDeviceRepository implements IDeviceRepository {
  List<DeviceBlueprint>? _cache;

  @override
  Future<List<DeviceBlueprint>> fetchCatalog() async {
    if (_cache != null) return _cache!;

    // Simulate network latency per ui-architecture-rules.md
    await Future.delayed(const Duration(milliseconds: 300));

    final jsonString = await rootBundle.loadString(AppAssets.mockDeviceCatalog);
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    _cache = jsonList
        .map((item) => DeviceBlueprint.fromJson(item as Map<String, dynamic>))
        .toList();

    return _cache!;
  }
}
