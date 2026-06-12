import 'package:freezed_annotation/freezed_annotation.dart';

part 'canvas_node.freezed.dart';
part 'canvas_node.g.dart';

@freezed
class CanvasNode with _$CanvasNode {
  const factory CanvasNode({
    required String id,
    required String blueprintId,
    required String realisticAssetPath,
    required double normalizedX,
    required double normalizedY,
    required double widthRatio,
    required double heightRatio,
  }) = _CanvasNode;

  factory CanvasNode.fromJson(Map<String, dynamic> json) => _$CanvasNodeFromJson(json);
}