// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_blueprint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeviceBlueprint _$DeviceBlueprintFromJson(Map<String, dynamic> json) {
  return _DeviceBlueprint.fromJson(json);
}

/// @nodoc
mixin _$DeviceBlueprint {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  String get realisticPath => throw _privateConstructorUsedError;
  double get defaultWidthRatio => throw _privateConstructorUsedError;
  double get defaultHeightRatio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeviceBlueprintCopyWith<DeviceBlueprint> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeviceBlueprintCopyWith<$Res> {
  factory $DeviceBlueprintCopyWith(
          DeviceBlueprint value, $Res Function(DeviceBlueprint) then) =
      _$DeviceBlueprintCopyWithImpl<$Res, DeviceBlueprint>;
  @useResult
  $Res call(
      {String id,
      String name,
      String category,
      String iconPath,
      String realisticPath,
      double defaultWidthRatio,
      double defaultHeightRatio});
}

/// @nodoc
class _$DeviceBlueprintCopyWithImpl<$Res, $Val extends DeviceBlueprint>
    implements $DeviceBlueprintCopyWith<$Res> {
  _$DeviceBlueprintCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconPath = null,
    Object? realisticPath = null,
    Object? defaultWidthRatio = null,
    Object? defaultHeightRatio = null,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as String,
      name: null == name ? _value.name : name as String,
      category: null == category ? _value.category : category as String,
      iconPath: null == iconPath ? _value.iconPath : iconPath as String,
      realisticPath: null == realisticPath
          ? _value.realisticPath
          : realisticPath as String,
      defaultWidthRatio: null == defaultWidthRatio
          ? _value.defaultWidthRatio
          : defaultWidthRatio as double,
      defaultHeightRatio: null == defaultHeightRatio
          ? _value.defaultHeightRatio
          : defaultHeightRatio as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeviceBlueprintImplCopyWith<$Res>
    implements $DeviceBlueprintCopyWith<$Res> {
  factory _$$DeviceBlueprintImplCopyWith(_$DeviceBlueprintImpl value,
          $Res Function(_$DeviceBlueprintImpl) then) =
      __$$DeviceBlueprintImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String category,
      String iconPath,
      String realisticPath,
      double defaultWidthRatio,
      double defaultHeightRatio});
}

/// @nodoc
class __$$DeviceBlueprintImplCopyWithImpl<$Res>
    extends _$DeviceBlueprintCopyWithImpl<$Res, _$DeviceBlueprintImpl>
    implements _$$DeviceBlueprintImplCopyWith<$Res> {
  __$$DeviceBlueprintImplCopyWithImpl(
      _$DeviceBlueprintImpl _value, $Res Function(_$DeviceBlueprintImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? iconPath = null,
    Object? realisticPath = null,
    Object? defaultWidthRatio = null,
    Object? defaultHeightRatio = null,
  }) {
    return _then(_$DeviceBlueprintImpl(
      id: null == id ? _value.id : id as String,
      name: null == name ? _value.name : name as String,
      category: null == category ? _value.category : category as String,
      iconPath: null == iconPath ? _value.iconPath : iconPath as String,
      realisticPath: null == realisticPath
          ? _value.realisticPath
          : realisticPath as String,
      defaultWidthRatio: null == defaultWidthRatio
          ? _value.defaultWidthRatio
          : defaultWidthRatio as double,
      defaultHeightRatio: null == defaultHeightRatio
          ? _value.defaultHeightRatio
          : defaultHeightRatio as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeviceBlueprintImpl implements _DeviceBlueprint {
  const _$DeviceBlueprintImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.iconPath,
      required this.realisticPath,
      required this.defaultWidthRatio,
      required this.defaultHeightRatio});

  factory _$DeviceBlueprintImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeviceBlueprintImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String iconPath;
  @override
  final String realisticPath;
  @override
  final double defaultWidthRatio;
  @override
  final double defaultHeightRatio;

  @override
  String toString() {
    return 'DeviceBlueprint(id: $id, name: $name, category: $category, iconPath: $iconPath, realisticPath: $realisticPath, defaultWidthRatio: $defaultWidthRatio, defaultHeightRatio: $defaultHeightRatio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeviceBlueprintImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.realisticPath, realisticPath) ||
                other.realisticPath == realisticPath) &&
            (identical(other.defaultWidthRatio, defaultWidthRatio) ||
                other.defaultWidthRatio == defaultWidthRatio) &&
            (identical(other.defaultHeightRatio, defaultHeightRatio) ||
                other.defaultHeightRatio == defaultHeightRatio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, iconPath,
      realisticPath, defaultWidthRatio, defaultHeightRatio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DeviceBlueprintImplCopyWith<_$DeviceBlueprintImpl> get copyWith =>
      __$$DeviceBlueprintImplCopyWithImpl<_$DeviceBlueprintImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeviceBlueprintImplToJson(this);
  }
}

abstract class _DeviceBlueprint implements DeviceBlueprint {
  const factory _DeviceBlueprint(
      {required final String id,
      required final String name,
      required final String category,
      required final String iconPath,
      required final String realisticPath,
      required final double defaultWidthRatio,
      required final double defaultHeightRatio}) = _$DeviceBlueprintImpl;

  factory _DeviceBlueprint.fromJson(Map<String, dynamic> json) =
      _$DeviceBlueprintImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get iconPath;
  @override
  String get realisticPath;
  @override
  double get defaultWidthRatio;
  @override
  double get defaultHeightRatio;
  @override
  @JsonKey(ignore: true)
  _$$DeviceBlueprintImplCopyWith<_$DeviceBlueprintImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
