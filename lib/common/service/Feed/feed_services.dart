import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:flutter/material.dart';
import '../Database/firebase_database.dart' as click;
import '../Database/firebase_database.dart';

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

    // todo use AddToBatch() + dispose() instead
    Database().updateFirestore(
      collection: 'posts',
      docName: post.id,
      toJson: post.toJson(),
    );
  }

  static void uploadPost(BuildContext context, PostModel post) {
    print('START: uploadPost()');
    // var timeStamp = DateTime.now();
    // String createdAtStr = DateFormat('dd.MM.yy kk:mm:ss').format(timeStamp);
    Database().updateFirestore(
      collection: 'posts',
      docName: post.id,
      toJson: post.toJson(),
    );
  }
}
