import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Antigravity will uncomment these once it generates the real widgets
// import 'package:ios_medexplorer_hari/features/device_catalog/domain/device_blueprint.dart';
// import 'package:ios_medexplorer_hari/features/device_catalog/presentation/widgets/device_tile.dart';

void main() {
  testWidgets('DeviceTile renders correctly and matches Golden Image', (WidgetTester tester) async {
    // 1. Arrange: Pump the widget into the headless test environment
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              // Antigravity will replace this Text with the real DeviceTile widget
              child: Text(
                'Placeholder for DeviceTile', 
                style: TextStyle(fontSize: 24, color: Colors.black),
              ), 
            ),
          ),
        ),
      ),
    );

    // Wait for any animations or image assets to finish loading
    await tester.pumpAndSettle();

    // 2. Assert (Visual): Generate an image file for Antigravity to "see"
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/device_tile_master.png'),
    );
  });
}