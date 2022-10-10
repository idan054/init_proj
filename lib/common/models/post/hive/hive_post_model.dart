import 'package:example/common/models/post/post_model.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../convertors.dart';
import '../../user/user_model.dart';
part 'hive_post_model.g.dart';

@HiveType(typeId: 3)
class PostModelHive {
  @HiveField(0) String? textContent;
  @HiveField(1) String? postId;
  @HiveField(2) UserModel? creatorUser;
  @HiveField(3) bool? isDarkText;
  @HiveField(4) bool? isSubPost;
  @HiveField(5) bool? enableLikes;
  @HiveField(6) bool? enableComments;
  @HiveField(7) DateTime? timestamp;
  @HiveField(8) TextAlign? textAlign;
  @HiveField(9) int? likeCounter;
  @HiveField(10) String? photoCover;
  @HiveField(11) Color? colorCover;
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

});

  PostModelHive toHive(PostModel post) => PostModelHive(
      textContent: post.textContent,
      postId: post.postId,
      creatorUser: post.creatorUser,
      isDarkText: post.isDarkText,
      isSubPost: post.isSubPost,
      enableLikes: post.enableLikes,
      enableComments: post.enableComments,
      timestamp: post.timestamp,
      textAlign: post.textAlign,
      likeCounter: post.likeCounter,
      photoCover: post.photoCover,
      colorCover: post.colorCover,
  );

  PostModel fromHive(PostModelHive post) => PostModel(
    textContent: post.textContent!,
    postId: post.postId!,
    creatorUser: post.creatorUser,
    isDarkText: post.isDarkText!,
    isSubPost: post.isSubPost!,
    enableLikes: post.enableLikes!,
    enableComments: post.enableComments!,
    timestamp: post.timestamp,
    textAlign: post.textAlign!,
    likeCounter: post.likeCounter,
    photoCover: post.photoCover,
    colorCover: post.colorCover,
  );
}


