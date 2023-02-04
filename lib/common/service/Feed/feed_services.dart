import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';
import '../Database/firebase_db.dart' as click;
import '../Database/firebase_db.dart';

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

  static void _notifyUsers(BuildContext context, PostModel comment, PostModel originalPost) {
    for (var email in comment.commentedUsersEmails) {
      Database.updateFirestore(
        collection: 'users/$email/notifications',
        docName: comment.id,
        toJson: comment.toJson(),
      );
    }
  }

  static void addComment(BuildContext context, PostModel comment, PostModel originalPost) {
    print('START: addComment()');
    var currUser = context.uniProvider.currUser;
    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);

    Database.updateFirestore(
      collection: 'posts/${comment.originalPostId}/comments',
      docName: comment.id,
      toJson: comment.toJson(),
    );

    Map<String, dynamic> postData = {};
    postData['commentsLength'] = FieldValue.increment(1);
    if (!(originalPost.commentedUsersEmails.contains(currUser.email))) {
      postData['commentedUsersEmails'] = FieldValue.arrayUnion([currUser.email]);
    }

    Database.updateFirestore(
        collection: 'posts', docName: comment.originalPostId, toJson: postData);
  }

  static void uploadPost(BuildContext context, PostModel post) {
    print('START: uploadPost()');
    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);
    Database.updateFirestore(
      collection: 'posts',
      docName: post.id,
      toJson: post.toJson(),
    );
  }
}
