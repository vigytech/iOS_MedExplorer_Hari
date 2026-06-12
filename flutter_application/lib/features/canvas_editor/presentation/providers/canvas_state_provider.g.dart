// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: invalid_use_of_internal_member

part of 'canvas_state_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canvasNodesNotifierHash() =>
    r'canvas_nodes_notifier_hash';

/// See also [CanvasNodesNotifier].
@ProviderFor(CanvasNodesNotifier)
final canvasNodesNotifierProvider =
    AutoDisposeNotifierProvider<CanvasNodesNotifier, List<CanvasNode>>.internal(
  CanvasNodesNotifier.new,
  name: r'canvasNodesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$canvasNodesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CanvasNodesNotifier = AutoDisposeNotifier<List<CanvasNode>>;
