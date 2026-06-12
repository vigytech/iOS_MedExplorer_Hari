import 'stroke_entity.dart';

/// Command Pattern for undo/redo on the annotation canvas.
/// Per ARCHITECTURE_SPEC.md §4.
sealed class CanvasCommand {
  const CanvasCommand();
}

/// Records the addition of a completed stroke.
class AddStrokeCommand extends CanvasCommand {
  final StrokeEntity stroke;
  const AddStrokeCommand(this.stroke);
}

/// Records the removal of a specific stroke by ID.
class RemoveStrokeCommand extends CanvasCommand {
  final String strokeId;
  const RemoveStrokeCommand(this.strokeId);
}

/// Records a clear-all action (stores the previous state for undo).
class ClearAllCommand extends CanvasCommand {
  final List<StrokeEntity> previousStrokes;
  const ClearAllCommand(this.previousStrokes);
}
