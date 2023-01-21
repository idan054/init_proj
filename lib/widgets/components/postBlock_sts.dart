// ignore_for_file: no_leading_underscores_for_local_identifiers, sort_child_properties_last

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
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
import '../../common/service/Database/firebase_database.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../screens/feed_ui/user_screen.dart';
import '../../screens/main_ui/dashboard_screen.dart';
import 'dart:io';

import '../clean_snackbar.dart';
import '../my_dialog.dart';

// Also look for 'customRowPadding' With CTRL + SHIFT + F

class PostBlock extends StatelessWidget {
  final PostModel post;
  final bool isOnUserPage;

  const PostBlock(this.post, {this.isOnUserPage = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          buildProfile(context, isOnUserPage), // Doesn't require 55 Left padding.
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
    ).onTap(() {}, radius: 10);
  }

  Widget buildProfile(BuildContext context, bool isOnUserPage) {
    var currUser = context.uniProvider.currUser;
    var isCurrUser = currUser.uid == post.creatorUser!.uid;

    var postDiff = DateTime.now().difference(post.timestamp!);
    var postAgo =
        postDiff.inSeconds < 60 ? '${postDiff.inSeconds} sec ago' : '${postDiff.inMinutes} min ago';
    if (postDiff.inSeconds == 0) postAgo = 'Just now';

    return
      SizedBox(
      height: 68,
      // height: 72, // 72: original size 60: min size
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
        title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.white),
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
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
              backgroundColor: AppColors.darkOutline,
            ),
            buildOnlineBadge(),
          ],
        ),
        // trailing: (isCurrUser ? Assets.svg.icons.trash03 : Assets.svg.moreVert)
        trailing: PopupMenuButton(
            icon: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50),
            shape: 10.roundedShape,
            color: AppColors.darkOutline50,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: (isCurrUser ? 'Delete Ril' : 'Report Ril').toText(),
                  onTap: isCurrUser
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
      ).pad(0).onTap(
          isOnUserPage
              ? null
              : () {
                  print('PROFILE CLICKED');
                  context.router.push(UserRoute(user: post.creatorUser!));
                },
          radius: 5),
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

                Database().updateFirestore(
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
    Future.delayed(150.milliseconds).then((_) {
      showRilDialog(context,
          title: 'Delete your Ril?',
          desc: '"${post.textContent}"'.toText(fontSize: 13),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () {
                Database().deleteDoc(collection: 'posts', docName: post.id);
                Navigator.of(context).pop();
                rilFlushBar(context, 'Your Ril has been deleted forever');
              },
              child: 'Delete'.toText(color: AppColors.primaryLight)));
    });
  }

  Widget buildActionRow(BuildContext context) {
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var iconColor = Colors.white60;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.enableComments
            ? '5 comments'
                .toText(color: AppColors.grey50, fontSize: 12)
                .pOnly(left: 0, right: 12)
                .customRowPadding
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
          Row(
            children: [
              Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: iconColor),
              10.horizontalSpace,
              'Reply'.toText(fontSize: 12, color: iconColor),
            ],
          )
              .pOnly(
                right: 20,
                left: 12,
              )
              .customRowPadding
              .onTap(() {
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
    _animationController = AnimationController(vsync: this, duration: 3.seconds);
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = widget.ratio * 4.0;
    return CircleAvatar(
      radius: size,
      backgroundColor: AppColors.green.withOpacity(0.20),
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
