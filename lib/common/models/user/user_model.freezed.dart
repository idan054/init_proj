// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String? get uid => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get fcm => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  int get unreadCounter => throw _privateConstructorUsedError;
  int get unreadNotificationCounter => throw _privateConstructorUsedError;
  GenderTypes? get gender => throw _privateConstructorUsedError;
  UserTypes? get userType => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;
  bool get isOnline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String? uid,
      String? name,
      String? email,
      String? bio,
      String? fcm,
      int? age,
      String? photoUrl,
      int unreadCounter,
      int unreadNotificationCounter,
      GenderTypes? gender,
      UserTypes? userType,
      List<String> tags,
      List<String> blockedUsers,
      bool isOnline});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? bio = freezed,
    Object? fcm = freezed,
    Object? age = freezed,
    Object? photoUrl = freezed,
    Object? unreadCounter = null,
    Object? unreadNotificationCounter = null,
    Object? gender = freezed,
    Object? userType = freezed,
    Object? tags = null,
    Object? blockedUsers = null,
    Object? isOnline = null,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      fcm: freezed == fcm
          ? _value.fcm
          : fcm // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCounter: null == unreadCounter
          ? _value.unreadCounter
          : unreadCounter // ignore: cast_nullable_to_non_nullable
              as int,
      unreadNotificationCounter: null == unreadNotificationCounter
          ? _value.unreadNotificationCounter
          : unreadNotificationCounter // ignore: cast_nullable_to_non_nullable
              as int,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as GenderTypes?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as UserTypes?,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockedUsers: null == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$_UserModelCopyWith(
          _$_UserModel value, $Res Function(_$_UserModel) then) =
      __$$_UserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? name,
      String? email,
      String? bio,
      String? fcm,
      int? age,
      String? photoUrl,
      int unreadCounter,
      int unreadNotificationCounter,
      GenderTypes? gender,
      UserTypes? userType,
      List<String> tags,
      List<String> blockedUsers,
      bool isOnline});
}

/// @nodoc
class __$$_UserModelCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$_UserModel>
    implements _$$_UserModelCopyWith<$Res> {
  __$$_UserModelCopyWithImpl(
      _$_UserModel _value, $Res Function(_$_UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? bio = freezed,
    Object? fcm = freezed,
    Object? age = freezed,
    Object? photoUrl = freezed,
    Object? unreadCounter = null,
    Object? unreadNotificationCounter = null,
    Object? gender = freezed,
    Object? userType = freezed,
    Object? tags = null,
    Object? blockedUsers = null,
    Object? isOnline = null,
  }) {
    return _then(_$_UserModel(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      fcm: freezed == fcm
          ? _value.fcm
          : fcm // ignore: cast_nullable_to_non_nullable
              as String?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      unreadCounter: null == unreadCounter
          ? _value.unreadCounter
          : unreadCounter // ignore: cast_nullable_to_non_nullable
              as int,
      unreadNotificationCounter: null == unreadNotificationCounter
          ? _value.unreadNotificationCounter
          : unreadNotificationCounter // ignore: cast_nullable_to_non_nullable
              as int,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as GenderTypes?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as UserTypes?,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      blockedUsers: null == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isOnline: null == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_UserModel implements _UserModel {
  const _$_UserModel(
      {this.uid,
      this.name,
      this.email,
      this.bio,
      this.fcm,
      this.age,
      this.photoUrl,
      this.unreadCounter = 0,
      this.unreadNotificationCounter = 0,
      this.gender,
      this.userType = UserTypes.normal,
      final List<String> tags = const [],
      final List<String> blockedUsers = const [],
      this.isOnline = false})
      : _tags = tags,
        _blockedUsers = blockedUsers;

  factory _$_UserModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserModelFromJson(json);

  @override
  final String? uid;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? bio;
  @override
  final String? fcm;
  @override
  final int? age;
  @override
  final String? photoUrl;
  @override
  @JsonKey()
  final int unreadCounter;
  @override
  @JsonKey()
  final int unreadNotificationCounter;
  @override
  final GenderTypes? gender;
  @override
  @JsonKey()
  final UserTypes? userType;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _blockedUsers;
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  @override
  @JsonKey()
  final bool isOnline;

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, email: $email, bio: $bio, fcm: $fcm, age: $age, photoUrl: $photoUrl, unreadCounter: $unreadCounter, unreadNotificationCounter: $unreadNotificationCounter, gender: $gender, userType: $userType, tags: $tags, blockedUsers: $blockedUsers, isOnline: $isOnline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserModel &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.fcm, fcm) || other.fcm == fcm) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.unreadCounter, unreadCounter) ||
                other.unreadCounter == unreadCounter) &&
            (identical(other.unreadNotificationCounter,
                    unreadNotificationCounter) ||
                other.unreadNotificationCounter == unreadNotificationCounter) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._blockedUsers, _blockedUsers) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      name,
      email,
      bio,
      fcm,
      age,
      photoUrl,
      unreadCounter,
      unreadNotificationCounter,
      gender,
      userType,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_blockedUsers),
      isOnline);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      __$$_UserModelCopyWithImpl<_$_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserModelToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {final String? uid,
      final String? name,
      final String? email,
      final String? bio,
      final String? fcm,
      final int? age,
      final String? photoUrl,
      final int unreadCounter,
      final int unreadNotificationCounter,
      final GenderTypes? gender,
      final UserTypes? userType,
      final List<String> tags,
      final List<String> blockedUsers,
      final bool isOnline}) = _$_UserModel;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$_UserModel.fromJson;

  @override
  String? get uid;
  @override
  String? get name;
  @override
  String? get email;
  @override
  String? get bio;
  @override
  String? get fcm;
  @override
  int? get age;
  @override
  String? get photoUrl;
  @override
  int get unreadCounter;
  @override
  int get unreadNotificationCounter;
  @override
  GenderTypes? get gender;
  @override
  UserTypes? get userType;
  @override
  List<String> get tags;
  @override
  List<String> get blockedUsers;
  @override
  bool get isOnline;
  @override
  @JsonKey(ignore: true)
  _$$_UserModelCopyWith<_$_UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
