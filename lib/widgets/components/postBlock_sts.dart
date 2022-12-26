// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:badges/badges.dart';
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
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../screens/feed_ui/user_screen.dart';
import '../../screens/main_ui/dashboard_screen.dart';
import 'dart:io';

var _rightPadding = 15.0; //> It set this way for the Pressing Area Size!
// Also look for 'customRowPadding' With CTRL + SHIFT + F

class PostBlock extends StatelessWidget {
  final PostModel post;

  const PostBlock(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.primaryDark,
      child: Column(
        children: [
          buildProfile(), // Doesn't require 55 Left padding.
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
                  .pOnly(right: 5 + _rightPadding)
                  .advancedSizedBox(context, maxWidth: true),
              buildActionRow(context),
            ],
            // ).pOnly(left: 5)
          ).pOnly(left: 55)
        ],
      ).pOnly(left: 15),
    ).onTap(() {}, radius: 10);
  }

  Widget buildProfile() {
    var postDiff = DateTime.now().difference(post.timestamp!);
    var postAgo =
        postDiff.inSeconds < 60 ? '${postDiff.inSeconds} sec' : '${postDiff.inMinutes} min';

    return SizedBox(
      height: 65,
      // height: 72, // 72: original size 60: min size
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.grey50),
        title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true, color: AppColors.white),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // '2 min ago · Gaming'
            '$postAgo ago · Gaming'
                .toText(color: AppColors.grey50, fontSize: 12)
                .pOnly(right: 10, top: 4, bottom: 10)
                .onTap(() {}, radius: 10), // TODO Add move to Tag
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
        trailing: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50).pad(18).onTap(() {
          print('POST SETTINGS CLICKED');
        }, radius: 10),
      ).pad(0).onTap(() {
        print('POST SETTINGS CLICKED');
      }, radius: 5),
    );
  }

  Widget buildActionRow(BuildContext context) {
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var iconColor = Colors.white60;


    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        '5 comments'
            .toText(color: AppColors.grey50, fontSize: 12)
            .pOnly(left: 0, right: 12).customRowPadding
        // .onTap(() {}, radius: 10)
        ,
        const Spacer(),
        if (post.creatorUser!.uid != currUser.uid) ...[
          // Like Button
          buildHeartIcon(isLiked),
          // Divider
          Container(height: 20, width: 2, color: AppColors.darkOutline50).customRowPadding.roundedFull,
          // Chat Button
          Row(
            children: [
              Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: iconColor),
              10.horizontalSpace,
              'Chat'.toText(fontSize: 12, color: iconColor),
            ],
          )
              .pOnly(
                right: _rightPadding,
                left: 12,
              ).customRowPadding
              .onTap(() {}, radius: 10)
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
            .pOnly(left: 12, right: 12, bottom: 4).customRowPadding
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

Positioned buildOnlineBadge({bool doubleSize = false}) {
  return Positioned(
    bottom: 0,
    right: 0,
    child: CircleAvatar(
      radius: doubleSize ? 12 : 7,
      backgroundColor: AppColors.primaryDark,
      child:
          // STATIC VERSION:
          // CircleAvatar(
          //   radius: 4,
          //   backgroundColor: AppColors.green,
          // ),

          // LIVE VERSION:
          BlinkingOnlineBadge(doubleSize: doubleSize),
    ),
  );
}

class BlinkingOnlineBadge extends StatefulWidget {
  final bool doubleSize;

  const BlinkingOnlineBadge({this.doubleSize = false, Key? key}) : super(key: key);

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
    var size = widget.doubleSize ? 7.5 : 4.0;
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
