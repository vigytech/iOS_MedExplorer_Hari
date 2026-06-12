import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/canvas_node.dart';
import 'package:uuid/uuid.dart';

part 'canvas_state_provider.g.dart';

@riverpod
class CanvasNodesNotifier extends _$CanvasNodesNotifier {
  final _uuid = const Uuid();

  @override
  List<CanvasNode> build() {
    return []; // Canvas starts empty
  }

  void addNodeFromDrop({
    required String blueprintId,
    required String realisticAssetPath,
    required double normX,
    required double normY,
    required double widthRatio,
    required double heightRatio,
  }) {
    final newNode = CanvasNode(
      id: _uuid.v4(),
      blueprintId: blueprintId,
      realisticAssetPath: realisticAssetPath,
      normalizedX: normX,
      normalizedY: normY,
      widthRatio: widthRatio,
      heightRatio: heightRatio,
    );
    state = [...state, newNode];
  }

  void clearCanvas() {
    state = [];
  }

  /// Update a node's normalized position after a drag-move gesture completes.
  void updateNodePosition(String nodeId, double normX, double normY) {
    state = [
      for (final node in state)
        if (node.id == nodeId)
          node.copyWith(normalizedX: normX, normalizedY: normY)
        else
          node,
    ];
  }

  /// Update a node's size ratios after a resize gesture completes.
  void updateNodeSize(String nodeId, double widthRatio, double heightRatio) {
    state = [
      for (final node in state)
        if (node.id == nodeId)
          node.copyWith(widthRatio: widthRatio, heightRatio: heightRatio)
        else
          node,
    ];
  }

  /// Remove a specific node from the canvas.
  void removeNode(String nodeId) {
    state = state.where((node) => node.id != nodeId).toList();
  }
}