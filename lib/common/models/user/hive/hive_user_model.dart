import 'package:hive/hive.dart';

import '../../convertors.dart';
import '../user_model.dart';

part 'hive_user_model.g.dart';

@HiveType(typeId: 1)
enum GenderTypes {
  @HiveField(0) boy,
  @HiveField(1) girl,
  @HiveField(2) lgbt }

@HiveType(typeId: 2)
class UserModelHive {
  @HiveField(0) String? name;
  @HiveField(1) String? email;
  @HiveField(2) String? uid;
  @HiveField(3) int? age;
  @HiveField(4) String? photoUrl;
  @HiveField(5) GenderTypes? gender;
  @HiveField(6) @DateTimeStampConv() DateTime? birthday;
  UserModelHive(
      {this.email, this.name, this.photoUrl, this.age, this.uid, this.birthday, this.gender});

  UserModelHive toHive(UserModel user) => UserModelHive(
    birthday: user.birthday,
    email: user.email,
    uid: user.uid,
    photoUrl: user.photoUrl,
    name: user.name,
    age: user.age,
    gender: user.gender,
  );

  UserModel fromHive(UserModelHive user) => UserModel(
    birthday: user.birthday,
    email: user.email,
    uid: user.uid,
    photoUrl: user.photoUrl,
    name: user.name,
    age: user.age,
    gender: user.gender,
  );
}


