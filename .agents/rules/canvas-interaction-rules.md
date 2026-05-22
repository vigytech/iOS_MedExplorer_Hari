---
trigger: glob
globs: lib/features/{canvas_editor,annotation_tools}/**/*.dart
---

# Interactive Canvas Geometric & Rendering Rules

## 1. Spatial Coordinate Mapping (Zoom/Pan Safe)
- **Rule:** Absolute pixels are forbidden. Canvas nodes use unitless normalized vectors (`0.0` to `1.0`).
- **Execution Sequence:** Resolve `DragTargetDetails.offset` using this exact matrix pipeline:

    // 1. Guard against malformed payloads and type cast
    if (details.data is! DeviceBlueprint) return;
    final DeviceBlueprint payload = details.data as DeviceBlueprint;

    // 2. Strip sidebar/header UI offsets
    final RenderBox canvasBox = canvasContext.findRenderObject() as RenderBox;
    final Offset localPos = canvasBox.globalToLocal(details.offset);
    
    // 3. Reverse active InteractiveViewer matrix into child scene space
    final Offset scenePos = transformationController.toScene(localPos);
    
    // 4. Guard layout state and extract intrinsic background bounds
    if (!backgroundAssetBox.hasSize) return;
    final double sceneWidth = backgroundAssetBox.size.width; 
    final double sceneHeight = backgroundAssetBox.size.height;
    final double normNodeWidth = payload.defaultWidthRatio;
    final double normNodeHeight = payload.defaultHeightRatio;
    
    // 5. Normalize & clamp against intrinsic bounds (prevent off-canvas rendering)
    final double normX = (scenePos.dx / sceneWidth).clamp(0.0, 1.0 - normNodeWidth);
    final double normY = (scenePos.dy / sceneHeight).clamp(0.0, 1.0 - normNodeHeight);

## 2. 120Hz Gesture State & Lifecycle Safety
- **Rule:** Protect iOS ProMotion UI threads. Ban `setState()` and Riverpod/Bloc global updates during continuous touch gestures.
- **Execution:**
  - `onPanUpdate`: Mutate purely local `ValueNotifier` instances (`activeStroke`, `activeDragPos`).
  - `onPanEnd`: Wrap the completed vector/node in a Command Object (`AddStrokeCommand`) and push to the global `UndoStack` via Riverpod.
- **Lifecycle Safety:** `ValueNotifier` objects MUST be declared inside a `StatefulWidget` and explicitly cleaned up inside the `dispose()` override to prevent memory leakage.

## 3. CustomPainter Layer Optimizations
- **Require:** Isolate the canvas viewport inside a `RepaintBoundary` to prevent static background invalidation during volatile freehand sketching.
- **Require:** Implement path flattening. If `UndoStack` historic strokes exceed 100, flush them to an off-screen `ui.Picture` cache. `CustomPainter` renders only the cached picture + the active `ValueNotifier` stroke.