import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/state_management/interaction_mode_provider.dart';
import '../../../../core/theme/app_theme.dart';

/// Segmented control to toggle between Manipulate and Annotate modes.
/// Dumb widget: receives current mode + callback, no Riverpod.
class ModeToggleButton extends StatelessWidget {
  final InteractionMode currentMode;
  final ValueChanged<InteractionMode> onModeChanged;

  const ModeToggleButton({
    super.key,
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: CupertinoSlidingSegmentedControl<InteractionMode>(
        groupValue: currentMode,
        backgroundColor: AppTheme.surfaceVariant,
        thumbColor: AppTheme.surface,
        children: const {
          InteractionMode.manipulate: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.open_with, size: 18, color: AppTheme.textPrimary),
                SizedBox(width: 6),
                Text('Move',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary)),
              ],
            ),
          ),
          InteractionMode.annotate: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, size: 18, color: AppTheme.textPrimary),
                SizedBox(width: 6),
                Text('Draw',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary)),
              ],
            ),
          ),
        },
        onValueChanged: (InteractionMode? value) {
          if (value != null) {
            onModeChanged(value);
          }
        },
      ),
    );
  }
}
