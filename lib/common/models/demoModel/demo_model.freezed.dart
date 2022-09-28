// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'demo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DemoModel _$DemoModelFromJson(Map<String, dynamic> json) {
  return _DemoModel.fromJson(json);
}

/// @nodoc
mixin _$DemoModel {
  dynamic get ID => throw _privateConstructorUsedError;
  dynamic get PointID => throw _privateConstructorUsedError;
  dynamic get CityName => throw _privateConstructorUsedError;
  dynamic get Time => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)
        demo_model,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)?
        demo_model,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)?
        demo_model,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DemoModel value) demo_model,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DemoModel value)? demo_model,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DemoModel value)? demo_model,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoModelCopyWith<DemoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoModelCopyWith<$Res> {
  factory $DemoModelCopyWith(DemoModel value, $Res Function(DemoModel) then) =
      _$DemoModelCopyWithImpl<$Res>;
  $Res call({dynamic ID, dynamic PointID, dynamic CityName, dynamic Time});
}

/// @nodoc
class _$DemoModelCopyWithImpl<$Res> implements $DemoModelCopyWith<$Res> {
  _$DemoModelCopyWithImpl(this._value, this._then);

  final DemoModel _value;
  // ignore: unused_field
  final $Res Function(DemoModel) _then;

  @override
  $Res call({
    Object? ID = freezed,
    Object? PointID = freezed,
    Object? CityName = freezed,
    Object? Time = freezed,
  }) {
    return _then(_value.copyWith(
      ID: ID == freezed
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PointID: PointID == freezed
          ? _value.PointID
          : PointID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CityName: CityName == freezed
          ? _value.CityName
          : CityName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$$_DemoModelCopyWith<$Res> implements $DemoModelCopyWith<$Res> {
  factory _$$_DemoModelCopyWith(
          _$_DemoModel value, $Res Function(_$_DemoModel) then) =
      __$$_DemoModelCopyWithImpl<$Res>;
  @override
  $Res call({dynamic ID, dynamic PointID, dynamic CityName, dynamic Time});
}

/// @nodoc
class __$$_DemoModelCopyWithImpl<$Res> extends _$DemoModelCopyWithImpl<$Res>
    implements _$$_DemoModelCopyWith<$Res> {
  __$$_DemoModelCopyWithImpl(
      _$_DemoModel _value, $Res Function(_$_DemoModel) _then)
      : super(_value, (v) => _then(v as _$_DemoModel));

  @override
  _$_DemoModel get _value => super._value as _$_DemoModel;

  @override
  $Res call({
    Object? ID = freezed,
    Object? PointID = freezed,
    Object? CityName = freezed,
    Object? Time = freezed,
  }) {
    return _then(_$_DemoModel(
      ID: ID == freezed
          ? _value.ID
          : ID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      PointID: PointID == freezed
          ? _value.PointID
          : PointID // ignore: cast_nullable_to_non_nullable
              as dynamic,
      CityName: CityName == freezed
          ? _value.CityName
          : CityName // ignore: cast_nullable_to_non_nullable
              as dynamic,
      Time: Time == freezed
          ? _value.Time
          : Time // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DemoModel implements _DemoModel {
  const _$_DemoModel(
      {required this.ID,
      required this.PointID,
      required this.CityName,
      required this.Time});

  factory _$_DemoModel.fromJson(Map<String, dynamic> json) =>
      _$$_DemoModelFromJson(json);

  @override
  final dynamic ID;
  @override
  final dynamic PointID;
  @override
  final dynamic CityName;
  @override
  final dynamic Time;

  @override
  String toString() {
    return 'DemoModel.demo_model(ID: $ID, PointID: $PointID, CityName: $CityName, Time: $Time)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DemoModel &&
            const DeepCollectionEquality().equals(other.ID, ID) &&
            const DeepCollectionEquality().equals(other.PointID, PointID) &&
            const DeepCollectionEquality().equals(other.CityName, CityName) &&
            const DeepCollectionEquality().equals(other.Time, Time));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(ID),
      const DeepCollectionEquality().hash(PointID),
      const DeepCollectionEquality().hash(CityName),
      const DeepCollectionEquality().hash(Time));

  @JsonKey(ignore: true)
  @override
  _$$_DemoModelCopyWith<_$_DemoModel> get copyWith =>
      __$$_DemoModelCopyWithImpl<_$_DemoModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)
        demo_model,
  }) {
    return demo_model(ID, PointID, CityName, Time);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)?
        demo_model,
  }) {
    return demo_model?.call(ID, PointID, CityName, Time);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            dynamic ID, dynamic PointID, dynamic CityName, dynamic Time)?
        demo_model,
    required TResult orElse(),
  }) {
    if (demo_model != null) {
      return demo_model(ID, PointID, CityName, Time);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_DemoModel value) demo_model,
  }) {
    return demo_model(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_DemoModel value)? demo_model,
  }) {
    return demo_model?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_DemoModel value)? demo_model,
    required TResult orElse(),
  }) {
    if (demo_model != null) {
      return demo_model(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DemoModelToJson(
      this,
    );
  }
}

abstract class _DemoModel implements DemoModel {
  const factory _DemoModel(
      {required final dynamic ID,
      required final dynamic PointID,
      required final dynamic CityName,
      required final dynamic Time}) = _$_DemoModel;

  factory _DemoModel.fromJson(Map<String, dynamic> json) =
      _$_DemoModel.fromJson;

  @override
  dynamic get ID;
  @override
  dynamic get PointID;
  @override
  dynamic get CityName;
  @override
  dynamic get Time;
  @override
  @JsonKey(ignore: true)
  _$$_DemoModelCopyWith<_$_DemoModel> get copyWith =>
      throw _privateConstructorUsedError;
}
