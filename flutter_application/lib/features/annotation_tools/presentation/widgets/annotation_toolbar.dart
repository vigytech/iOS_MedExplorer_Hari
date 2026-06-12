import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/state_management/interaction_mode_provider.dart';
import '../providers/annotation_state_provider.dart';

/// Toolbar for annotation controls: brush color, width, undo/redo, clear.
/// Dumb widget: receives all data and callbacks via constructor.
class AnnotationToolbar extends StatelessWidget {
  final BrushConfig brushConfig;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<double> onWidthChanged;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onClear;
  final bool canUndo;
  final bool canRedo;
  final InteractionMode currentMode;

  const AnnotationToolbar({
    super.key,
    required this.brushConfig,
    required this.onColorChanged,
    required this.onWidthChanged,
    required this.onUndo,
    required this.onRedo,
    required this.onClear,
    required this.canUndo,
    required this.canRedo,
    required this.currentMode,
  });

  static const _presetColors = [
    AppTheme.brushRed,
    AppTheme.brushBlue,
    AppTheme.brushGreen,
    AppTheme.brushOrange,
    AppTheme.brushBlack,
  ];

  @override
  Widget build(BuildContext context) {
    final isAnnotateMode = currentMode == InteractionMode.annotate;

    return AnimatedOpacity(
      opacity: isAnnotateMode ? 1.0 : 0.4,
      duration: const Duration(milliseconds: 200),
      child: IgnorePointer(
        ignoring: !isAnnotateMode,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd,
            vertical: AppTheme.spacingSm,
          ),
          decoration: BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            border: Border.all(color: AppTheme.divider),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Color presets
              ..._presetColors.map((color) => _ColorDot(
                    color: color,
                    isSelected: brushConfig.color == color,
                    onTap: () => onColorChanged(color),
                  )),
              const SizedBox(width: AppTheme.spacingMd),

              // Width slider
              SizedBox(
                width: 100,
                child: Slider(
                  value: brushConfig.width,
                  min: 1.0,
                  max: 10.0,
                  divisions: 9,
                  activeColor: AppTheme.accent,
                  onChanged: onWidthChanged,
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm),

              // Undo
              IconButton(
                icon: const Icon(Icons.undo, size: 20),
                onPressed: canUndo ? onUndo : null,
                tooltip: 'Undo',
                color: AppTheme.textSecondary,
              ),

              // Redo
              IconButton(
                icon: const Icon(Icons.redo, size: 20),
                onPressed: canRedo ? onRedo : null,
                tooltip: 'Redo',
                color: AppTheme.textSecondary,
              ),

              // Clear
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                onPressed: onClear,
                tooltip: 'Clear all annotations',
                color: AppTheme.danger,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorDot({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppTheme.accent : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4)]
              : null,
        ),
      ),
    );
  }
}
