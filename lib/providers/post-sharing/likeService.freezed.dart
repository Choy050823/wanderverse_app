// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'likeService.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostLikeData {
  bool get isLiked => throw _privateConstructorUsedError;
  int get likesCount => throw _privateConstructorUsedError;

  /// Create a copy of PostLikeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostLikeDataCopyWith<PostLikeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostLikeDataCopyWith<$Res> {
  factory $PostLikeDataCopyWith(
          PostLikeData value, $Res Function(PostLikeData) then) =
      _$PostLikeDataCopyWithImpl<$Res, PostLikeData>;
  @useResult
  $Res call({bool isLiked, int likesCount});
}

/// @nodoc
class _$PostLikeDataCopyWithImpl<$Res, $Val extends PostLikeData>
    implements $PostLikeDataCopyWith<$Res> {
  _$PostLikeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostLikeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLiked = null,
    Object? likesCount = null,
  }) {
    return _then(_value.copyWith(
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostLikeDataImplCopyWith<$Res>
    implements $PostLikeDataCopyWith<$Res> {
  factory _$$PostLikeDataImplCopyWith(
          _$PostLikeDataImpl value, $Res Function(_$PostLikeDataImpl) then) =
      __$$PostLikeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLiked, int likesCount});
}

/// @nodoc
class __$$PostLikeDataImplCopyWithImpl<$Res>
    extends _$PostLikeDataCopyWithImpl<$Res, _$PostLikeDataImpl>
    implements _$$PostLikeDataImplCopyWith<$Res> {
  __$$PostLikeDataImplCopyWithImpl(
      _$PostLikeDataImpl _value, $Res Function(_$PostLikeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostLikeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLiked = null,
    Object? likesCount = null,
  }) {
    return _then(_$PostLikeDataImpl(
      isLiked: null == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$PostLikeDataImpl implements _PostLikeData {
  const _$PostLikeDataImpl({this.isLiked = false, this.likesCount = 0});

  @override
  @JsonKey()
  final bool isLiked;
  @override
  @JsonKey()
  final int likesCount;

  @override
  String toString() {
    return 'PostLikeData(isLiked: $isLiked, likesCount: $likesCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikeDataImpl &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLiked, likesCount);

  /// Create a copy of PostLikeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikeDataImplCopyWith<_$PostLikeDataImpl> get copyWith =>
      __$$PostLikeDataImplCopyWithImpl<_$PostLikeDataImpl>(this, _$identity);
}

abstract class _PostLikeData implements PostLikeData {
  const factory _PostLikeData({final bool isLiked, final int likesCount}) =
      _$PostLikeDataImpl;

  @override
  bool get isLiked;
  @override
  int get likesCount;

  /// Create a copy of PostLikeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostLikeDataImplCopyWith<_$PostLikeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
