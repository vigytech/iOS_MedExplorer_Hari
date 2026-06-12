// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasNodeImpl _$$CanvasNodeImplFromJson(Map<String, dynamic> json) =>
    _$CanvasNodeImpl(
      id: json['id'] as String,
      blueprintId: json['blueprintId'] as String,
      realisticAssetPath: json['realisticAssetPath'] as String,
      normalizedX: (json['normalizedX'] as num).toDouble(),
      normalizedY: (json['normalizedY'] as num).toDouble(),
      widthRatio: (json['widthRatio'] as num).toDouble(),
      heightRatio: (json['heightRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$$CanvasNodeImplToJson(_$CanvasNodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blueprintId': instance.blueprintId,
      'realisticAssetPath': instance.realisticAssetPath,
      'normalizedX': instance.normalizedX,
      'normalizedY': instance.normalizedY,
      'widthRatio': instance.widthRatio,
      'heightRatio': instance.heightRatio,
    };
