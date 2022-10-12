import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/chat/hive/hive_chat_model.dart';
import 'package:example/common/models/message/hive/hive_message_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/hive/hive_post_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/hive/hive_user_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:palestine_console/palestine_console.dart';

import '../Auth/firebase_database.dart' as click;
import '../Auth/firebase_database.dart';
import '../Hive/hive_services.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
  /// This smart func choose when Hive cache / Database needed.
  static Future handleGetDocs(BuildContext context, ModelTypes modelType,
      {required bool latest}) async {
    var modelTypeName = modelType.name;
    print('START: handleGetDocs of $modelTypeName()');

    //> (1) Get All posts from cache
    var cacheHiveDocsList = HiveServices.uniBox.get('cache${modelTypeName}List') ?? [];
    var cacheDocsList =
        cacheHiveDocsList.map((postModel) => PostModelHive.fromHive(postModel)).toList();

    //> (2) Get Latest cached post
    var endBeforeDoc = await Database.getStartEndAtDoc(
        modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.first.postId);
    var startAtDoc = await Database.getStartEndAtDoc(
        modelTypeName, cacheDocsList.isEmpty ? null : cacheDocsList.last.postId);

    //> (3) Check if new & Get new posts after that from server
    // getPostsEndBefore() - Latest posts (if user upload new) - Stop on cache.
    // getPostsStartAt() - 10 new posts who didn't fetched yet - Start after cache.
    // so the post list order is [Latest posts -> cache -> older posts]
    var newPostList = latest && cacheDocsList.isNotEmpty
        ? await Database.getDocsEndBefore(context, endBeforeDoc, modelType) ?? []
        : await Database.getDocsStartAt(context, startAtDoc, modelType) ?? [];

    //> (4) Remove duplicate, save to cache & Summary
    var noDuplicateList = HiveServices.updateCacheDocsList(modelType,
        latest: latest,
        cacheDocsList: cacheDocsList,
        newPostList: newPostList);

    print('SUMMARIES:');
    print(latest
        ? '✴️ (${newPostList.length}) ${modelTypeName.toUpperCase()} From Database (Latest) [EndBefore] ✴️ '
        : '✴️ (${newPostList.length}) ${modelTypeName.toUpperCase()} From Database (older) [StartAt] ✴️ ');
    print('❇️ (${cacheDocsList.length}) ${modelTypeName.toUpperCase()} From Hive CACHE ❇️ ');
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

  void setPostLike(BuildContext context, PostModel post, bool isLiked) {
    print('START: setPostLike()');
    var currUserUid = context.uniProvider.currUser.uid;
    List<String> likesUids = [...post.likeByIds];
    final isAlreadyLiked = likesUids.contains(context.uniProvider.currUser.uid);

    if (isLiked) {
      print('unLiked');
      likesUids.remove(currUserUid!);
      post = post.copyWith(
          likeCounter: post.likeCounter == 0 ? 0 : post.likeCounter! - 1, likeByIds: likesUids);
    } else {
      print('Liked!');
      if (!isAlreadyLiked) likesUids.add(currUserUid!);
      post = post.copyWith(
          likeCounter: post.likeCounter == null
              ? 1
              : isAlreadyLiked
                  ? post.likeCounter!
                  : post.likeCounter! + 1,
          likeByIds: likesUids);
    }

    HiveServices.updatePostInCache(post);
    // todo use AddToBatch() + dispose() instead
    Database().updateFirestore(
      collection: 'posts',
      docName: post.postId,
      toJson: post.toJson(),
    );
  }

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
