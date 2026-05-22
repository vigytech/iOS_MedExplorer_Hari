---
trigger: always_on
---

# UI Architecture & Mock Sandbox Rules

## 1. Dependency Inversion (Smart vs. Dumb Widgets)
- **Target:** Phase 1 iOS UI Prototype. No backend, no C++, no persistent DB.
- **Rule:** UI components must strictly enforce the Smart/Dumb architectural boundary to prevent domain-logic pollution in the render tree.
- **Execution:**
  - **Smart Widgets (Feature Roots):** Use Riverpod (`ConsumerWidget`) to inject interfaces via `ref.read(snapEngineProvider)`. These components act as controllers.
  - **Dumb Widgets (Leaf UI):** Strictly framework-agnostic `StatelessWidget` or `StatefulWidget`. 
    - **Data In:** Receive only pure Dart models (e.g., `DeviceBlueprint`) and primitives via constructor.
    - **Action Out:** Expose functional callbacks (`ValueChanged<Offset>`, `VoidCallback`).
    - **BAN:** Do NOT pass domain interfaces (`ISnapEngine`, `IDeviceRepository`) into Dumb Widgets.

## 2. Framework Bans & Mocking
- **Ban:** `dart:ffi`, `drift`, `sqflite`, `sqlcipher`, and heavy routing (e.g., `go_router`). 
- **Require:** Use core Flutter `Navigator` or indexed stacks for routing.
- **Require:** Simulate latency using `Future.delayed()` reading from `assets/mock_data/` JSONs.

## 3. Isolate Thread Boundaries (Image Export)
- **Main Thread Only:** Execute `RenderRepaintBoundary.toImage()` and `image.toByteData()` strictly on the UI thread. The underlying C++ Engine handles this asynchronously.
- **Boundary Restriction:** `dart:ui` objects (`ui.Image`, `ui.Picture`) contain GPU pointers and CANNOT cross Isolate boundaries via `SendPort`.
- **Background Thread:** Pass only the extracted `Uint8List` byte array into `compute()` for background file I/O and PNG formatting.