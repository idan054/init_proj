// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sort_feed_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SortFeedModel _$SortFeedModelFromJson(Map<String, dynamic> json) {
  return _SortFeedModel.fromJson(json);
}

/// @nodoc
mixin _$SortFeedModel {
  String get title => throw _privateConstructorUsedError;
  String get desc => throw _privateConstructorUsedError;
  SvgGenImage get svg => throw _privateConstructorUsedError;
  SvgGenImage get solidSvg => throw _privateConstructorUsedError;
  FilterTypes get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SortFeedModelCopyWith<SortFeedModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SortFeedModelCopyWith<$Res> {
  factory $SortFeedModelCopyWith(
          SortFeedModel value, $Res Function(SortFeedModel) then) =
      _$SortFeedModelCopyWithImpl<$Res, SortFeedModel>;
  @useResult
  $Res call(
      {String title,
      String desc,
      SvgGenImage svg,
      SvgGenImage solidSvg,
      FilterTypes type});
}

/// @nodoc
class _$SortFeedModelCopyWithImpl<$Res, $Val extends SortFeedModel>
    implements $SortFeedModelCopyWith<$Res> {
  _$SortFeedModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
    Object? svg = freezed,
    Object? solidSvg = freezed,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      svg: freezed == svg
          ? _value.svg
          : svg // ignore: cast_nullable_to_non_nullable
              as SvgGenImage,
      solidSvg: freezed == solidSvg
          ? _value.solidSvg
          : solidSvg // ignore: cast_nullable_to_non_nullable
              as SvgGenImage,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterTypes,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SortFeedModelCopyWith<$Res>
    implements $SortFeedModelCopyWith<$Res> {
  factory _$$_SortFeedModelCopyWith(
          _$_SortFeedModel value, $Res Function(_$_SortFeedModel) then) =
      __$$_SortFeedModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String desc,
      SvgGenImage svg,
      SvgGenImage solidSvg,
      FilterTypes type});
}

/// @nodoc
class __$$_SortFeedModelCopyWithImpl<$Res>
    extends _$SortFeedModelCopyWithImpl<$Res, _$_SortFeedModel>
    implements _$$_SortFeedModelCopyWith<$Res> {
  __$$_SortFeedModelCopyWithImpl(
      _$_SortFeedModel _value, $Res Function(_$_SortFeedModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? desc = null,
    Object? svg = freezed,
    Object? solidSvg = freezed,
    Object? type = null,
  }) {
    return _then(_$_SortFeedModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      svg: freezed == svg
          ? _value.svg
          : svg // ignore: cast_nullable_to_non_nullable
              as SvgGenImage,
      solidSvg: freezed == solidSvg
          ? _value.solidSvg
          : solidSvg // ignore: cast_nullable_to_non_nullable
              as SvgGenImage,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as FilterTypes,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_SortFeedModel implements _SortFeedModel {
  const _$_SortFeedModel(
      {required this.title,
      required this.desc,
      required this.svg,
      required this.solidSvg,
      required this.type});

  factory _$_SortFeedModel.fromJson(Map<String, dynamic> json) =>
      _$$_SortFeedModelFromJson(json);

  @override
  final String title;
  @override
  final String desc;
  @override
  final SvgGenImage svg;
  @override
  final SvgGenImage solidSvg;
  @override
  final FilterTypes type;

  @override
  String toString() {
    return 'SortFeedModel(title: $title, desc: $desc, svg: $svg, solidSvg: $solidSvg, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SortFeedModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            const DeepCollectionEquality().equals(other.svg, svg) &&
            const DeepCollectionEquality().equals(other.solidSvg, solidSvg) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      desc,
      const DeepCollectionEquality().hash(svg),
      const DeepCollectionEquality().hash(solidSvg),
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SortFeedModelCopyWith<_$_SortFeedModel> get copyWith =>
      __$$_SortFeedModelCopyWithImpl<_$_SortFeedModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SortFeedModelToJson(
      this,
    );
  }
}

abstract class _SortFeedModel implements SortFeedModel {
  const factory _SortFeedModel(
      {required final String title,
      required final String desc,
      required final SvgGenImage svg,
      required final SvgGenImage solidSvg,
      required final FilterTypes type}) = _$_SortFeedModel;

  factory _SortFeedModel.fromJson(Map<String, dynamic> json) =
      _$_SortFeedModel.fromJson;

  @override
  String get title;
  @override
  String get desc;
  @override
  SvgGenImage get svg;
  @override
  SvgGenImage get solidSvg;
  @override
  FilterTypes get type;
  @override
  @JsonKey(ignore: true)
  _$$_SortFeedModelCopyWith<_$_SortFeedModel> get copyWith =>
      throw _privateConstructorUsedError;
}
