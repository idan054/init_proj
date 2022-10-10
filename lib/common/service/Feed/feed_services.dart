import 'package:example/common/models/post/hive/hive_post_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:palestine_console/palestine_console.dart';

import '../Auth/firebase_database.dart' as click;
import '../Auth/firebase_database.dart';
import '../Hive/hive_services.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
  static Future<List<PostModel>?> handleGetPost(BuildContext context) async {
    print('START: handleGetPost()');
    //> (1) Get All posts from cache
    var cacheHivePostsList = HiveServices.postsBox.get('cachePostsList') ?? [];
    var cachePostsList = cacheHivePostsList.map((postModel) =>
        PostModelHive.fromHive(postModel)).toList();

    //> (2) Get lasted cached post
    var startEndAtDoc = await Database.getStartAtDoc(
        'posts', cachePostsList.isEmpty ? null : cachePostsList.last.postId);

    //> (3) Check if new & Get new posts after that from server
    // getPostsEndBefore() - Latest posts (if user upload new) - Stop on cache.
    // getPostsStartAt() - 10 new posts who didn't fetched yet - Start after cache.
    // so the post list order is [Latest posts -> cache -> older posts]
    var latestPostList = await Database.getPostsEndBefore(context, startEndAtDoc) ?? [];
    var newPostList = await Database.getPostsStartAt(context, startEndAtDoc) ?? [];

    //> (4) Remove duplicate, save to cache & Summary
    var noDuplicateList = <PostModel>{...latestPostList,...cachePostsList, ...newPostList}.toList();
    var readyHiveList = noDuplicateList.map((postModel) =>
        PostModelHive.toHive(postModel)).toList();
    HiveServices.postsBox.put('cachePostsList', readyHiveList);
    print('SUMMARIES:');
    print('✴️ (1) POSTS From Database (Latest): ${newPostList.length} ✴️ ');
    print('❇️ (2) POSTS From Hive CACHE: ${cachePostsList.length} ❇️ ');
    print('✴️ (3) POSTS From Database (older): ${newPostList.length} ✴️ ');

    return noDuplicateList;
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
