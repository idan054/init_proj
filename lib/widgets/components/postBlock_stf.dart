// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Chat/chat_services.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/service/Auth/dynamic_link_services.dart';
import 'package:example/main.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/report/report_model.dart';
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

class PostBlock extends StatefulWidget {
  final PostModel post;
  final bool isUserPage;
  final bool isReported;

  const PostBlock(this.post, {this.isUserPage = false, this.isReported = false, Key? key})
      : super(key: key);

  @override
  State<PostBlock> createState() => _PostBlockState();
}

class _PostBlockState extends State<PostBlock> {
  int? notificationCounter;

  @override
  Widget build(BuildContext context) {
    notificationCounter ??= widget.post.notificationsCounter;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          buildProfile(context, widget.isUserPage), // Doesn't require 55 Left padding.
          Column(
            children: [
              buildExpandableText(
                      // 'Example : let’s try to think of an topic or fdsk conte tou fc words as possible... I think I’ve already ',
                      widget.post.textContent,
                      maxLines: 4,
                      textAlign:
                          widget.post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
                      textDirection:
                          widget.post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
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
        widget.post.enableComments
            ? () {
                // isUserPage ? Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 Scaffold(body: CommentsChatScreen(post, isFullScreen: isUserPage))),
                //       ) :

                setState(() {});
                notificationCounter = 0;
                FeedService.resetPostUnread(context, widget.post.id);
                handleShowBottomPost(context, widget.post);
              }
            : null,
        radius: 10);
  }

  Widget buildProfile(BuildContext context, bool isUserPage) {
    var currUser = context.uniProvider.currUser;
    var isCurrUser = currUser.uid == widget.post.creatorUser!.uid;
    var isAdmin = currUser.userType == UserTypes.admin;

    var postAgo = postTime(widget.post.timestamp!);

    return SizedBox(
        height: 68,
        // height: 72, // 72: original size 60: min size
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
          title: '${widget.post.creatorUser?.name}'
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
          ),
          leading: Stack(
            children: [
              Container(
                  // radius: 20,
                  height: 40,
                  width: 40,
                  color: AppColors.darkBg,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: '${widget.post.creatorUser!.photoUrl}',
                    fit: BoxFit.cover,
                  )).roundedFull,
              buildOnlineBadge(context, widget.post.creatorUser!),
            ],
          ).pad(0).onTap(
              isUserPage
                  ? null
                  : () {
                      print('PROFILE CLICKED');
                      context.router.push(UserRoute(user: widget.post.creatorUser!));
                    },
              radius: 5),
          // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
          trailing: PopupMenuButton(
              icon: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50),
              shape: 10.roundedShape,
              color: AppColors.darkOutline50,
              itemBuilder: (context) {
                return [
                  if (widget.isReported)
                    PopupMenuItem(
                      child: 'Cancel Report'.toText(),
                      onTap: () async {
                        reportRilOrCommentPopup(context, widget.post, isReported: true);
                      },
                    ),
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
                            deleteRilOrCommentPopup(context, widget.post);
                          }
                        //> Open Report POPUP
                        : () async {
                            print('SETTINGS REPORT CLICKED');
                            reportRilOrCommentPopup(context, widget.post);
                          },
                  ),
                ];
              }),
        ));
  }

  Widget buildActionRow(BuildContext context) {
    var isLiked = widget.post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var iconColor = Colors.white60;
    var commentEmpty = widget.post.commentsLength == 0;
    var title = commentEmpty ? 'New' : '${widget.post.commentsLength} comments';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.post.enableComments && widget.post.originalPostId == null // AKA its not comment
            ? Container(
                color: commentEmpty ? AppColors.primaryOriginal : AppColors.transparent,
                child: Row(
                  children: [
                    // TODO Add notification dot here
                    if (notificationCounter != 0) ...[
                      const CircleAvatar(backgroundColor: AppColors.errRed, radius: 3.5),
                      const SizedBox(width: 7),
                    ],

                    // if(!commentEmpty)
                    (commentEmpty
                            ? Assets.svg.icons.wisdomLightStar
                            : Assets.svg.icons.messageCircle02)
                        .svg(height: 13, color: AppColors.grey50),
                    // if(!commentEmpty)
                    SizedBox(width: commentEmpty ? 4 : 7),
                    // 'available soon'
                    title.toText(color: AppColors.grey50, fontSize: 12)
                  ],
                ).px(7).py(4),
              ).roundedFull.pOnly(bottom: 12, top: 15)
            // .onTap(() {}, radius: 10)
            : const SizedBox(height: 20),
        const Spacer(),
        if (widget.post.creatorUser!.uid != currUser.uid) ...[
          // TODO ADD ON POST MVP ONLY (Send like)
          // // Like Button
          // buildHeartIcon(isLiked),
          // // Divider

          // Container(height: 20, width: 2, color: AppColors.darkOutline50)
          //     .customRowPadding)
          //     .roundedFull,

          // Chat Button
          widget.post.enableComments
              ? Assets.svg.icons.shareArrowWide
                  .svg(height: 17, color: AppColors.grey50)
                  .pOnly(left: 18, right: 18, bottom: 12, top: 20)
                  .onTap(() {
                  DynamicLinkService.sharePostLink(productUrl: 'X', productId: 'Y');
                })

              // ? const Offstage()
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
                  ChatService.openChat(context,
                      otherUser: widget.post.creatorUser!, postReply: widget.post);
                }, radius: 10)
        ]
      ],
    )
        // .customRowPadding
        ;
  }

  StatefulBuilder buildHeartIcon(bool isLiked) {
    return StatefulBuilder(builder: (context, stfSetState) {
      return Opacity(
        opacity: isLiked ? 1.0 : 0.5,
        child: Assets.svg.icons.heartUntitledIcon
            .svg(height: 17, color: isLiked ? AppColors.likeRed : null)
            .pOnly(left: 18, right: 18, bottom: 4)
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

void reportRilOrCommentPopup(BuildContext context, PostModel post, {bool isReported = false}) {
  var isCommentPost = post.originalPostId != null;
  var type = isCommentPost ? 'Comment' : 'Ril';

  Future.delayed(150.milliseconds).then((_) {
    showRilDialog(context,
        title: isReported ? 'Cancel this $type Report?' : 'Report this $type?',
        desc: '"${post.textContent}"'.toText(fontSize: 13),
        barrierDismissible: true,
        // showCancelBtn: !isReported,
        secondaryBtn: TextButton(
            onPressed: () {
              var nameEndAt = post.textContent.length < 20 ? post.textContent.length : 20;
              var docName = 'REPORT:'
                  '${post.textContent.substring(0, nameEndAt).toString() + UniqueKey().toString()}';

              var postReport = ReportModel(
                timestamp: DateTime.now(),
                reportedBy: context.uniProvider.currUser.name,
                reportedPost: post,
                // reportedUser: user,
                // reasonWhy: reasonController.text,
                reportStatus: isReported ? ReportStatus.completedReport : ReportStatus.newReport,
                reportType: isCommentPost
                    ? ReportType.comment
                    : (post.enableComments ? ReportType.conversation : ReportType.ril),
              );

              Database.updateFirestore(
                  collection: 'reports/Reported rils/rils',
                  docName: docName,
                  toJson: postReport.toJson());
              Navigator.of(context).pop();
              if (isReported) {
                rilFlushBar(context, 'Thanks, $type handled successfully');
              } else {
                rilFlushBar(context, 'Thanks, We\'ll handle it asap');
              }
            },
            child:
                (isReported ? 'Cancel Report' : 'Report').toText(color: AppColors.primaryLight)));
  });
}

void deleteRilOrCommentPopup(BuildContext context, PostModel post, {Function? onDelete}) {
  var myPost = post.creatorUser?.uid == context.uniProvider.currUser.uid;
  var isCommentPost = post.originalPostId != null;
  var type = isCommentPost ? 'Comment' : 'Ril';

  Future.delayed(150.milliseconds).then((_) {
    showRilDialog(context,
        // title: 'Delete your Ril?',
        title: 'Delete ${myPost ? 'Your' : post.creatorUser?.email} $type?',
        desc: '"${post.textContent}"'.toText(fontSize: 13),
        barrierDismissible: true,
        secondaryBtn: TextButton(
            onPressed: () {
              if (isCommentPost) {
                Database.deleteDoc(
                    collection: 'posts', docName: '${post.originalPostId}/comments/${post.id}');
              } else {
                Database.deleteDoc(collection: 'posts', docName: post.id);
              }

              if (onDelete == null) {
                Navigator.of(context).pop();
                rilFlushBar(context, '$type has been successfully deleted');
              } else {
                onDelete();
                Navigator.of(context).pop();
              }
            },
            child: 'Delete'.toText(color: AppColors.primaryLight)));
  });
}

Widget buildOnlineBadge(BuildContext context, UserModel user, {double ratio = 1.0}) {
  var isOnline = user.email == context.uniProvider.currUser.email ||
      (context.uniProvider.onlineUsers ?? []).contains(user.email ?? '');
  return isOnline
      ? Positioned(
          bottom: 0,
          right: 0,
          child: CircleAvatar(
            radius: 6.5 * ratio,
            backgroundColor: AppColors.primaryDark,
            child:
                //> STATIC VERSION:
                // CircleAvatar(radius: 4, backgroundColor: AppColors.green),
                //> LIVE VERSION:
                BlinkingOnlineBadge(ratio: ratio),
          ),
        )
      : const Offstage();
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
    _animationController = AnimationController(vsync: this, duration: 1500.milliseconds);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.ratio * 4.0;
    return CircleAvatar(
      radius: size,
      backgroundColor: AppColors.greenOld.withOpacity(0.35),
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

Future handleShowBottomPost(BuildContext context, PostModel post) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black38,
      // barrierColor: Colors.black.withOpacity(0.20), // AKA 20%
      // barrierColor: Colors.black.withOpacity(0.00),
      // AKA 2%
      isScrollControlled: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return CommentsChatScreen(post);
        // return Offstage();
      });
}
