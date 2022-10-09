import 'package:hive/hive.dart';

// Official: https://pub.dev/packages/hive
//~ Hive Usage:
//> Simple:
// var box = Hive.box('myBox');
// box.put('name', 'David');
// var name = box.get('name');
// print('Name: $name');

//> Advance: Create a box collection (Database of posts, chats..)
// final collection = await BoxCollection.open(
// 'MyFirstFluffyBox', // Name of your database
//     {'cats', 'dogs'}, // Names of your boxes
// path: './', // Path where to store your boxes (Only used in Flutter / Dart IO)
// key: HiveCipher(), // Key to encrypt your boxes (Only used in Flutter / Dart IO)
// );

var uniBox = Hive.box('currUser');
// final uniBox = await Hive.openBox('uniBox');
// uniBox.put('currUser', 'currUser.toJson()');
// var currUser = uniBox.get('currUser', 'currUser.fromJson()');
