import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/state_management/app_providers.dart';
import '../../domain/device_blueprint.dart';

/// Groups the flat device catalog by category for sidebar display.
final groupedCatalogProvider =
    FutureProvider<Map<String, List<DeviceBlueprint>>>((ref) async {
  final catalog = await ref.watch(deviceCatalogProvider.future);
  final grouped = <String, List<DeviceBlueprint>>{};
  for (final device in catalog) {
    grouped.putIfAbsent(device.category, () => []).add(device);
  }
  return grouped;
});

/// Search query state for filtering the device catalog sidebar.
final catalogSearchQueryProvider = StateProvider<String>((ref) => '');

/// Filtered catalog that responds to search queries.
final filteredCatalogProvider =
    FutureProvider<Map<String, List<DeviceBlueprint>>>((ref) async {
  final grouped = await ref.watch(groupedCatalogProvider.future);
  final query = ref.watch(catalogSearchQueryProvider).toLowerCase();
  if (query.isEmpty) return grouped;

  final filtered = <String, List<DeviceBlueprint>>{};
  for (final entry in grouped.entries) {
    final matches = entry.value
        .where((d) => d.name.toLowerCase().contains(query))
        .toList();
    if (matches.isNotEmpty) filtered[entry.key] = matches;
  }
  return filtered;
});
