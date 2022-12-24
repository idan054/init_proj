import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Chat/chat_services.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/main.dart';
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
import '../../screens/main_ui/dashboard_screen.dart';
import 'dart:io';

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
          buildProfile(),
          Column(
            children: [
              Text(
                      // 'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already ',
                      post.textContent,
                      textDirection:
                          post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                      textAlign: TextAlign.start,
                      style:
                          AppStyles.text18PxMedium.copyWith(color: AppColors.white, fontSize: 12))
                  .pOnly(right: 16)
                  .sizedBox(context, maxWidth: true),
              const SizedBox(height: 12),
              buildActionRow(context),
              const SizedBox(height: 8),
            ],
            // ).pOnly(left: 5)
          ).pOnly(left: 55)
        ],
      ).px(15),
    );
  }

  ListTile buildProfile() {
    var postDiff = DateTime.now().difference(post.timestamp!);
    var postAgo =
        postDiff.inSeconds < 60 ? '${postDiff.inSeconds} sec' : '${postDiff.inMinutes} min';

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: '${post.creatorUser?.name}'.toText(fontSize: 14, bold: true),
      subtitle:
          // '$postAgo ago · Gaming'.toText(color: AppColors.grey50, fontSize: 12),
          '2 min ago · Gaming'.toText(color: AppColors.grey50, fontSize: 12),
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
      trailing: Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50).pad(8).onTap(() {}),
    );
  }

  Positioned buildOnlineBadge() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: CircleAvatar(
        radius: 7,
        backgroundColor: AppColors.primaryDark,
        child:
            // STATIC VERSION:
            // CircleAvatar(
            //   radius: 4,
            //   backgroundColor: AppColors.green,
            // ),

            // LIVE VERSION:
            BlinkingOnlineBadge(),
      ),
    );
  }

  Row buildActionRow(BuildContext context) {
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
    var currUser = context.uniProvider.currUser;
    var iconColor = Colors.white60;

    return Row(
      children: [
        StatefulBuilder(builder: (context, stfSetState) {
          return Opacity(
            opacity: isLiked ? 1.0 : 0.5,
            child: Assets.svg.icons.heartUntitledIcon
                .svg(height: 17, color: isLiked ? AppColors.likeRed : null)
                .pOnly(left: 0, right: 12, top: 12, bottom: 12)
                // .pad(12)
                .onTap(() {
              isLiked = !isLiked;
              // Todo Connect to server!
              stfSetState(() {});
            }),
          );
        }),
        Assets.svg.icons.shareClassicUntitledIcon
            .svg(height: 17, color: iconColor)
            .pad(12)
            .onTap(() async {}),
        Row(
          children: [
            Assets.svg.icons.commentUntitledIcon.svg(height: 17, color: iconColor).pOnly(right: 6),
            '5'.toText(color: AppColors.grey50, fontSize: 12),
          ],
        ).pad(12).onTap(() {}),
        const Spacer(),
        if (post.creatorUser!.uid != currUser.uid)
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2.0, color: AppColors.darkOutline),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
            ),
            icon: Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17, color: iconColor),
            label: 'DM'.toText(fontSize: 12, color: iconColor),
            onPressed: () {
              ChatService.openChat(context, otherUser: post.creatorUser!);
            },
          )
      ],
    );
  }
}

class BlinkingOnlineBadge extends StatefulWidget {
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
    return CircleAvatar(
      radius: 4,
      backgroundColor: AppColors.green.withOpacity(0.50),
      child: FadeTransition(
        opacity: _animationController,
        child: const CircleAvatar(
          radius: 4,
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
