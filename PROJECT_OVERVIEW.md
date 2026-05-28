# Medical Suite Edge Application - Project Overview

## 1. Purpose of the Project
The primary objective of this project is to build a highly interactive, visual communication tool for medical professionals. The application serves two core functions:
1. **Patient Education:** To provide doctors with a dynamic visual aid to clearly explain where a medical device (e.g., stent, pacemaker, heart valve) will be inserted, how it fits within the patient's specific anatomy, and its intended effect.
2. **Physician Collaboration:** To act as an advanced, medical-grade "MS Paint" allowing doctors to annotate anatomical diagrams, write specific surgical notes, draw blockages/plaque, and securely export the diagram to share with other medical professionals.

This is designed as a secure, offline-first "edge" application to ensure maximum performance and compliance with patient data privacy standards.

## 2. Minimum Viable Product (MVP)
The MVP is a responsive 2D canvas application that allows a user to:
* **Ingest:** Select a 2D anatomical background image (`.png` or `.jpeg`).
* **Catalog Navigation:** Browse a categorized left-hand sidebar containing various medical device blueprints (Intravascular, Structural, Device-Mediated).
* **Manipulation:** Drag and drop devices onto the canvas, automatically mapping them to the correct scale, with the ability to dynamically stretch or resize the implant (e.g., lengthening a stent).
* **Annotation:** Utilize a freehand drawing overlay to circle areas of interest or simulate blockages (clots, plaque) with different brush colors/thicknesses.
* **Extraction:** Capture the final composited layout (background + snapped devices + annotations) and export it as a single, flat `.png` file to the device's local photo library.

## 3. Current Plan
The immediate strategy is to execute **Phase 1: Tactical iOS UI Prototype**. 
Instead of building the entire full-stack monorepo at once, the current plan isolates the presentation layer. We are building a high-fidelity, pure-Dart mock environment that proves the gesture mechanics, canvas math, and UI/UX flow on a physical iPad/iPhone. By using strict Dependency Inversion (abstract interfaces), the UI we build today will not require rewriting when the heavy native data engines are introduced in Phase 2.

## 4. What I Am Currently Doing
*Focusing exclusively on the UI layer, gesture state mechanics, and iOS physical deployment.*
* **Architecting the Monorepo:** Enforcing a strict Feature-Sliced structure (e.g., isolating `canvas_editor` from `annotation_tools`) using the Smart/Dumb widget pattern.
* **Canvas Matrix Math:** Implementing `InteractiveViewer` for zooming/panning, and writing the mathematical pipelines to normalize global screen coordinates down to unitless canvas vectors (`0.0` to `1.0`).
* **120Hz Gesture State:** Building the annotation and drag-and-drop mechanics using `ValueNotifier` and the Command Pattern to ensure Apple Pencil/touch updates run at 120fps without triggering garbage collection thrashing.
* **Mocking Dependencies:** Using Riverpod to inject mock services (`MockSnapEngine`, `MockDatabase`) to feed the UI without needing a real backend.
* **Configuring iOS Bare-Metal Builds:** Setting up the Xcode workspace and Apple Developer signing to ensure the app compiles flawlessly to physical iOS test devices.
* **Export Pipeline:** Implementing `RepaintBoundary` logic to capture the widget tree, convert it to raw byte data on the UI thread, and process the `.png` via background isolates.

## 5. What I Am Currently NOT Doing (Future Scope)
*To maintain velocity, these features are explicitly deferred to later phases:*
* **No C++ Computer Vision (FFI):** I am currently *not* building the OpenCV segmentation engine that automatically detects blood vessel boundaries for smart-snapping. I am using pure Dart heuristic math (grid-snapping) as a placeholder.
* **No Local Database:** I am currently *not* implementing SQLite or SQLCipher. Catalog data and device blueprints are hardcoded JSON assets in memory. Saved state is ephemeral and disappears when the app is killed.
* **No Server/Cloud Syncing:** I am currently *not* building APIs, authentication servers, or cloud-based physician-to-physician sharing systems. All exports are handled via local OS share sheets.
* **No 3D Anatomical Modeling:** I am currently *not* integrating Unreal Engine/Unity or handling 3D mesh scaling. The focus is strictly 2D raster images.
* **No Multi-Platform Deployment:** While the framework supports Windows/Mac/Android, I am currently *not* compiling or testing for those platforms.

## 6. Languages & Technology Stack
### Active Stack (Phase 1)
* **Dart:** The sole programming language driving the application logic, UI coordinate math, and mock service implementations.
* **Flutter:** The cross-platform rendering engine providing the Canvas, DragTargets, CustomPainters, and UI component tree.
* **Native iOS Configuration Files:**
  * `ios/Runner.xcworkspace`: Required for Xcode build orchestration and Apple Developer provisioning.
  * `ios/Runner/Info.plist`: Required to declare native permissions (specifically `NSPhotoLibraryAddUsageDescription` to allow the app to save the exported PNGs).

### Deferred Stack (Phase 2 & Beyond)
* **C++:** Will be used to build the standalone `cpp_vision_engine` for heavy mathematical computation and anatomical boundary detection, communicating with Flutter via Dart FFI (Foreign Function Interface) for zero-latency execution.
* **SQL:** Will be used alongside SQLite/SQLCipher to generate encrypted, on-device relational databases for storing persistent patient diagram states and comprehensive medical device inventories.