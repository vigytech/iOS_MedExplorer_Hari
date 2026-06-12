import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// Export confirmation overlay dialog.
/// Dumb widget: receives export state and callbacks via constructor.
class ExportOverlay extends StatelessWidget {
  final VoidCallback onConfirmExport;
  final bool isExporting;
  final String? resultMessage;
  final VoidCallback onDismiss;

  const ExportOverlay({
    super.key,
    required this.onConfirmExport,
    required this.isExporting,
    this.resultMessage,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
      title: Row(
        children: [
          Icon(
            resultMessage != null
                ? (resultMessage!.startsWith('Export failed')
                    ? Icons.error_outline
                    : Icons.check_circle_outline)
                : Icons.save_alt,
            color: resultMessage != null
                ? (resultMessage!.startsWith('Export failed')
                    ? AppTheme.danger
                    : AppTheme.accent)
                : AppTheme.textPrimary,
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Text(
            resultMessage != null ? 'Export Result' : 'Export to Photos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isExporting) ...[
            const Center(
              child: CircularProgressIndicator(color: AppTheme.accent),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            Text(
              'Capturing canvas and compositing layers...',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ] else if (resultMessage != null) ...[
            Text(
              resultMessage!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ] else ...[
            Text(
              'Save the current canvas (background + devices + annotations) as a PNG image to your Photo Library.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ],
      ),
      actions: [
        if (!isExporting) ...[
          TextButton(
            onPressed: onDismiss,
            child: Text(
              resultMessage != null ? 'Close' : 'Cancel',
              style: const TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          if (resultMessage == null)
            ElevatedButton.icon(
              onPressed: onConfirmExport,
              icon: const Icon(Icons.save_alt, size: 18),
              label: const Text('Save to Photos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
              ),
            ),
        ],
      ],
    );
  }
}
