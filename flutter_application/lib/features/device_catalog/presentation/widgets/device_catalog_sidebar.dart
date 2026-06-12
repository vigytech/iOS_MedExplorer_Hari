import 'package:flutter/material.dart';
import '../../domain/device_blueprint.dart';
import '../../../../core/theme/app_theme.dart';

/// Left-hand sidebar displaying categorized medical devices.
/// Dumb widget: receives grouped catalog data and callbacks.
/// Each device is a LongPressDraggable<DeviceBlueprint>.
class DeviceCatalogSidebar extends StatelessWidget {
  final Map<String, List<DeviceBlueprint>> groupedDevices;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const DeviceCatalogSidebar({
    super.key,
    required this.groupedDevices,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppTheme.sidebarExpandedWidth,
      color: AppTheme.sidebarBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Catalog',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppTheme.spacingSm),
                // Search bar
                TextField(
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search devices...',
                    hintStyle: const TextStyle(color: AppTheme.textTertiary),
                    prefixIcon: const Icon(Icons.search, color: AppTheme.textTertiary),
                    filled: true,
                    fillColor: AppTheme.surfaceVariant,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd,
                      vertical: AppTheme.spacingSm,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Categorized device list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
              children: groupedDevices.entries.map((entry) {
                return _CategorySection(
                  categoryName: entry.key,
                  devices: entry.value,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySection extends StatelessWidget {
  final String categoryName;
  final List<DeviceBlueprint> devices;

  const _CategorySection({
    required this.categoryName,
    required this.devices,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        categoryName,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      initiallyExpanded: true,
      childrenPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingSm,
      ),
      children: [
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: devices.map((device) {
            return _DraggableDeviceCard(device: device);
          }).toList(),
        ),
        const SizedBox(height: AppTheme.spacingSm),
      ],
    );
  }
}

class _DraggableDeviceCard extends StatelessWidget {
  final DeviceBlueprint device;

  const _DraggableDeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<DeviceBlueprint>(
      data: device,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border: Border.all(color: AppTheme.accent, width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            child: Image.asset(device.iconPath, fit: BoxFit.cover),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.4,
        child: _DeviceCard(device: device),
      ),
      child: _DeviceCard(device: device),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final DeviceBlueprint device;

  const _DeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(color: AppTheme.divider),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              child: Image.asset(device.iconPath, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            device.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 11,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
