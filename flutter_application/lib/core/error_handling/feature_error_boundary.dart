import 'package:flutter/material.dart';

/// Isolates feature-level widget tree crashes. If a feature throws,
/// this boundary catches it and renders a graceful fallback UI
/// instead of crashing the entire application.
class FeatureErrorBoundary extends StatefulWidget {
  final String featureName;
  final Widget child;

  const FeatureErrorBoundary({
    super.key,
    required this.featureName,
    required this.child,
  });

  @override
  State<FeatureErrorBoundary> createState() => _FeatureErrorBoundaryState();
}

class _FeatureErrorBoundaryState extends State<FeatureErrorBoundary> {
  bool _hasError = false;
  FlutterErrorDetails? _errorDetails;

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildFallbackUI();
    }

    return _ErrorCatcher(
      onError: (FlutterErrorDetails details) {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorDetails = details;
          });
        }
      },
      child: widget.child,
    );
  }

  Widget _buildFallbackUI() {
    return Container(
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // Rose 50
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFCA5A5)), // Rose 300
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
          const SizedBox(height: 16),
          Text(
            '${widget.featureName} encountered an error',
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            _errorDetails?.exceptionAsString() ?? 'Unknown error',
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 13),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _hasError = false;
                _errorDetails = null;
              });
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: const Text('Retry'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF0D9488),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorCatcher extends StatelessWidget {
  final void Function(FlutterErrorDetails) onError;
  final Widget child;

  const _ErrorCatcher({
    required this.onError,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // Schedule the callback for after the current build cycle
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onError(details);
      });
      return const SizedBox.shrink();
    };
    return child;
  }
}
