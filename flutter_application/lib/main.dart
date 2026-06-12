import 'dart:async';
import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard_and_upload/presentation/screens/main_workspace_screen.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      // Global Flutter framework error handler
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.presentError(details);
        debugPrint('[GLOBAL ERROR] ${details.exceptionAsString()}');
      };

      // Global platform error handler
      PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
        debugPrint('[PLATFORM ERROR] $error\n$stack');
        return true;
      };

      runApp(
        const ProviderScope(
          child: MedExplorerApp(),
        ),
      );
    },
    (Object error, StackTrace stack) {
      debugPrint('[ZONE ERROR] $error\n$stack');
    },
  );
}

class MedExplorerApp extends StatelessWidget {
  const MedExplorerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Suite Explorer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.buildClinicalTheme(),
      home: const MainWorkspaceScreen(),
    );
  }
}
