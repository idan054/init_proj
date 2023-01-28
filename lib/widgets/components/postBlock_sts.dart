// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Chat/chat_services.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/main.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../common/models/post/post_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../screens/feed_ui/comments_chat_screen.dart';
import '../../screens/user_ui/user_screen.dart';
import '../../screens/main_ui/dashboard_screen.dart';
import 'dart:io';

import '../clean_snackbar.dart';
import '../my_dialog.dart';
import 'package:intl/intl.dart' as intl;

// Also look for 'customRowPadding' With CTRL + SHIFT + F

// todo POST call creatorUser doc on initState
// to make sure data is updated (not old after user edit)
// also use users cubit so it will GET every user once each session

class PostBlock extends StatelessWidget {
  final PostModel post;
  final bool isUserPage;

  const PostBlock(this.post, {this.isUserPage = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          buildProfile(context, isUserPage), // Doesn't require 55 Left padding.
          Column(
            children: [
              buildExpandableText(
                      // 'Example : let’s try to think of an topic or fdsk conte tou fc words as possible... I think I’ve already ',
                      post.textContent,
                      maxLines: 4,
                      textAlign: post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
                      textDirection:
                          post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                      style: AppStyles.text16PxRegular.copyWith(color: AppColors.white))
                  .pOnly(right: 20)
                  .advancedSizedBox(context, maxWidth: true),
              buildActionRow(context),
            ],
            // ).pOnly(left: 5)
          ).pOnly(left: 55)
        ],
      ).pOnly(left: 15),
    ).onTap(
        post.enableComments ?
            () {
      isUserPage
          ? Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Scaffold(
                          body: CommentsChatScreen(
                        post,
                        isFullScreen: isUserPage,
                      ))),
            )
          : showModalBottomSheet(
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black38,
              // barrierColor: Colors.black.withOpacity(0.20), // AKA 20%
              // barrierColor: Colors.black.withOpacity(0.00),
              // AKA 2%
              isScrollControlled: true,
              enableDrag: false,
              context: context,
              builder: (context) {
                return CommentsChatScreen(post);
                // return Offstage();
              });
    }
    : null
        , radius: 10);
  }

  Widget buildProfile(BuildContext context, bool isUserPage) {
    var currUser = context.uniProvider.currUser;
    var isCurrUser = currUser.uid == post.creatorUser!.uid;
    var isAdmin = currUser.userType == UserTypes.admin;

    var postAgo = postTime(post.timestamp!);

    return SizedBox(
      height: 68,
      // height: 72, // 72: original size 60: min size
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
        title: '${post.creatorUser?.name}'
            .toText(fontSize: 14, bold: true, color: AppColors.white, textAlign: TextAlign.left),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TODO ADD ON POST MVP ONLY (ago · Tag (Add Tags))
            postAgo
                .toText(color: AppColors.grey50, fontSize: 12)
                .pOnly(right: 10, top: 4, bottom: 10)
            // .onTap(() {}, radius: 10), // TODO Add move to Tag
          ],
        )
        ,
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
              backgroundColor: AppColors.darkOutline,
            ),
            buildOnlineBadge(),
          ],
        ).pad(0).onTap(
            isUserPage
                ? null
                : () {
              print('PROFILE CLICKED');
              context.router.push(UserRoute(user: post.creatorUser!));
            },
            radius: 5),
        // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
        trailing: PopupMenuButton(
            icon: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50),
            shape: 10.roundedShape,
            color: AppColors.darkOutline50,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: (isAdmin && !isCurrUser
                          ? 'Admin Delete Ril'
                          : isCurrUser
                              ? 'Delete Ril'
                              : 'Report Ril')
                      .toText(),
                  onTap: (isCurrUser || isAdmin)
                      //> Open DELETE POPUP
                      ? () {
                          print('SETTINGS DELETE CLICKED');
                          deleteRilPopup(context);
                        }
                      //> Open Report POPUP
                      : () async {
                          print('SETTINGS REPORT CLICKED');
                          reportRilPopup(context);
                        },
                ),
              ];
            }),
      )
    );
  }

  void reportRilPopup(BuildContext context) {
    Future.delayed(150.milliseconds).then((_) {
      showRilDialog(context,
          title: 'Report this Ril?',
          desc: '"${post.textContent}"'.toText(fontSize: 13),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () {
                var nameEndAt = post.textContent.length < 20 ? post.textContent.length : 20;
                var docName =
                    post.textContent.substring(0, nameEndAt).toString() + UniqueKey().toString();

                Database.updateFirestore(
                  collection: 'reports/Reported rils/rils',
                  docName: docName,
                  toJson: {
                    'reportAt': Timestamp.fromDate(DateTime.now()),
                    'reportedBy': context.uniProvider.currUser.uid,
                    'textContent': post.textContent,
                    'status': 'New',
                    'type': 'Ril',
                    'post': post.toJson()
                  },
                );
                Navigator.of(context).pop();
                rilFlushBar(context, 'Thanks, We\'ll handle it asap');
              },
              child: 'Report'.toText(color: AppColors.primaryLight)));
    });
  }

  void deleteRilPopup(BuildContext context) {
    var myPost = post.creatorUser?.uid == context.uniProvider.currUser.uid;

    Future.delayed(150.milliseconds).then((_) {
      showRilDialog(context,
          // title: 'Delete your Ril?',
          title: 'Delete ${myPost ? 'Your' : post.creatorUser?.email} Ril?',
          desc: '"${post.textContent}"'.toText(fontSize: 13),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () {
                Database.deleteDoc(collection: 'posts', docName: post.id);
                Navigator.of(context).pop();
                rilFlushBar(context, 'Your Ril has been deleted');
              },
              child: 'Delete'.toText(color: AppColors.primaryLight)));
    });
  }

  Widget buildActionRow(BuildContext context) {
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var iconColor = Colors.white60;
    var commentEmpty = post.commentsLength == 0;
    var title = commentEmpty ? 'New' : '${post.commentsLength} comments';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.enableComments
            ? Row(
                children: [
                  (commentEmpty
                          ? Assets.svg.icons.wisdomLightStar
                          : Assets.svg.icons.commentUntitledIcon)
                      .svg(height: 13, color: AppColors.grey50),
                  const SizedBox(width: 7),
                  // 'available soon'
                  title
                      .toText(color: AppColors.grey50, fontSize: 12)
                      .pOnly(right: 12, bottom: 5)
                      .customRowPadding,
                ],
              )
            // .onTap(() {}, radius: 10)
            : const SizedBox(height: 20),
        const Spacer(),
        if (post.creatorUser!.uid != currUser.uid) ...[
          // TODO ADD ON POST MVP ONLY (Send like)
          // // Like Button
          // buildHeartIcon(isLiked),
          // // Divider
          // Container(height: 20, width: 2, color: AppColors.darkOutline50)
          //     .customRowPadding
          //     .roundedFull,

          // Chat Button
          post.enableComments
              ? const Offstage()
              //~ Comment button
              // Row(
              //     children: [
              //       Assets.svg.icons.messageCommentsLines.svg(height: 17, color: iconColor),
              //       10.horizontalSpace,
              //       'Answer'.toText(fontSize: 12, color: iconColor),
              //     ],
              //   ).pOnly(right: 20, left: 12).customRowPadding.onTap(
              //   // onAnswerTap
              //         () {
              //
              //   }
              //   , radius: 10)

              //~ Reply button
              : Row(
                  children: [
                    Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: iconColor),
                    10.horizontalSpace,
                    'Reply'.toText(fontSize: 12, color: iconColor),
                  ],
                ).pOnly(right: 20, left: 12).customRowPadding.onTap(() {
                  ChatService.openChat(context, otherUser: post.creatorUser!, postReply: post);
                }, radius: 10)
        ]
      ],
    );
  }

  StatefulBuilder buildHeartIcon(bool isLiked) {
    return StatefulBuilder(builder: (context, stfSetState) {
      return Opacity(
        opacity: isLiked ? 1.0 : 0.5,
        child: Assets.svg.icons.heartUntitledIcon
            .svg(height: 17, color: isLiked ? AppColors.likeRed : null)
            .pOnly(left: 12, right: 12, bottom: 4)
            .customRowPadding
            // .pad(12)
            .onTap(() {
          isLiked = !isLiked;
          // Todo Connect to server!
          stfSetState(() {});
        }, radius: 10),
      );
    });
  }
}

