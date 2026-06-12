import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../domain/stroke_entity.dart';
import '../../domain/canvas_command.dart';
import 'dart:ui' show Color;
import '../../../../core/theme/app_theme.dart';

/// Manages annotation strokes via the Command Pattern for undo/redo support.
class AnnotationNotifier extends StateNotifier<List<StrokeEntity>> {
  final List<CanvasCommand> _undoStack = [];
  final List<CanvasCommand> _redoStack = [];
  final _uuid = const Uuid();

  AnnotationNotifier() : super([]);

  List<StrokeEntity> get strokes => state;
  bool get canUndo => _undoStack.isNotEmpty;
  bool get canRedo => _redoStack.isNotEmpty;

  /// Commit a completed stroke to the undo stack.
  void commitStroke(StrokeEntity stroke) {
    final command = AddStrokeCommand(stroke);
    _undoStack.add(command);
    _redoStack.clear();
    _reconstructState();
  }

  /// Undo the last action.
  void undo() {
    if (_undoStack.isEmpty) return;
    final command = _undoStack.removeLast();
    _redoStack.add(command);
    _reconstructState();
  }

  /// Redo the last undone action.
  void redo() {
    if (_redoStack.isEmpty) return;
    final command = _redoStack.removeLast();
    _undoStack.add(command);
    _reconstructState();
  }

  /// Clear all strokes (undoable).
  void clearAll() {
    if (state.isEmpty) return;
    final command = ClearAllCommand(List.from(state));
    _undoStack.add(command);
    _redoStack.clear();
    _reconstructState();
  }

  /// Generate a unique ID for a new stroke.
  String generateStrokeId() => _uuid.v4();

  /// Replay the command stack to reconstruct current state.
  void _reconstructState() {
    final strokes = <StrokeEntity>[];
    for (final command in _undoStack) {
      switch (command) {
        case AddStrokeCommand(stroke: final s):
          strokes.add(s);
        case RemoveStrokeCommand(strokeId: final id):
          strokes.removeWhere((s) => s.id == id);
        case ClearAllCommand():
          strokes.clear();
      }
    }
    state = strokes;
  }
}

/// Global annotation state provider.
final annotationProvider =
    StateNotifierProvider<AnnotationNotifier, List<StrokeEntity>>((ref) {
  return AnnotationNotifier();
});

/// Brush configuration state.
class BrushConfig {
  final Color color;
  final double width;

  const BrushConfig({
    this.color = AppTheme.brushRed,
    this.width = 3.0,
  });

  BrushConfig copyWith({Color? color, double? width}) {
    return BrushConfig(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }
}

final brushConfigProvider = StateProvider<BrushConfig>((ref) {
  return const BrushConfig();
});
