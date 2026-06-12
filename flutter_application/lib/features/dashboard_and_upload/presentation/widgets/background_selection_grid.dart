import 'package:flutter/material.dart';
import '../../domain/base_image_entity.dart';
import '../../../../core/theme/app_theme.dart';

/// A centered grid of preset image thumbnails for background selection.
/// Dumb widget: receives data + callbacks, no Riverpod.
class BackgroundSelectionGrid extends StatelessWidget {
  final List<BaseImageEntity> presets;
  final ValueChanged<BaseImageEntity> onSelected;

  const BackgroundSelectionGrid({
    super.key,
    required this.presets,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingXxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.medical_services_outlined,
              size: 64,
              color: AppTheme.accent,
            ),
            const SizedBox(height: AppTheme.spacingLg),
            Text(
              'Select an Anatomical Background',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppTheme.spacingSm),
            Text(
              'Choose a base image to begin placing medical devices',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppTheme.spacingXl),
            Wrap(
              spacing: AppTheme.spacingMd,
              runSpacing: AppTheme.spacingMd,
              children: presets.map((preset) {
                return _PresetCard(
                  preset: preset,
                  onTap: () => onSelected(preset),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _PresetCard extends StatelessWidget {
  final BaseImageEntity preset;
  final VoidCallback onTap;

  const _PresetCard({
    required this.preset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: AppTheme.surfaceVariant,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          border: Border.all(color: AppTheme.divider),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusMd),
                ),
                child: Image.asset(
                  preset.assetPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingSm),
              child: Text(
                preset.displayName,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