Positioned buildOnlineBadge({double ratio = 1.0}) {
  return Positioned(
    bottom: 0,
    right: 0,
    child: CircleAvatar(
      radius: 6.5 * ratio,
      backgroundColor: AppColors.primaryDark,
      child:
          // STATIC VERSION:
          // CircleAvatar(
          //   radius: 4,
          //   backgroundColor: AppColors.green,
          // ),

          // LIVE VERSION:
          BlinkingOnlineBadge(ratio: ratio),
    ),
  );
}

class BlinkingOnlineBadge extends StatefulWidget {
  final double ratio;

  const BlinkingOnlineBadge({this.ratio = 1.0, Key? key}) : super(key: key);

  @override
  _BlinkingOnlineBadgeState createState() => _BlinkingOnlineBadgeState();
}

class _BlinkingOnlineBadgeState extends State<BlinkingOnlineBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: 2.seconds);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.ratio * 4.0;
    return CircleAvatar(
      radius: size,
      backgroundColor: AppColors.greenOld,
      child: FadeTransition(
        opacity: _animationController,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColors.green,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

String postTime(DateTime time) {
  var postDiff = DateTime.now().difference(time);
  var postAgo =
      postDiff.inSeconds < 60 ? '${postDiff.inSeconds} sec ago' : '${postDiff.inMinutes} min ago';
  if (postDiff.inSeconds == 0) postAgo = 'Just now';
  if (2 < postDiff.inHours && postDiff.inHours < 24) {
    postAgo = '${postDiff.inHours} hours ago';
  } else if (postDiff.inHours > 24) {
    // postAgo = intl.DateFormat('yMMMMEEEEd').format(post.timestamp!);
    postAgo = intl.DateFormat('MMMM d, y').format(time);
  }

  return postAgo;
}
