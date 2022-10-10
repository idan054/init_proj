import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';

import '../Auth/firebase_database.dart' as click;
import '../Auth/firebase_database.dart';
import '../Hive/hive_services.dart';
import '../Hive/timestamp_convert.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
  static Future<List<PostModel>?> handleGetPost(BuildContext context) async {
    print('START: handleGetPost()');
    //> (1) Get All posts from cache
    List<Map<String, dynamic>>
        jsonPostsList = //! todo check how tf its print Timestamp()!
        HiveServices.postsBox.get('jsonPostsList') ?? [];
    var jsonReadyList =
        jsonPostsList.map((json) => jsonWithTimestampFromHive(json)).toList();
    var postsListHiveCache =
        jsonReadyList.map((json) => PostModel.fromJson(json)).toList();

    //> (2) Get lasted cached post
    var startAtDoc = await Database.getStartAtDoc(
      'posts',
      postsListHiveCache.isEmpty ? null : postsListHiveCache.last.postId,
    );

    //> (3) Get new posts after that from server
    var newDatabasePosts =
        await Database.getPosts(context, startAtDoc, jsonPostsList) ?? [];
    print('SUMMARIES:');
    print('POSTS From Hive CACHE: ${postsListHiveCache.length}');
    print('POSTS From Database: ${newDatabasePosts.length}');

    return [...postsListHiveCache, ...newDatabasePosts];
  }

  // void setPostLike(MessageModel message, String chatId, WriteBatch batch) {
  //   // Todo make sure it works!
  //   print('chatId ${chatId}');
  //   print('message ${message.messageId}');
  //   Database().addToBatch(
  //       batch: batch,
  //       collection: 'chats/$chatId/messages',
  //       docName: message.messageId,
  //       toJson: {'read': true});
  // }

  void uploadPost(BuildContext context, PostModel post) {
    print('START: uploadPost()');
    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);
    Database().updateFirestore(
      collection: 'posts',
      docName: post.postId,
      toJson: post.toJson(),
    );
  }
}
