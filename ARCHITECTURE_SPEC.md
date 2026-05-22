# ARCHITECTURE_SPEC.md

## 1. System Architecture Overview

**Design Pattern:** Feature-Sliced Clean Architecture with Dependency Inversion.

**Core Principle:** Strict isolation between the Presentation (UI), Application (State), and Infrastructure (Data/C++) layers. Features communicate via isolated event streams, preventing cascading rebuilds.

| Domain | Phase 1: iOS UI Prototype (Current) | Phase 2: Native Core (Future) |
| --- | --- | --- |
| **Data Storage** | `mock_database.dart` (In-memory JSON parsing) | SQLite + SQLCipher (Encrypted offline storage) |
| **Coordinate Snapping** | `mock_snap_engine.dart` (Pure Dart heuristic math) | `cpp_vision_engine` (OpenCV via Dart FFI) |
| **Image Assets** | Local `assets/images/` bundled payload | Dynamic local device storage (Encrypted) |
| **State Output** | Ephemeral (Lost on app termination) | Persistent (Saved to SQLite JSON blobs) |

---

## 2. Data Flow & Feature Coordination Matrix

**Unidirectional Data Flow (UDF):** The Canvas is the single source of truth. The Catalog dispatches intents; the Canvas resolves them.

```text
[Dashboard & Upload] ──(Base Image Selection)──┐
                                               ▼
[Device Catalog] ──(Drag Event / Intent)──► [CANVAS EDITOR] ◄──(RepaintBoundary)── [Export & Share]
  (Sidebar)                                    │   ▲                                      │
                                               │   │ (Z-Index Layering)                   ▼
                                               ▼   │                              [iOS Photos / Share]
                                    [Annotation Tools]
                                    (CustomPainter Overlay)

```

**Coordination Rules:**

* **Catalog -> Canvas:** Devices dragged from `device_catalog` carry a universal `DeviceBlueprint` payload. `canvas_editor` accepts the payload via `DragTarget` and localizes the drop coordinates.
* **Canvas -> Annotation:** `annotation_tools` operates on a strictly transparent overlay stacked above the `canvas_editor`. It does *not* read canvas device nodes; it only scales to match the canvas aspect ratio.

---

## 3. Abstraction & Interface Specification

To guarantee zero UI rewrites when transitioning from Prototype to Production, the UI binds *only* to abstract interfaces injected at the root (`main.dart`).

### Blueprint: Snapping Engine

```dart
// shared/domain/interfaces/i_snap_engine.dart
abstract class ISnapEngine {
  /// Takes normalized drop coordinates and returns snapped normalized coordinates.
  Future<Offset> calculateSnapPosition(Offset sceneDropPos, DeviceBlueprint device);
}

// core/mock_services/mock_snap_engine.dart (Phase 1)
class MockSnapEngine implements ISnapEngine {
  @override
  Future<Offset> calculateSnapPosition(Offset pos, DeviceBlueprint device) async {
    // UI-only heuristic: snaps to nearest 0.1 grid vector
    return Offset((pos.dx * 10).roundToDouble() / 10, (pos.dy * 10).roundToDouble() / 10);
  }
}

```

### Blueprint: Database Repository

```dart
// shared/domain/interfaces/i_device_repository.dart
abstract class IDeviceRepository {
  Future<List<DeviceBlueprint>> fetchCatalog();
}

```

*UI components consume `ISnapEngine` and `IDeviceRepository`. Implementation details (Mock vs. FFI/SQL) are completely hidden from the Presentation layer.*

---

## 4. Canvas State & Coordinate System Strategy

### Normalized Matrix Math (Zoom/Pan Safe)

Absolute pixels are forbidden to ensure layout parity across variable iOS screen dimensions.

1. **Viewport mapping:** Strip UI layout offsets (headers, sidebars) by converting the global drop coordinate to local viewport coordinates: `Offset localPos = canvasBox.globalToLocal(globalDropEvent)`. Then, apply the inverse zoom/pan matrix: `Offset scenePos = transformationController.toScene(localPos)`.
2. **Normalization:** Normalize to a `0.0` - `1.0` vector: `x = scenePos.dx / canvasWidth`, `y = scenePos.dy / canvasHeight`.
3. **Storage:** Store `(x, y)` in application state.
4. **Render:** Multiply stored vectors by current canvas dimensions.

### Canvas Mutation State (Command Pattern)

To prevent 120Hz Garbage Collection thrashing during iOS ProMotion touch events, state relies on the Command Pattern, not Memento deep-copies.

* **Ephemeral State:** During `onPanUpdate`, mutate only the `activeStroke` variable. Do not touch the global stack.
* **Committed State:** On `onPanEnd`, wrap the completed path in an `AddStrokeCommand` and push to the `UndoStack`.
* **State Reconstruction:** Canvas state equals the base image + evaluation of the `UndoStack` commands.

---

## 5. Performance Guardrails for the UI

1. **Repaint Boundary Enforcement:**

* Wrap `canvas_editor` in a `RepaintBoundary`. This prevents static background nodes from rebuilding during volatile `annotation_tools` drawing frames.

2. **CustomPainter Optimization (Path Flattening):**

* If finalized path count exceeds 100, flatten historic paths to an off-screen `ui.Picture` cache. `CustomPainter` should only render the cached picture + the single `activeStroke`.

3. **Isolate Threading Boundary Rules:**

* **Rule 1:** `dart:ui` objects (`ui.Image`, `ui.Picture`) cannot cross Isolate boundaries.
* **Rule 2:** Call `await image.toByteData(format: ui.ImageByteFormat.png)` on the Main UI Thread. The engine processes this asynchronously in C++ without blocking the UI.
* **Rule 3:** Once `Uint8List` (raw bytes) is extracted, pass the raw bytes to `compute()` for CPU-heavy disk formatting, encryption, or file writing.

4. **Drag Throttling:**

* Active scaling/dragging of device nodes must use localized `ValueNotifier` variables. Do NOT update global app state (Riverpod/Bloc) continuously during `onPanUpdate`.
