import 'package:example/common/extensions/context_extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/service/Hive/timestamp_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/post/post_model.dart';

class HiveServices {
  static var uniBox = Hive.box('uniBox');
  /// Box values:
  //> currUser

  static var postsBox = Hive.box('postsBox');
  /// Box values:
  //> cachePostsList

  static Future openBoxes() async {
    await Hive.openBox('uniBox');
    await Hive.openBox<List<PostModel>>('postsBox');
  }

  static Future clearAllBoxes() async {
    await Hive.box('uniBox').clear();
    await Hive.box('postsBox').clear();
  }

  //~ CurrUser:
  Future<bool> getCurrUserFromCache(BuildContext context) async {
    print('START: getCurrUserFromCache()');
    try {
      var currUser = uniBox.get('currUser');
      print('currUser ${currUser}');
      context.uniProvider.updateUser(currUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  void saveCurrUserToCache(BuildContext context, UserModel currUser) async {
    context.uniProvider.updateUser(currUser);
    HiveServices.uniBox.put('currUser', currUser);
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
