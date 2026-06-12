import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/png_export_service.dart';
import '../../domain/export_result.dart';

/// Provider for the export service instance.
final exportServiceProvider = Provider<PngExportService>((ref) {
  return PngExportService();
});

/// State notifier managing the export lifecycle.
class ExportNotifier extends StateNotifier<AsyncValue<ExportResult?>> {
  final PngExportService _service;

  ExportNotifier(this._service) : super(const AsyncValue.data(null));

  /// Trigger the export pipeline.
  Future<void> exportCanvas(GlobalKey boundaryKey) async {
    state = const AsyncValue.loading();

    final result = await _service.captureAndExport(boundaryKey);

    state = AsyncValue.data(result);
  }

  /// Reset state for next export.
  void reset() {
    state = const AsyncValue.data(null);
  }
}

/// Global export provider.
final exportProvider =
    StateNotifierProvider<ExportNotifier, AsyncValue<ExportResult?>>((ref) {
  final service = ref.watch(exportServiceProvider);
  return ExportNotifier(service);
});
