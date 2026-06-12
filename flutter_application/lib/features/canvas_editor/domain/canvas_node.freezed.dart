// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'canvas_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CanvasNode _$CanvasNodeFromJson(Map<String, dynamic> json) {
  return _CanvasNode.fromJson(json);
}

/// @nodoc
mixin _$CanvasNode {
  String get id => throw _privateConstructorUsedError;
  String get blueprintId => throw _privateConstructorUsedError;
  String get realisticAssetPath => throw _privateConstructorUsedError;
  double get normalizedX => throw _privateConstructorUsedError;
  double get normalizedY => throw _privateConstructorUsedError;
  double get widthRatio => throw _privateConstructorUsedError;
  double get heightRatio => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CanvasNodeCopyWith<CanvasNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasNodeCopyWith<$Res> {
  factory $CanvasNodeCopyWith(
          CanvasNode value, $Res Function(CanvasNode) then) =
      _$CanvasNodeCopyWithImpl<$Res, CanvasNode>;
  @useResult
  $Res call(
      {String id,
      String blueprintId,
      String realisticAssetPath,
      double normalizedX,
      double normalizedY,
      double widthRatio,
      double heightRatio});
}

/// @nodoc
class _$CanvasNodeCopyWithImpl<$Res, $Val extends CanvasNode>
    implements $CanvasNodeCopyWith<$Res> {
  _$CanvasNodeCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? blueprintId = null,
    Object? realisticAssetPath = null,
    Object? normalizedX = null,
    Object? normalizedY = null,
    Object? widthRatio = null,
    Object? heightRatio = null,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as String,
      blueprintId:
          null == blueprintId ? _value.blueprintId : blueprintId as String,
      realisticAssetPath: null == realisticAssetPath
          ? _value.realisticAssetPath
          : realisticAssetPath as String,
      normalizedX:
          null == normalizedX ? _value.normalizedX : normalizedX as double,
      normalizedY:
          null == normalizedY ? _value.normalizedY : normalizedY as double,
      widthRatio:
          null == widthRatio ? _value.widthRatio : widthRatio as double,
      heightRatio:
          null == heightRatio ? _value.heightRatio : heightRatio as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CanvasNodeImplCopyWith<$Res>
    implements $CanvasNodeCopyWith<$Res> {
  factory _$$CanvasNodeImplCopyWith(
          _$CanvasNodeImpl value, $Res Function(_$CanvasNodeImpl) then) =
      __$$CanvasNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String blueprintId,
      String realisticAssetPath,
      double normalizedX,
      double normalizedY,
      double widthRatio,
      double heightRatio});
}

/// @nodoc
class __$$CanvasNodeImplCopyWithImpl<$Res>
    extends _$CanvasNodeCopyWithImpl<$Res, _$CanvasNodeImpl>
    implements _$$CanvasNodeImplCopyWith<$Res> {
  __$$CanvasNodeImplCopyWithImpl(
      _$CanvasNodeImpl _value, $Res Function(_$CanvasNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? blueprintId = null,
    Object? realisticAssetPath = null,
    Object? normalizedX = null,
    Object? normalizedY = null,
    Object? widthRatio = null,
    Object? heightRatio = null,
  }) {
    return _then(_$CanvasNodeImpl(
      id: null == id ? _value.id : id as String,
      blueprintId:
          null == blueprintId ? _value.blueprintId : blueprintId as String,
      realisticAssetPath: null == realisticAssetPath
          ? _value.realisticAssetPath
          : realisticAssetPath as String,
      normalizedX:
          null == normalizedX ? _value.normalizedX : normalizedX as double,
      normalizedY:
          null == normalizedY ? _value.normalizedY : normalizedY as double,
      widthRatio:
          null == widthRatio ? _value.widthRatio : widthRatio as double,
      heightRatio:
          null == heightRatio ? _value.heightRatio : heightRatio as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasNodeImpl implements _CanvasNode {
  const _$CanvasNodeImpl(
      {required this.id,
      required this.blueprintId,
      required this.realisticAssetPath,
      required this.normalizedX,
      required this.normalizedY,
      required this.widthRatio,
      required this.heightRatio});

  factory _$CanvasNodeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasNodeImplFromJson(json);

  @override
  final String id;
  @override
  final String blueprintId;
  @override
  final String realisticAssetPath;
  @override
  final double normalizedX;
  @override
  final double normalizedY;
  @override
  final double widthRatio;
  @override
  final double heightRatio;

  @override
  String toString() {
    return 'CanvasNode(id: $id, blueprintId: $blueprintId, realisticAssetPath: $realisticAssetPath, normalizedX: $normalizedX, normalizedY: $normalizedY, widthRatio: $widthRatio, heightRatio: $heightRatio)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.blueprintId, blueprintId) ||
                other.blueprintId == blueprintId) &&
            (identical(other.realisticAssetPath, realisticAssetPath) ||
                other.realisticAssetPath == realisticAssetPath) &&
            (identical(other.normalizedX, normalizedX) ||
                other.normalizedX == normalizedX) &&
            (identical(other.normalizedY, normalizedY) ||
                other.normalizedY == normalizedY) &&
            (identical(other.widthRatio, widthRatio) ||
                other.widthRatio == widthRatio) &&
            (identical(other.heightRatio, heightRatio) ||
                other.heightRatio == heightRatio));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, blueprintId,
      realisticAssetPath, normalizedX, normalizedY, widthRatio, heightRatio);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasNodeImplCopyWith<_$CanvasNodeImpl> get copyWith =>
      __$$CanvasNodeImplCopyWithImpl<_$CanvasNodeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasNodeImplToJson(this);
  }
}

abstract class _CanvasNode implements CanvasNode {
  const factory _CanvasNode(
      {required final String id,
      required final String blueprintId,
      required final String realisticAssetPath,
      required final double normalizedX,
      required final double normalizedY,
      required final double widthRatio,
      required final double heightRatio}) = _$CanvasNodeImpl;

  factory _CanvasNode.fromJson(Map<String, dynamic> json) =
      _$CanvasNodeImpl.fromJson;

  @override
  String get id;
  @override
  String get blueprintId;
  @override
  String get realisticAssetPath;
  @override
  double get normalizedX;
  @override
  double get normalizedY;
  @override
  double get widthRatio;
  @override
  double get heightRatio;
  @override
  @JsonKey(ignore: true)
  _$$CanvasNodeImplCopyWith<_$CanvasNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
