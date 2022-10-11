import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/hive/hive_post_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';
import 'package:palestine_console/palestine_console.dart';

import '../Auth/firebase_database.dart' as click;
import '../Auth/firebase_database.dart';
import '../Hive/hive_services.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
  static Future<List<PostModel>?> handleGetPost(BuildContext context,
      {required bool latest}) async {
    print('START: handleGetPost()');
    //> (1) Get All posts from cache
    var cacheHivePostsList = HiveServices.postsBox.get('cachePostsList') ?? [];
    var cachePostsList =
        cacheHivePostsList.map((postModel) => PostModelHive.fromHive(postModel)).toList();

    //> (2) Get Latest cached post
    var endBeforeDoc = await Database.getStartEndAtDoc(
        'posts', cachePostsList.isEmpty ? null : cachePostsList.first.postId);

    var startAtDoc = await Database.getStartEndAtDoc(
        'posts', cachePostsList.isEmpty ? null : cachePostsList.last.postId);

    //> (3) Check if new & Get new posts after that from server
    // getPostsEndBefore() - Latest posts (if user upload new) - Stop on cache.
    // getPostsStartAt() - 10 new posts who didn't fetched yet - Start after cache.
    // so the post list order is [Latest posts -> cache -> older posts]
    var newPostList = latest && cachePostsList.isNotEmpty ?
      await Database.getPostsEndBefore(context, endBeforeDoc) ?? []
    : await Database.getPostsStartAt(context, startAtDoc) ?? [];

    //> (4) Remove duplicate, save to cache & Summary
    var noDuplicateList =
    latest && cachePostsList.isNotEmpty ?
        <PostModel>{...newPostList, ...cachePostsList}.toList()
        : <PostModel>{...cachePostsList, ...newPostList}.toList();
    var readyHiveList =
        noDuplicateList.map((postModel) => PostModelHive.toHive(postModel)).toList();
    HiveServices.postsBox.put('cachePostsList', readyHiveList);
    print('SUMMARIES:');
    print(latest ? '✴️ (${newPostList.length}) POSTS From Database (Latest) [EndBefore] ✴️ '
                 : '✴️ (${newPostList.length}) POSTS From Database (older) [StartAt] ✴️ ');
    print('❇️ (${cachePostsList.length}) POSTS From Hive CACHE ❇️ ');

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

    if(post.likeByIds.contains(currUserUid) || isLiked){
    print('unLiked');
      likesUids.remove(currUserUid!);
      post = post.copyWith(
          likeCounter: post.likeCounter == 0 ? 0 : post.likeCounter! - 1,
          likeByIds: likesUids
      );
    } else {
    print('Liked!');
    likesUids.add(currUserUid!);
    post = post.copyWith(
        likeCounter: post.likeCounter == null ? 1 : post.likeCounter! + 1,
        likeByIds: likesUids
    );
    }

    Database().updateFirestore(
      collection: 'posts',
      docName: post.postId,
      toJson: post.toJson(),
    );

    //> Update Hive:
    var cacheHivePostsList = HiveServices.postsBox.get('cachePostsList') ?? [];
    var cachePostsList =
           cacheHivePostsList.map((postModel) => PostModelHive.fromHive(postModel)).toList();

    var postIndex = cachePostsList.indexWhere((item) => item.postId == post.postId);
    cachePostsList.removeWhere((item) => item.postId == post.postId); // Remove original
    cachePostsList.insert(postIndex, post); // Add new

    var readyHiveList = cachePostsList.map((postModel) => PostModelHive.toHive(postModel)).toList();
    HiveServices.postsBox.put('cachePostsList', readyHiveList);


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
