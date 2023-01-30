// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReportModel _$ReportModelFromJson(Map<String, dynamic> json) {
  return _ReportModel.fromJson(json);
}

/// @nodoc
mixin _$ReportModel {
  @DateTimeStampConv()
  DateTime? get timestamp => throw _privateConstructorUsedError;
  String? get reportedBy => throw _privateConstructorUsedError;
  String? get reasonWhy => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  ReportStatus? get reportStatus => throw _privateConstructorUsedError;
  ReportType? get reportType => throw _privateConstructorUsedError;
  PostModel? get reportedPost => throw _privateConstructorUsedError;
  UserModel? get reportedUser => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReportModelCopyWith<ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportModelCopyWith<$Res> {
  factory $ReportModelCopyWith(
          ReportModel value, $Res Function(ReportModel) then) =
      _$ReportModelCopyWithImpl<$Res, ReportModel>;
  @useResult
  $Res call(
      {@DateTimeStampConv() DateTime? timestamp,
      String? reportedBy,
      String? reasonWhy,
      String? userName,
      ReportStatus? reportStatus,
      ReportType? reportType,
      PostModel? reportedPost,
      UserModel? reportedUser});

  $PostModelCopyWith<$Res>? get reportedPost;
  $UserModelCopyWith<$Res>? get reportedUser;
}

/// @nodoc
class _$ReportModelCopyWithImpl<$Res, $Val extends ReportModel>
    implements $ReportModelCopyWith<$Res> {
  _$ReportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? reportedBy = freezed,
    Object? reasonWhy = freezed,
    Object? userName = freezed,
    Object? reportStatus = freezed,
    Object? reportType = freezed,
    Object? reportedPost = freezed,
    Object? reportedUser = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reportedBy: freezed == reportedBy
          ? _value.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonWhy: freezed == reasonWhy
          ? _value.reasonWhy
          : reasonWhy // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      reportStatus: freezed == reportStatus
          ? _value.reportStatus
          : reportStatus // ignore: cast_nullable_to_non_nullable
              as ReportStatus?,
      reportType: freezed == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as ReportType?,
      reportedPost: freezed == reportedPost
          ? _value.reportedPost
          : reportedPost // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      reportedUser: freezed == reportedUser
          ? _value.reportedUser
          : reportedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PostModelCopyWith<$Res>? get reportedPost {
    if (_value.reportedPost == null) {
      return null;
    }

    return $PostModelCopyWith<$Res>(_value.reportedPost!, (value) {
      return _then(_value.copyWith(reportedPost: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get reportedUser {
    if (_value.reportedUser == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.reportedUser!, (value) {
      return _then(_value.copyWith(reportedUser: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReportModelCopyWith<$Res>
    implements $ReportModelCopyWith<$Res> {
  factory _$$_ReportModelCopyWith(
          _$_ReportModel value, $Res Function(_$_ReportModel) then) =
      __$$_ReportModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@DateTimeStampConv() DateTime? timestamp,
      String? reportedBy,
      String? reasonWhy,
      String? userName,
      ReportStatus? reportStatus,
      ReportType? reportType,
      PostModel? reportedPost,
      UserModel? reportedUser});

  @override
  $PostModelCopyWith<$Res>? get reportedPost;
  @override
  $UserModelCopyWith<$Res>? get reportedUser;
}

/// @nodoc
class __$$_ReportModelCopyWithImpl<$Res>
    extends _$ReportModelCopyWithImpl<$Res, _$_ReportModel>
    implements _$$_ReportModelCopyWith<$Res> {
  __$$_ReportModelCopyWithImpl(
      _$_ReportModel _value, $Res Function(_$_ReportModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = freezed,
    Object? reportedBy = freezed,
    Object? reasonWhy = freezed,
    Object? userName = freezed,
    Object? reportStatus = freezed,
    Object? reportType = freezed,
    Object? reportedPost = freezed,
    Object? reportedUser = freezed,
  }) {
    return _then(_$_ReportModel(
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      reportedBy: freezed == reportedBy
          ? _value.reportedBy
          : reportedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      reasonWhy: freezed == reasonWhy
          ? _value.reasonWhy
          : reasonWhy // ignore: cast_nullable_to_non_nullable
              as String?,
      userName: freezed == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String?,
      reportStatus: freezed == reportStatus
          ? _value.reportStatus
          : reportStatus // ignore: cast_nullable_to_non_nullable
              as ReportStatus?,
      reportType: freezed == reportType
          ? _value.reportType
          : reportType // ignore: cast_nullable_to_non_nullable
              as ReportType?,
      reportedPost: freezed == reportedPost
          ? _value.reportedPost
          : reportedPost // ignore: cast_nullable_to_non_nullable
              as PostModel?,
      reportedUser: freezed == reportedUser
          ? _value.reportedUser
          : reportedUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_ReportModel implements _ReportModel {
  const _$_ReportModel(
      {@DateTimeStampConv() this.timestamp,
      this.reportedBy,
      this.reasonWhy,
      this.userName,
      this.reportStatus,
      this.reportType,
      this.reportedPost,
      this.reportedUser});

  factory _$_ReportModel.fromJson(Map<String, dynamic> json) =>
      _$$_ReportModelFromJson(json);

  @override
  @DateTimeStampConv()
  final DateTime? timestamp;
  @override
  final String? reportedBy;
  @override
  final String? reasonWhy;
  @override
  final String? userName;
  @override
  final ReportStatus? reportStatus;
  @override
  final ReportType? reportType;
  @override
  final PostModel? reportedPost;
  @override
  final UserModel? reportedUser;

  @override
  String toString() {
    return 'ReportModel(timestamp: $timestamp, reportedBy: $reportedBy, reasonWhy: $reasonWhy, userName: $userName, reportStatus: $reportStatus, reportType: $reportType, reportedPost: $reportedPost, reportedUser: $reportedUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReportModel &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.reportedBy, reportedBy) ||
                other.reportedBy == reportedBy) &&
            (identical(other.reasonWhy, reasonWhy) ||
                other.reasonWhy == reasonWhy) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.reportStatus, reportStatus) ||
                other.reportStatus == reportStatus) &&
            (identical(other.reportType, reportType) ||
                other.reportType == reportType) &&
            (identical(other.reportedPost, reportedPost) ||
                other.reportedPost == reportedPost) &&
            (identical(other.reportedUser, reportedUser) ||
                other.reportedUser == reportedUser));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, timestamp, reportedBy, reasonWhy,
      userName, reportStatus, reportType, reportedPost, reportedUser);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReportModelCopyWith<_$_ReportModel> get copyWith =>
      __$$_ReportModelCopyWithImpl<_$_ReportModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReportModelToJson(
      this,
    );
  }
}

abstract class _ReportModel implements ReportModel {
  const factory _ReportModel(
      {@DateTimeStampConv() final DateTime? timestamp,
      final String? reportedBy,
      final String? reasonWhy,
      final String? userName,
      final ReportStatus? reportStatus,
      final ReportType? reportType,
      final PostModel? reportedPost,
      final UserModel? reportedUser}) = _$_ReportModel;

  factory _ReportModel.fromJson(Map<String, dynamic> json) =
      _$_ReportModel.fromJson;

  @override
  @DateTimeStampConv()
  DateTime? get timestamp;
  @override
  String? get reportedBy;
  @override
  String? get reasonWhy;
  @override
  String? get userName;
  @override
  ReportStatus? get reportStatus;
  @override
  ReportType? get reportType;
  @override
  PostModel? get reportedPost;
  @override
  UserModel? get reportedUser;
  @override
  @JsonKey(ignore: true)
  _$$_ReportModelCopyWith<_$_ReportModel> get copyWith =>
      throw _privateConstructorUsedError;
}
