// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_blueprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceBlueprintImpl _$$DeviceBlueprintImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceBlueprintImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      iconPath: json['iconPath'] as String,
      realisticPath: json['realisticPath'] as String,
      defaultWidthRatio: (json['defaultWidthRatio'] as num).toDouble(),
      defaultHeightRatio: (json['defaultHeightRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$$DeviceBlueprintImplToJson(
        _$DeviceBlueprintImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'iconPath': instance.iconPath,
      'realisticPath': instance.realisticPath,
      'defaultWidthRatio': instance.defaultWidthRatio,
      'defaultHeightRatio': instance.defaultHeightRatio,
    };
