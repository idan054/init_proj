// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'dart:math';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
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
import 'package:http/http.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/report/report_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../common/themes/app_colors_inverted.dart';
import '../../common/themes/app_styles.dart';
import '../../screens/feed_ui/comments_chat_screen.dart';
import '../../screens/user_ui/user_screen.dart';
import '../../screens/main_ui/dashboard_screen.dart';
import 'dart:io';

import '../clean_snackbar.dart';
import '../my_dialog.dart';
import 'package:intl/intl.dart' as intl;
import 'package:badges/badges.dart' as badge;

// Also look for 'customRowPadding' With CTRL + SHIFT + F

// todo POST call creatorUser doc on initState
// to make sure data is updated (not old after user edit)
// also use users cubit so it will GET every user once each session

class PostBlock extends StatefulWidget {
  final PostModel post;
  final ReportModel? report;
  final bool isUserPage;
  final bool isCommentsPage;

  const PostBlock(this.post,
      {this.report, this.isUserPage = false, this.isCommentsPage = false, Key? key})
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 6.5),
      color: AppColors.primaryDark,
      child: buildPostBody(context, widget.isUserPage).pOnly(left: 15),
    ).onTap(
        // AKA comment
        (widget.report != null && widget.post.originalPostId != null) || widget.isCommentsPage
            ? null
            : widget.post.enableComments
                ? () {
                    // isUserPage ? Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 Scaffold(body: CommentsChatScreen(post, isFullScreen: isUserPage))),
                    //       ) :

                    setState(() {}); // Needed ??
                    notificationCounter = 0;
                    FeedService.resetPostUnread(context, widget.post.id);
                    handleShowBottomPost(context, widget.post);
                  }
                : () {
                    ChatService.openChat(context,
                        otherUser: widget.post.creatorUser!, postReply: widget.post);
                  },
        radius: 10);
  }

  Widget buildPostBody(BuildContext context, bool isUserPage) {
    var currUser = context.uniProvider.currUser;
    var isCurrUser = currUser.uid == widget.post.creatorUser!.uid;
    var isAdmin = currUser.userType == UserTypes.admin;
    var postAgo = postTime(widget.post.timestamp!);

    final isConversation = widget.post.enableComments && widget.post.originalPostId == null;
    const paddingFromImage = 10.0;
    var pyBody = isConversation ? 0.0 : 11.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildProfilePic(context, isUserPage),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileRow(postAgo, isAdmin, isCurrUser, isUserPage),
            //~ Text Content
            buildExpandableText(widget.post.textContent,
                    maxLines: 4,
                    textAlign: widget.post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
                    textDirection:
                        widget.post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                    style: AppStyles.text14PxRegular.copyWith(color: AppColors.white))
                .pOnly(right: 50, bottom: pyBody, top: 5),
            //~ Reply Button
            buildActionRow(context)
          ],
        ).pOnly(left: paddingFromImage).expanded(),
      ],
    ).py(pyBody).pOnly(top: isConversation ? 11 : 0);

    // return SizedBox(
    //     // height: 55,
    //     // height: 72, // 72: original size 60: min size
    //     child: ListTile(
    //   dense: true,
    //   contentPadding: EdgeInsets.zero,
    //   horizontalTitleGap: 0,
    //   minVerticalPadding: 0,
    //
    //   // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
    //   title: Row(
    //     children: [
    //       SizedBox(
    //           width: postAgo.length > 5 ? 150 : 190,
    //           child: '${widget.post.creatorUser?.name}'.toText(
    //               fontSize: 13.5,
    //               medium: false,
    //               color: AppColors.white,
    //               textAlign: TextAlign.left)),
    //       const Spacer(),
    //       postAgo.toText(color: AppColors.greyUnavailable, fontSize: 14)
    //     ],
    //   ).top.pOnly(left: 10, top: 5),
    //   subtitle: buildExpandableText(widget.post.textContent,
    //           maxLines: 4,
    //           textAlign: widget.post.textContent.isHebrew ? TextAlign.right : TextAlign.left,
    //           textDirection:
    //               widget.post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
    //           style: AppStyles.text16PxRegular.copyWith(color: AppColors.white))
    //       .pOnly(left: 10),
    //   leading: buildProfilePic(context, isUserPage),
    //   // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
    //
    //   trailing: SizedBox(
    //     child: buildMoreMenu(isAdmin, isCurrUser),
    //   ).offset(0, -10),
    // )).pOnly(top: 5).testContainer;
  }

  Row buildProfileRow(String postAgo, bool isAdmin, bool isCurrUser, bool isUserPage) {
    final creatorUser = widget.post.creatorUser;
    final currUser = context.uniProvider.currUser;
    final feedSortBy = context.uniProvider.sortFeedBy.type;
    final currFilter = context.uniProvider.currFilter;
    String title = '';
    String sortFeed = '';
    List<String>? commonTags = [];

    // if (feedSortBy == FilterTypes.sortFeedByAge) sortFeed += '${creatorUser?.age}y.o';
    if (feedSortBy == FilterTypes.sortFeedByTopics &&
        currFilter == FilterTypes.postWithoutComments) {
      // Get 1st - always same (when user refresh indicator)
      // final commonTag = creatorUser?.tags.firstWhereOrNull((tag) => currUser.tags.contains(tag));
      sortFeed += '${widget.post.tag}';
    }

    if (sortFeed.isNotEmpty) title += ' · ';
    title += '${creatorUser?.name?.trim()}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // badge.Badge(
        //   showBadge:
        //   commonCounter != null && commonCounter.isNotEmpty && commonCounter.length != 1,
        //   badgeContent: '+${commonCounter!.length - 1}'
        //       .toText(fontSize: 7, color: Colors.white, medium: true),
        //   padding: const EdgeInsets.all(3),
        //   elevation: 0,
        //   position: const badge.BadgePosition(start: -10,bottom: 5),
        //   badgeColor: AppColors.greyLight.withOpacity(0.85),
        // child:
        SizedBox(
            // width: postAgo.length > 5 ? 150 : 190,
            width: 165,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: sortFeed,
                    style:
                        AppStyles.text12PxMedium.copyWith(fontSize: 13, color: AppColors.greyLight),
                  ),
                  TextSpan(
                    text: title,
                    style: AppStyles.text12PxMedium.copyWith(fontSize: 13, color: AppColors.white),
                  ),
                ],
              ),
            )),
        // ),
        const Spacer(),
        postAgo.toText(color: AppColors.greyUnavailable, fontSize: 13),
        buildMoreMenu(isAdmin, isCurrUser)
      ],
    );
  }

  Widget buildMoreMenu(bool isAdmin, bool isCurrUser) {
    return SizedBox(
      height: 15,
      child: PopupMenuButton(
          padding: EdgeInsets.zero,
          constraints: null,
          // icon: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50),
          // icon: Icons.more_horiz.icon(size: 24, color: AppColors.darkOutline50),
          icon: Icons.more_horiz.icon(size: 24, color: AppColors.greyUnavailable),
          shape: 10.roundedShape,
          color: AppColors.lightOutline50,
          itemBuilder: (context) {
            return [
              if (widget.report != null)
                PopupMenuItem(
                  child: 'Cancel Report'.toText(),
                  onTap: () async {
                    reportRilOrCommentPopup(context, widget.post, report: widget.report);
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
                        deleteRilOrCommentPopup(context, widget.post, report: widget.report);
                      }
                    //> Open Report POPUP
                    : () async {
                        print('SETTINGS REPORT CLICKED');
                        reportRilOrCommentPopup(context, widget.post, report: widget.report);
                      },
              ),
            ];
          }),
    ).offset(0, -1);
  }

  Widget buildProfilePic(BuildContext context, bool isUserPage) {
    return Stack(
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
    ).onTap(
        isUserPage
            ? null
            : () {
                print('PROFILE CLICKED');
                context.router.push(UserRoute(user: widget.post.creatorUser!));
              },
        radius: 5);
  }

  Widget buildActionRow(BuildContext context) {
    var isLiked = widget.post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var buttonColor = AppColors.greyLight;
    // var buttonColor = AppColors.darkOutline50;
    var commentEmpty = widget.post.commentsLength == 0;
    var title = commentEmpty ? 'New' : '${widget.post.commentsLength} comments';
    var isConversation = widget.post.enableComments && widget.post.originalPostId == null;
    var isComment = widget.post.originalPostId != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isConversation
            ? _buildCommentsCounter(commentEmpty, title, buttonColor).py(6)
            : const SizedBox(height: 0),
        if (isComment && widget.report != null) buildOriginalPostButton(buttonColor),
        // if(isConversation)
        const Spacer(),
        isConversation
            ? Assets.svg.icons.shareArrowWide
                .svg(height: 14, color: buttonColor)
                .pOnly(left: 18, right: 18)
                .py(11)
                .onTap(() {
                DynamicLinkService.sharePostLink(post: widget.post);
              }, radius: 5)
            : const Offstage(),
        if (widget.post.creatorUser!.uid != currUser.uid) ...[
          // TODO ADD ON POST MVP ONLY (Send like)
          // // Like Button
          // buildHeartIcon(isLiked),
          // // Divider

          // Container(height: 20, width: 2, color: AppColors.darkOutline50)
          //     .customRowPadding)
          //     .roundedFull,

          isConversation
              ? const Offstage()

              //~ Reply button
              : Row(
                  children: [
                    Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: buttonColor),
                    7.horizontalSpace,
                    // 'Reply'.toText(fontSize: 12, color: iconColor),
                    'Chat'.toText(fontSize: 12, color: buttonColor, medium: true),
                  ],
                ).pOnly(right: 15).onTap(() {
                  ChatService.openChat(context,
                      otherUser: widget.post.creatorUser!, postReply: widget.post);
                }, radius: 10),
        ]
      ],
    )
        // .customRowPadding
        ;
  }

  Widget buildOriginalPostButton(Color iconColor) {
    var isLoading = false;
    return StatefulBuilder(builder: (context, buttonState) {
      return (isLoading ? 'Loading...' : 'Original Ril')
          .toText(fontSize: 12, color: iconColor, underline: true)
          .pOnly(right: 20, left: 12)
          .customRowPadding
          .onTap(() async {
        isLoading = true;
        buttonState(() {});
        var post = await FeedService.getPostById('${widget.post.originalPostId}');
        isLoading = false;
        buttonState(() {});
        handleShowBottomPost(context, post!); // Original post comment.
      }, radius: 10);
    });
  }

  Widget _buildCommentsCounter(bool commentEmpty, String title, Color buttonColor) {
    return Container(
      color: commentEmpty ? AppColors.lightOutline50 : AppColors.transparent,
      child: Row(
        children: [
          // TODO Add notification dot here
          if (notificationCounter != 0) ...[
            //~ Beside new notification in the feed screen
            const CircleAvatar(backgroundColor: AppColors.yellowAlert, radius: 3.5),
            const SizedBox(width: 7),
          ],

          // if(!commentEmpty)
          (commentEmpty ? Assets.svg.icons.wisdomLightStar : Assets.svg.icons.messageSmile).svg(
              height: commentEmpty ? 14 : 17,
              color: commentEmpty ? AppColors.primaryOriginal : buttonColor),
          // if(!commentEmpty)
          SizedBox(width: commentEmpty ? 4 : 5),
          // 'available soon'
          title.toText(
            color: commentEmpty ? AppColors.primaryOriginal : buttonColor,
            fontSize: 12,
            medium: !commentEmpty,
          )
        ],
      ).px(commentEmpty ? 7 : 1).py(4),
    ).roundedFull.pOnly(bottom: 0, top: 0);
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

void reportRilOrCommentPopup(BuildContext context, PostModel post, {ReportModel? report}) {
  final isReported = report != null;
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
              if (isReported) {
                Database.deleteDoc(collection: 'reports/Reported rils/rils', docName: report.id);
              } else {
                var nameEndAt = post.textContent.length < 20 ? post.textContent.length : 20;
                var docName = 'REPORT:'
                    '${post.textContent.substring(0, nameEndAt).toString() + UniqueKey().toString()}';

                var postReport = ReportModel(
                  id: docName,
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
              }

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

void deleteRilOrCommentPopup(
  BuildContext context,
  PostModel post, {
  ReportModel? report,
  Function? onDelete,
}) {
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
              if (report != null) {
                Database.deleteDoc(collection: 'reports/Reported rils/rils', docName: report.id);
              }
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
  // var isOnline = user.uid == context.uniProvider.currUser.uid ||
  //     (context.uniProvider.onlineUsers ?? []).contains(user.email ?? '');

  return user.isOnline
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
      backgroundColor: AppColors.greenOld.withOpacity(0.45),
      child: FadeTransition(
        opacity: _animationController,
        child: CircleAvatar(
          radius: size,
          backgroundColor: AppColors.greenOld,
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
  String postAgo = 'X';

  if (postDiff.inHours >= 24) {
    // postAgo = intl.DateFormat('yMMMMEEEEd').format(post.timestamp!);
    // postAgo = intl.DateFormat('MMMM d, y').format(time);
    postAgo = intl.DateFormat('MMM d').format(time);
  }
  if (postDiff.inHours <= 24) postAgo = '${postDiff.inHours}h';
  if (postDiff.inMinutes <= 60) postAgo = '${postDiff.inMinutes}m';
  if (postDiff.inSeconds <= 60) postAgo = '${postDiff.inSeconds}s';
  if (postDiff.inSeconds <= 5) postAgo = 'Just now';

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
