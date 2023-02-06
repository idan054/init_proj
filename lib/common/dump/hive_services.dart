import 'package:hive/hive.dart';


class HiveServices {
  static var uniBox = Hive.box('uniBox');
  /// Box values:
  //> currUser
  //> ChatsIdsList
  //> cache${modelType.name}List (x4)

  /// Box values:

  static Future openBoxes() async {
    await Hive.openBox('uniBox');
    // await Hive.openBox<List<PostModel>>('postsBox');
  }

  static Future clearAllBoxes() async {
    await Hive.box('uniBox').clear();
  }

}

//>--------------------------------------------------

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
