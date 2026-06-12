import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/annotation_state_provider.dart';
import '../../domain/stroke_entity.dart';
import '../../../../core/state_management/interaction_mode_provider.dart';
import 'annotation_painter.dart';

/// Transparent gesture overlay for freehand annotation drawing.
/// Mode-aware: only captures gestures in Annotate mode.
/// Uses useState for the active stroke (120Hz gesture safety).
class AnnotationOverlay extends HookConsumerWidget {
  const AnnotationOverlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(interactionModeProvider);
    final strokes = ref.watch(annotationProvider);
    final brushConfig = ref.watch(brushConfigProvider);
    final activeStroke = useState<StrokeEntity?>(null);

    final isAnnotateMode = mode == InteractionMode.annotate;

    return LayoutBuilder(
      builder: (context, constraints) {
        final canvasSize = constraints.biggest;

        return GestureDetector(
          // Only capture gestures in Annotate mode
          behavior: isAnnotateMode
              ? HitTestBehavior.opaque
              : HitTestBehavior.translucent,
          onPanStart: isAnnotateMode
              ? (details) {
                  final normalized = _normalize(details.localPosition, canvasSize);
                  final notifier = ref.read(annotationProvider.notifier);
                  activeStroke.value = StrokeEntity(
                    id: notifier.generateStrokeId(),
                    normalizedPoints: [normalized],
                    color: brushConfig.color,
                    strokeWidth: brushConfig.width,
                  );
                }
              : null,
          onPanUpdate: isAnnotateMode
              ? (details) {
                  if (activeStroke.value == null) return;
                  final normalized = _normalize(details.localPosition, canvasSize);
                  // 120Hz safe: mutate local useState, NOT global Riverpod state
                  activeStroke.value =
                      activeStroke.value!.copyWithAddedPoint(normalized);
                }
              : null,
          onPanEnd: isAnnotateMode
              ? (details) {
                  if (activeStroke.value == null) return;
                  // Commit to Riverpod only on gesture end
                  ref.read(annotationProvider.notifier)
                      .commitStroke(activeStroke.value!);
                  activeStroke.value = null;
                }
              : null,
          child: CustomPaint(
            size: canvasSize,
            painter: AnnotationPainter(
              committedStrokes: strokes,
              activeStroke: activeStroke.value,
              canvasSize: canvasSize,
            ),
          ),
        );
      },
    );
  }

  /// Convert pixel position to normalized (0.0-1.0) coordinates.
  Offset _normalize(Offset position, Size canvasSize) {
    return Offset(
      (position.dx / canvasSize.width).clamp(0.0, 1.0),
      (position.dy / canvasSize.height).clamp(0.0, 1.0),
    );
  }
}
