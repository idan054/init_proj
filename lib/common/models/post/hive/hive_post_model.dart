import 'package:example/common/models/post/post_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../convertors.dart';
import '../../user/hive/hive_user_model.dart';
import '../../user/user_model.dart';
part 'hive_post_model.g.dart';

@HiveType(typeId: 3)
class PostModelHive {
  @HiveField(0) String? textContent;
  @HiveField(1) String? postId;
  @HiveField(2) UserModelHive? creatorUser;
  @HiveField(3) bool? isDarkText;
  @HiveField(4) bool? isSubPost;
  @HiveField(5) bool? enableLikes;
  @HiveField(6) bool? enableComments;
  @HiveField(7) DateTime? timestamp;
  @HiveField(8) String? textAlign;
  @HiveField(9) int? likeCounter;
  @HiveField(10) String? photoCover;
  @HiveField(11) String? colorCover; // Its converts to Color on fromHive()!
  @HiveField(12) List<String>? likeByIds;
  PostModelHive({
        this.textContent,
        this.postId,
        this.creatorUser,
        this.isDarkText,
        this.isSubPost,
        this.enableLikes,
        this.enableComments,
        this.timestamp,
        this.textAlign,
        this.likeCounter,
        this.photoCover,
        this.colorCover,
        this.likeByIds,

});

  static PostModelHive toHive(PostModel post) {
    var creatorUser = UserModelHive.toHive(post.creatorUser!);
    var colorX = '0x${'${post.colorCover}'.split('0x')[1]}'.replaceAll(')', '');
    return PostModelHive(
      textContent: post.textContent,
      postId: post.postId,
      creatorUser: creatorUser,
      isDarkText: post.isDarkText,
      isSubPost: post.isSubPost,
      enableLikes: post.enableLikes,
      enableComments: post.enableComments,
      timestamp: post.timestamp,
      textAlign: post.textAlign,
      likeCounter: post.likeCounter,
      photoCover: post.photoCover,
      colorCover: colorX,
      likeByIds: post.likeByIds,
    );
  }

  static PostModel fromHive(PostModelHive post) {
    var creatorUser = UserModelHive.fromHive(post.creatorUser!);
    var color = Color(int.parse(post.colorCover!));
    return PostModel(
      textContent: post.textContent!,
      postId: post.postId!,
      creatorUser: creatorUser,
      isDarkText: post.isDarkText!,
      isSubPost: post.isSubPost!,
      enableLikes: post.enableLikes!,
      enableComments: post.enableComments!,
      timestamp: post.timestamp,
      textAlign: post.textAlign!,
      likeCounter: post.likeCounter,
      photoCover: post.photoCover,
      colorCover: color,
      likeByIds: post.likeByIds ?? [],
    );
  }
}


