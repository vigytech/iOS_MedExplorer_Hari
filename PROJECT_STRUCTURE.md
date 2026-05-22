# Medical Suite Edge Application - iOS UI Prototype Phase

This structure is aggressively optimized for an Antigravity IDE context window during a UI-only prototype phase. All C++, local database, and FFI layers have been stripped to maximize token efficiency. Native iOS directories have been exposed to handle bare-metal device deployment and permission entitlements.

```text
medical_suite_monorepo/
│
├── .agents/                               # IDE context guardrails.
│   ├── rules/                             # System prompts explicitly instructing the AI to use mock data and pure-Dart math for this phase.
│   │   ├── 01_phase_scope_and_di.md           # Global boundaries, mock enforcement, and layer decoupling.
│   │   ├── 02_canvas_matrix_and_state.md      # Matrix transformations, gestures, and drawing performance.
│   │   ├── 03_design_system_and_widgets.md    # Adherence to design tokens and asset management rules.
│   │   └── 04_export_and_threads.md           # Image rendering hooks, isolate limits, and iOS configurations.
│   │
│   └── workflows/                         # Shortcuts for generating dumb UI widgets and mock repository classes.
│
├── ARCHITECTURE_SPEC.md                   # Core system design (includes notes on future C++ FFI/SQLite integration).
├── SETUP_INSTRUCTIONS.md                  # iOS physical device deployment steps (Code Signing, Bundle IDs).
│
└── flutter_application/                   # The primary mobile application workspace.
    ├── pubspec.yaml                       # Dart dependencies (e.g., flutter_riverpod, path_provider) and asset declarations.
    │
    ├── ios/                               # CRITICAL: Native iOS host environment.
    │   ├── Runner.xcworkspace             # The Xcode project required for Apple Developer code-signing and physical device builds.
    │   └── Runner/Info.plist              # Native permissions registry (Must contain NSPhotoLibraryAddUsageDescription for PNG exports).
    │
    ├── assets/                            # Local static assets driving the mock UI.
    │   ├── images/                        # Raster files (.png/.jpeg) for backgrounds and draggable medical devices.
    │   └── mock_data/                     # JSON files simulating database responses (device catalogs, anatomical zones).
    │
    └── lib/                               # The compiled Dart codebase.
        ├── main.dart                      # App entry point; initializes dependency injection and sets up mock services.
        │
        ├── core/                          # App-wide UI infrastructure and simulated backends.
        │   ├── mock_services/             # Interface implementations returning fake data or pure-Dart logic (replaces future SQL/FFI).
        │   │   ├── mock_snap_engine.dart  # Pure Dart fallback simulating C++ coordinate snapping.
        │   │   └── mock_database.dart     # Parses assets/mock_data/ to feed the UI.
        │   ├── state_management/          # Global UI state providers bridging the mock services to the features.
        │   └── theme_and_styling/         # Design system: Colors, typography, and canvas grid tokens.
        │
        ├── shared/                        # Reusable boundaries and primitive widgets.
        │   ├── domain_models/             # Pure data classes (e.g., `DeviceBlueprint`, `CanvasNode`) independent of any UI or backend.
        │   ├── ui_components/             # Dumb, stateless presentation widgets.
        │   └── utils/                     # UI-level geometric math helpers (bounding box collisions, aspect ratio scaling).
        │
        └── features/                      # Isolated UI business domains.
            │
            ├── annotation_tools/          # The sketch overlay system.
            │   ├── presentation/          # CustomPainter classes, brush sliders, and clear-canvas triggers.
            │   └── application/           # In-memory vector path recording and undo/redo stack logic.
            │
            ├── canvas_editor/             # The interactive 2D diagram workspace.
            │   ├── presentation/          # DragTarget zones, InteractiveViewer (pan/zoom), and positioned nodes.
            │   └── application/           # Local state tracking for X/Y coordinates, scale, and active layers.
            │
            ├── dashboard_and_upload/      # The prototype entry screen.
            │   └── presentation/          # Hardcoded layout simulating the ingestion of a base anatomical image.
            │
            ├── device_catalog/            # The interactive inventory.
            │   ├── presentation/          # Draggable device tiles and collapsible UI sidebars.
            │   └── application/           # Reads from core/mock_services to populate the lists.
            │
            └── export_and_share/          # Pixel capture and extraction.
                ├── presentation/          # Export trigger buttons and success/failure toast notifications.
                └── application/           # Uses RepaintBoundary to capture the widget tree, converting it to Uint8List and saving to iOS Photos as .png file.
```