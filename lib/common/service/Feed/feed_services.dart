import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import '../Database/db_advanced.dart';
import '../Database/firebase_db.dart' as click;
import '../Database/firebase_db.dart';
import '../Auth/notifications_services.dart';

/// streamMessages() Available At [click.Database] // <<---

class FeedService {
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

  // void setPostLike(BuildContext context, PostModel post, bool isLiked) {
  //   print('START: setPostLike()');
  //   var currUserUid = context.uniProvider.currUser.uid;
  //   List<String> likesUids = [...post.likeByIds];
  //   final isAlreadyLiked = likesUids.contains(context.uniProvider.currUser.uid);
  //
  //   if (isLiked) {
  //     print('unLiked');
  //     likesUids.remove(currUserUid!);
  //     post = post.copyWith(
  //         likeCounter: post.likeCounter == 0 ? 0 : post.likeCounter! - 1, likeByIds: likesUids);
  //   } else {
  //     print('Liked!');
  //     if (!isAlreadyLiked) likesUids.add(currUserUid!);
  //     post = post.copyWith(
  //         likeCounter: post.likeCounter == null
  //             ? 1
  //             : isAlreadyLiked
  //                 ? post.likeCounter!
  //                 : post.likeCounter! + 1,
  //         likeByIds: likesUids);
  //   }
  //
  //   // todo use AddToBatch() + dispose() instead
  //   Database.updateFirestore(
  //     collection: 'posts',
  //     docName: post.id,
  //     toJson: post.toJson(),
  //   );
  // }

  static void resetPostUnread(BuildContext context, String postId) {
    print('START: resetPostUnread()');
    print('postId $postId');
    var currUser = context.uniProvider.currUser;
    // var unread = chat.unreadCounter;
    // print('unread $unread');

    var fetchedPosts = context.uniProvider.fetchedPosts;
    for (var post in [...fetchedPosts]) {
      if (post.id == postId) fetchedPosts.remove(post);
    }
    context.uniProvider.fetchedPostsUpdate([...fetchedPosts]);
    fetchedPosts = context.uniProvider.fetchedPosts;
    print('fetchedPosts X  ${fetchedPosts.length}');

    var exportedEmail = currUser.email!.replaceAll('.', 'DOT');
    Database.updateFirestore(
      collection: 'posts',
      docName: postId,
      toJson: {
        'metadata': {'${exportedEmail}_notifications': 0}
      },
    );

    // if (unread != null && unread != 0 && userUnreadCounter > 0) {
    //   print('START: resetChatUnread() [if]');
    //
    //   // From chat & user collections.
    //   // Database.updateFirestore(
    //   //   collection: 'users',
    //   //   docName: userEmail,
    //   //   toJson: {
    //   //     'unreadCounter': FieldValue.increment(-unread), // Overall to user
    //   //   },
    //   // );
    //   //
    //
    //
    // }
  }

  static Future<PostModel?> getPostById(String postId) async {
    var data = await Database.docData('posts/$postId');
    var post = PostModel.fromJson(data!);
    return post;
  }

  static void addComment(BuildContext context, PostModel comment, PostModel originalPost) async {
    print('START: addComment()');
    var currUser = context.uniProvider.currUser;
    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);

    //~ Add comment:
    Database.updateFirestore(
      collection: 'posts/${comment.originalPostId}/comments',
      docName: comment.id,
      toJson: comment.toJson(),
    );

    //~ Update conversion:
    // Members in conversion counter
    Map<String, dynamic> postData = {};
    postData['commentsLength'] = FieldValue.increment(1);
    if (!(originalPost.commentedUsersEmails.contains(currUser.email))) {
      postData['commentedUsersEmails'] = FieldValue.arrayUnion([currUser.email]);
    }

    //~ Notify members
    postData['metadata'] = {};
    postData['metadata']['usersWithUnreadNotification'] = []; // Email list for filter
    for (var email in originalPost.commentedUsersEmails) {
      if (email == currUser.email) {
      } else {
        postData['metadata']['usersWithUnreadNotification'] = FieldValue.arrayUnion([email]);
        var exportedEmail = email.replaceAll('.', 'DOT');
        postData['metadata']['${exportedEmail}_notifications'] = FieldValue.increment(1);

        var otherUser = await FsAdvanced.getUserByEmailIfNeeded(context, UserModel(email: email));
        // var title = '${currUser.name} Joined your conversation';
        var title = '${currUser.name} Commented';
        print(' otherUser.fcm ${otherUser.fcm}');
        PushNotificationService.sendPushNotification(
          token: otherUser.fcm!,
          title: title,
          // title: 'You received new message!',
          // title: '$name Start a new chat with you',
          // title: '$name joined your conversation',
          desc: 'A new comment on conversation of yours',
        );
      }
    }

    Database.updateFirestore(
        collection: 'posts', docName: comment.originalPostId, toJson: postData);
  }

  static void uploadPost(BuildContext context, PostModel post) {
    printWhite('START: uploadPost() post.id ${post.id}');

    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);

    final currUser = context.uniProvider.currUser;
    final postLocation = GeoFlutterFire().point(
      latitude: currUser.position!.geopoint!.latitude,
      longitude: currUser.position!.geopoint!.longitude,
    );
    Map<String, dynamic> jsonPost = post.toJson();
    jsonPost['position'] = postLocation.data;
    // log('jsonPost $jsonPost');
    // {
    // creatorUser{...},
    // textContent...,
    // position{...}
    // }

    Database.updateFirestore(
      collection: 'posts',
      docName: post.id,
      // toJson: post.toJson(),
      toJson: jsonPost,
    );
  }
}
