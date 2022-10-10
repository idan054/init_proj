import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';

import '../Auth/firebase_database.dart' as click;
import '../Auth/firebase_database.dart';
import '../Hive/hive_services.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
  static Future<List<PostModel>?> handleGetPost(BuildContext context) async {
    print('START: handleGetPost()');
    //> (1) Get All posts from cache
    var cachePostsList = HiveServices.postsBox.get('cachePostsList') ?? [];
    print('cachePostsList ${cachePostsList.runtimeType}');
    print('cachePostsList ${cachePostsList}');

    //> (2) Get lasted cached post
    var startAtDoc = await Database.getStartAtDoc(
        'posts', cachePostsList.isEmpty ? null : cachePostsList.last.postId);

    //> (3) Get new posts after that from server
    var newPostList = await Database.getPosts(context, startAtDoc) ?? [];

    //> (4) Remove duplicate, save to cache & Summary
    var noDuplicateList = <PostModel>{...cachePostsList, ...newPostList}.toList();
    HiveServices.postsBox.put('cachePostsList', noDuplicateList);
    print('SUMMARIES:');
    print('POSTS From Hive CACHE: ${cachePostsList.length}');
    print('POSTS From Database: ${newPostList.length}');

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
