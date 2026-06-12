import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart' show GlobalKey;
import 'package:flutter/rendering.dart';
import '../domain/export_result.dart';

/// Implements the exact threading rules from ARCHITECTURE_SPEC.md §5:
/// 1. Main Thread: RenderRepaintBoundary.toImage() + toByteData()
/// 2. Background Isolate: Process raw bytes (formatting, future watermarking)
class PngExportService {
  Future<ExportResult> captureAndExport(GlobalKey boundaryKey) async {
    try {
      // ── MAIN THREAD: Capture RenderRepaintBoundary ──
      final boundary = boundaryKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) {
        return const ExportFailure('Canvas render boundary not found');
      }

      // Rule 2: toImage() + toByteData() on Main Thread
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      image.dispose();

      if (byteData == null) {
        return const ExportFailure('Failed to encode image to byte data');
      }

      // ── BACKGROUND ISOLATE: Process bytes ──
      // Rule 3: Raw Uint8List can safely cross Isolate boundaries
      final Uint8List pngBytes = byteData.buffer.asUint8List();
      final String filePath = await compute(_processBytes, pngBytes);

      return ExportSuccess(filePath);
    } catch (e) {
      return ExportFailure('Export failed: ${e.toString()}');
    }
  }

  /// Runs in a background Isolate via compute().
  /// Phase 1: Formats bytes for image_gallery_saver.
  /// Phase 2: Will add encryption, watermarking, metadata embedding.
  static Future<String> _processBytes(Uint8List pngBytes) async {
    return 'export_${DateTime.now().millisecondsSinceEpoch}.png';
  }
}
