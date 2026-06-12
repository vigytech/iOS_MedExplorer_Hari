import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_blueprint.freezed.dart';
part 'device_blueprint.g.dart';

@freezed
class DeviceBlueprint with _$DeviceBlueprint {
  const factory DeviceBlueprint({
    required String id,
    required String name,
    required String category,
    required String iconPath,
    required String realisticPath,
    required double defaultWidthRatio,
    required double defaultHeightRatio,
  }) = _DeviceBlueprint;

  factory DeviceBlueprint.fromJson(Map<String, dynamic> json) => _$DeviceBlueprintFromJson(json);
}