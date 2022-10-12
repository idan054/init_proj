import 'package:example/common/extensions/context_extensions.dart';
import 'package:example/common/models/post/hive/hive_post_model.dart';
import 'package:example/common/models/user/hive/hive_user_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Hive/timestamp_convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../models/chat/chat_model.dart';
import '../../models/chat/hive/hive_chat_model.dart';
import '../../models/message/hive/hive_message_model.dart';
import '../../models/message/message_model.dart';
import '../../models/post/post_model.dart';

class HiveServices {
  static var uniBox = Hive.box('uniBox');
  /// Box values:
  //> currUser
  //> ChatsIdsList

  static var postsBox = Hive.box('postsBox');
  /// Box values:
  //> cachePostsList

  static Future openBoxes() async {
    await Hive.openBox('uniBox');
    await Hive.openBox('postsBox');
    // await Hive.openBox<List<PostModel>>('postsBox');
  }

  static Future clearAllBoxes() async {
    await Hive.box('uniBox').clear();
    await Hive.box('postsBox').clear();
  }

  static List updateCacheDocsList(ModelTypes modelType, {
    required bool latest,
    required List cacheDocsList,
    required List newDocsList}){

    var readyHiveList;
    var noDuplicateList;
    switch (modelType) {
      case ModelTypes.posts:
        noDuplicateList = latest && cacheDocsList.isNotEmpty
            ? <PostModel>{...newDocsList, ...cacheDocsList}.toList()
            : <PostModel>{...cacheDocsList, ...newDocsList}.toList();
        readyHiveList = noDuplicateList.map((model) => PostModelHive.toHive(model)).toList();
        break;
      case ModelTypes.chats:
        noDuplicateList = latest && cacheDocsList.isNotEmpty
            ? <ChatModel>{...newDocsList, ...cacheDocsList}.toList()
            : <ChatModel>{...cacheDocsList, ...newDocsList}.toList();
        readyHiveList = noDuplicateList.map((model) => ChatModelHive.toHive(model)).toList();
        break;
      case ModelTypes.messages:
        noDuplicateList = latest && cacheDocsList.isNotEmpty
            ? <MessageModel>{...newDocsList, ...cacheDocsList}.toList()
            : <MessageModel>{...cacheDocsList, ...newDocsList}.toList();
        readyHiveList = noDuplicateList.map((model) => MessageModelHive.toHive(model)).toList();
        break;
      case ModelTypes.users:
        noDuplicateList = latest && cacheDocsList.isNotEmpty
            ? <UserModel>{...newDocsList, ...cacheDocsList}.toList()
            : <UserModel>{...cacheDocsList, ...newDocsList}.toList();
        readyHiveList = noDuplicateList.map((model) => UserModelHive.toHive(model)).toList();
        break;
    }
    HiveServices.uniBox.put('cache${modelType.name}List', readyHiveList);
    return noDuplicateList;
  }

  static Future<Map<String, dynamic>> getStartEndAtDocBasedCache(
      List cacheHiveDocsList, ModelTypes modelType,)async{
    var modelTypeName = modelType.name;
    var cacheDocsList;
    var endBeforeDoc;
    var startAtDoc;
    switch (modelType) {
      case ModelTypes.posts:
        cacheDocsList = cacheHiveDocsList.map((model)
        => PostModelHive.fromHive(model)).toList();
        endBeforeDoc = await Database.advanced.getStartEndAtDoc(  //> First
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.first.postId);
        startAtDoc = await Database.advanced.getStartEndAtDoc( //> Last
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.last.postId);
        break;
      case ModelTypes.chats:
        cacheDocsList = cacheHiveDocsList.map((model)
        => ChatModelHive.fromHive(model)).toList();
        endBeforeDoc = await Database.advanced.getStartEndAtDoc(  //> First
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.first.id);
        startAtDoc = await Database.advanced.getStartEndAtDoc( //> Last
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.last.id);
        break;
      case ModelTypes.messages:
        cacheDocsList = cacheHiveDocsList.map((model)
        => MessageModelHive.fromHive(model)).toList();
        endBeforeDoc = await Database.advanced.getStartEndAtDoc(  //> First
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.first.messageId);
        startAtDoc = await Database.advanced.getStartEndAtDoc( //> Last
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.last.messageId);

        break;
      case ModelTypes.users:
        cacheDocsList = cacheHiveDocsList.map((model)
        => UserModelHive.fromHive(model)).toList();
        endBeforeDoc = await Database.advanced.getStartEndAtDoc(  //> First
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.first.uid);
        startAtDoc = await Database.advanced.getStartEndAtDoc( //> Last
            modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.last.uid);
        break;
    }
    return {
      'cacheDocsList' : cacheDocsList,
      'endBeforeDoc' : endBeforeDoc,
      'startAtDoc' : startAtDoc
    };
  }

  // Use to update like status.
  static updatePostInCache(PostModel updatePost) {
    var cacheHivePostsList = HiveServices.postsBox.get('cachePostsList') ?? [];
    var cachePostsList =
    cacheHivePostsList.map((postModel) => PostModelHive.fromHive(postModel)).toList();

    var postIndex = cachePostsList.indexWhere((item) => item.postId == updatePost.postId);
    cachePostsList.removeWhere((item) => item.postId == updatePost.postId); // Remove original
    cachePostsList.insert(postIndex, updatePost); // Add new

    var readyHiveList = cachePostsList.map((postModel) => PostModelHive.toHive(postModel)).toList();
    HiveServices.postsBox.put('cachePostsList', readyHiveList);
  }

  //~ CurrUser:
  static Future<bool> getCurrUserFromCache(BuildContext context) async {
    print('START: getCurrUserFromCache()');
    try {
      UserModelHive currUserHive = uniBox.get('currUser');
      UserModel currUser = UserModelHive.fromHive(currUserHive);
      context.uniProvider.updateUser(currUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  void saveCurrUserToCache(BuildContext context, UserModel currUser) async {
    context.uniProvider.updateUser(currUser);
    HiveServices.uniBox.put('currUser', UserModelHive.toHive(currUser));
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
