# Medical Suite Edge Application - iOS UI Prototype Phase

This structure utilizes **Feature-First Clean Architecture**. The application is sliced by business domain. Each feature is a strictly independent, crash-resilient module containing its own Data, Domain, and Presentation layers. If one feature crashes, it is caught by an isolated Error Boundary, ensuring the rest of the application continues to function flawlessly.

```text
medical_suite_monorepo/
│
├── .agents/                               # IDE context guardrails.
│   ├── rules/                             # System prompts explicitly instructing the AI to use mock data and pure-Dart math.
│   └── workflows/                         # Shortcuts for generating dumb UI widgets and mock repository classes.
│
├── ARCHITECTURE_SPEC.md                   # Core system design (includes notes on future C++ FFI/SQLite integration).
├── SETUP_INSTRUCTIONS.md                  # iOS physical device deployment steps (Code Signing, Bundle IDs).
│
└── flutter_application/                   # The primary mobile application workspace.
    ├── pubspec.yaml                       # Dart dependencies and asset declarations.
    │
    ├── ios/                               # CRITICAL: Native iOS host environment.
    │   ├── Runner.xcworkspace             # The Xcode project required for Apple Developer code-signing and physical device builds.
    │   └── Runner/Info.plist              # Native permissions registry (Must contain NSPhotoLibraryAddUsageDescription).
    │
    ├── assets/                            # Local static assets driving the mock UI.
    │   ├── images/                        # Raster files (.png/.jpeg) for backgrounds and draggable medical devices.
    │   └── mock_data/                     # JSON files simulating database responses.
    │
    └── lib/                               # The compiled Dart codebase.
        ├── main.dart                      # App entry point; initializes global error catchers and dependency injection.
        │
        ├── core/                          # Global infrastructure (Features depend on Core, Core depends on nothing).
        │   ├── constants/                 # Global constants (e.g., `app_assets.dart` for all image paths).
        │   ├── error_handling/            # Global crash reporters and `ErrorBoundary` widget wrappers.
        │   ├── router/                    # App-wide routing definitions.
        │   └── theme/                     # Design system: Colors, typography, and canvas grid tokens.
        │
        ├── shared/                        # Universal, dumb UI primitives used across multiple features.
        │   └── widgets/                   # e.g., PrimaryButton, LoadingSpinner, CustomToast.
        │
        └── features/                      # 🚀 INDEPENDENT, ISOLATED BUSINESS DOMAINS
            │
            ├── annotation_tools/          # The sketch overlay system.
            │   ├── data/                  # Local storage logic for stroke history.
            │   ├── domain/                # Stroke entities and undo/redo interfaces.
            │   └── presentation/          # CustomPainters, isolated Riverpod providers, UI controls.
            │
            ├── canvas_editor/             # The interactive 2D diagram workspace.
            │   ├── data/                  # Implementations for mock coordinate snapping (`MockSnapEngine`).
            │   ├── domain/                # Interfaces (`ISnapEngine`) and canvas coordinate entities.
            │   └── presentation/          # DragTarget zones, InteractiveViewer, isolated state tracking.
            │
            ├── dashboard_and_upload/      # The prototype entry screen.
            │   ├── data/                  # Image ingestion handlers.
            │   ├── domain/                # Base image entities.
            │   └── presentation/          # Home screen layout and upload triggers.
            │
            ├── device_catalog/            # The interactive inventory.
            │   ├── data/                  # Parses `assets/mock_data/` to generate catalogs.
            │   ├── domain/                # `DeviceBlueprint` entities and Repository interfaces.
            │   └── presentation/          # Draggable device tiles and sidebar providers.
            │
            └── export_and_share/          # Pixel capture and extraction.
                ├── data/                  # Byte conversion and native iOS file system APIs.
                ├── domain/                # Export interfaces and failure/success entities.
                └── presentation/          # Export trigger buttons and success/failure overlays.
```
