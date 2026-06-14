---
trigger: glob
globs: lib/features/**/presentation/**/*.dart
---

# Autonomous UI Testing & Vision Rules

Whenever you create or modify a Presentation widget, you must immediately create a corresponding test file in the `test/features/` directory. You will use these tests as your "eyes" to verify the UI.

## 1. The "Read" Mechanism (Widget Tests)
You must write tests using `WidgetTester` to verify the structural integrity of the UI.
* Pump the widget inside a `ProviderScope` and `MaterialApp`.
* Trigger touch events using `tester.tap()`.
* **If a test fails:** You must use `debugDumpApp()` or `print(tester.element(find.byType(MyWidget)).toStringDeep())` in your test code to print the entire widget tree to the terminal. You will read this terminal output to "see" exactly where the layout or padding went wrong.

## 2. The "Sight" Mechanism (Golden Tests)
To verify visual design (colors, medical asset scaling, and borders), you must generate Golden Files.
* Write a test ending with `await expectLater(find.byType(MyWidget), matchesGoldenFile('goldens/my_widget_master.png'));`
* Run the terminal command `flutter test --update-goldens` to generate the image.
* If you have vision capabilities, you can inspect the `.png` file in the `goldens/` directory to verify the UI matches the medical design system.

## 3. Strict Execution Protocol
1. After writing a Flutter widget, write its test file.
2. Run `flutter test test/features/path_to_test.dart` in the terminal.
3. If it fails, read the terminal trace, fix the widget, and run the test again until it passes.