import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/base_image_entity.dart';
import '../../../../core/constants/app_assets.dart';

/// Preset anatomical background images available for selection.
/// Phase 1: uses existing bundled device images as stand-in backgrounds.
/// Phase 2: will add actual anatomical diagrams + camera/gallery picker.
final presetBackgroundsProvider = Provider<List<BaseImageEntity>>((ref) {
  return const [
    BaseImageEntity(
      id: 'cardiac_system',
      displayName: 'Cardiac System',
      assetPath: AppAssets.pacemakerGeneric,
    ),
    BaseImageEntity(
      id: 'vascular_system',
      displayName: 'Vascular System',
      assetPath: AppAssets.aorticEndograft1,
    ),
    BaseImageEntity(
      id: 'spinal_system',
      displayName: 'Spinal System',
      assetPath: AppAssets.spinalGenericImplant,
    ),
    BaseImageEntity(
      id: 'joint_system',
      displayName: 'Joint System',
      assetPath: AppAssets.jointGenericImplant,
    ),
  ];
});

/// Currently selected background image. Null = show selection grid.
final selectedBackgroundProvider =
    StateProvider<BaseImageEntity?>((ref) => null);
