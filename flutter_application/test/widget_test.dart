import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_medexplorer_hari/main.dart';

void main() {
  testWidgets('App launches without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MedExplorerApp(),
      ),
    );
    // Verify the app renders without throwing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
