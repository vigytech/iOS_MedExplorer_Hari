import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The two exclusive interaction modes for the workspace canvas.
enum InteractionMode {
  /// Pan/zoom canvas, drag/resize device nodes. Annotation overlay is inert.
  manipulate,

  /// Draw freehand annotations. InteractiveViewer is locked. Device nodes ignore gestures.
  annotate,
}

/// Global interaction mode state.
final interactionModeProvider = StateProvider<InteractionMode>((ref) {
  return InteractionMode.manipulate; // Default: device manipulation mode
});
