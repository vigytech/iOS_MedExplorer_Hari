import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Core
import '../../../../core/theme/app_theme.dart';
import '../../../../core/error_handling/feature_error_boundary.dart';
import '../../../../core/state_management/interaction_mode_provider.dart';

// Dashboard & Upload
import '../providers/workspace_state_provider.dart';
import '../widgets/background_selection_grid.dart';

// Device Catalog
import '../../../device_catalog/presentation/providers/device_catalog_provider.dart';
import '../../../device_catalog/presentation/widgets/device_catalog_sidebar.dart';

// Canvas Editor
import '../../../canvas_editor/presentation/widgets/interactive_canvas.dart';

// Annotation Tools
import '../../../annotation_tools/presentation/widgets/annotation_overlay.dart';
import '../../../annotation_tools/presentation/widgets/annotation_toolbar.dart';
import '../../../annotation_tools/presentation/providers/annotation_state_provider.dart';

// Export
import '../../../export_and_share/presentation/widgets/export_overlay.dart';
import '../../../export_and_share/presentation/providers/export_provider.dart';
import '../../../export_and_share/domain/export_result.dart';

// Shared
import '../../../../shared/widgets/mode_toggle_button.dart';

/// Smart Root Widget composing all feature modules.
/// State 1: Background selection grid (no background chosen).
/// State 2: Full workspace with sidebar + canvas + annotations + export.
class MainWorkspaceScreen extends HookConsumerWidget {
  const MainWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBackground = ref.watch(selectedBackgroundProvider);
    final presets = ref.watch(presetBackgroundsProvider);

    // If no background is selected, show the selection grid
    if (selectedBackground == null) {
      return Scaffold(
        backgroundColor: AppTheme.surface,
        body: BackgroundSelectionGrid(
          presets: presets,
          onSelected: (preset) {
            ref.read(selectedBackgroundProvider.notifier).state = preset;
          },
        ),
      );
    }

    // Full workspace mode
    return Scaffold(
      backgroundColor: AppTheme.canvasBackground,
      body: _WorkspaceBody(
        backgroundAssetPath: selectedBackground.assetPath,
      ),
    );
  }
}

class _WorkspaceBody extends HookConsumerWidget {
  final String backgroundAssetPath;

  const _WorkspaceBody({required this.backgroundAssetPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Canvas boundary key for export
    final canvasBoundaryKey = useMemoized(() => GlobalKey());

    // Interaction mode
    final mode = ref.watch(interactionModeProvider);

    // Catalog state
    final filteredCatalog = ref.watch(filteredCatalogProvider);
    final searchQuery = ref.watch(catalogSearchQueryProvider);

    // Annotation state
    final annotationNotifier = ref.watch(annotationProvider.notifier);
    final brushConfig = ref.watch(brushConfigProvider);

    return Row(
      children: [
        // ── Left Sidebar ──────────────────────────────
        FeatureErrorBoundary(
          featureName: 'Device Catalog',
          child: filteredCatalog.when(
            data: (grouped) => DeviceCatalogSidebar(
              groupedDevices: grouped,
              searchQuery: searchQuery,
              onSearchChanged: (query) {
                ref.read(catalogSearchQueryProvider.notifier).state = query;
              },
            ),
            loading: () => Container(
              width: AppTheme.sidebarExpandedWidth,
              color: AppTheme.sidebarBackground,
              child: const Center(
                child: CircularProgressIndicator(color: AppTheme.accent),
              ),
            ),
            error: (error, _) => Container(
              width: AppTheme.sidebarExpandedWidth,
              color: AppTheme.sidebarBackground,
              child: Center(
                child: Text(
                  'Failed to load catalog:\n${error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.danger),
                ),
              ),
            ),
          ),
        ),

        // Divider
        const VerticalDivider(width: 1),

        // ── Canvas + Overlays ─────────────────────────
        Expanded(
          child: FeatureErrorBoundary(
            featureName: 'Canvas Workspace',
            child: Stack(
              children: [
                // Interactive canvas with devices
                InteractiveCanvas(
                  backgroundAssetPath: backgroundAssetPath,
                  canvasBoundaryKey: canvasBoundaryKey,
                  panEnabled: mode == InteractionMode.manipulate,
                  scaleEnabled: mode == InteractionMode.manipulate,
                  overlay: const AnnotationOverlay(),
                ),

                // ── Top Toolbar ───────────────────────
                Positioned(
                  top: AppTheme.spacingMd,
                  left: AppTheme.spacingMd,
                  right: AppTheme.spacingMd,
                  child: Row(
                    children: [
                      // Mode toggle
                      ModeToggleButton(
                        currentMode: mode,
                        onModeChanged: (newMode) {
                          ref.read(interactionModeProvider.notifier).state =
                              newMode;
                        },
                      ),
                      const SizedBox(width: AppTheme.spacingMd),

                      // Annotation toolbar
                      AnnotationToolbar(
                        brushConfig: brushConfig,
                        onColorChanged: (color) {
                          ref.read(brushConfigProvider.notifier).state =
                              brushConfig.copyWith(color: color);
                        },
                        onWidthChanged: (width) {
                          ref.read(brushConfigProvider.notifier).state =
                              brushConfig.copyWith(width: width);
                        },
                        onUndo: () => annotationNotifier.undo(),
                        onRedo: () => annotationNotifier.redo(),
                        onClear: () => annotationNotifier.clearAll(),
                        canUndo: annotationNotifier.canUndo,
                        canRedo: annotationNotifier.canRedo,
                        currentMode: mode,
                      ),
                      const Spacer(),

                      // Change background button
                      IconButton(
                        onPressed: () {
                          ref.read(selectedBackgroundProvider.notifier).state =
                              null;
                        },
                        icon: const Icon(Icons.image, size: 20),
                        tooltip: 'Change Background',
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.surface,
                          foregroundColor: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Export FAB ─────────────────────────
                Positioned(
                  bottom: AppTheme.spacingLg,
                  right: AppTheme.spacingLg,
                  child: FloatingActionButton.extended(
                    onPressed: () => _showExportDialog(context, ref, canvasBoundaryKey),
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Export'),
                    backgroundColor: AppTheme.accent,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showExportDialog(
      BuildContext context, WidgetRef ref, GlobalKey boundaryKey) {
    ref.read(exportProvider.notifier).reset();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Consumer(
          builder: (context, ref, _) {
            final exportState = ref.watch(exportProvider);
            return exportState.when(
              data: (result) => ExportOverlay(
                isExporting: false,
                resultMessage: result == null
                    ? null
                    : result is ExportSuccess
                        ? 'Saved to Photos: ${result.filePath}'
                        : 'Export failed: ${(result as ExportFailure).message}',
                onConfirmExport: () {
                  ref.read(exportProvider.notifier).exportCanvas(boundaryKey);
                },
                onDismiss: () => Navigator.of(dialogContext).pop(),
              ),
              loading: () => ExportOverlay(
                isExporting: true,
                onConfirmExport: () {},
                onDismiss: () {},
              ),
              error: (error, _) => ExportOverlay(
                isExporting: false,
                resultMessage: 'Export failed: ${error.toString()}',
                onConfirmExport: () {},
                onDismiss: () => Navigator.of(dialogContext).pop(),
              ),
            );
          },
        );
      },
    );
  }
}
