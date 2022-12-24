import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Chat/chat_services.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../common/models/post/post_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/mixins/fonts.gen.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../screens/main_ui/dashboard_screen.dart';

class PostBlock extends StatelessWidget {
  final PostModel post;

  const PostBlock(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      margin: const EdgeInsets.symmetric(vertical: 1.5),
      color: AppColors.darkBg,
      child: Column(
        children: [
          buildProfile(),
          Text('let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already ',
                  style: AppStyles.text18PxMedium.copyWith(color: AppColors.grey50, fontSize: 12))
              .pOnly(right: 16),
          const SizedBox(height: 12),
          buildActionRow(context),
          const SizedBox(height: 8),
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
      leading: CircleAvatar(
        backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
        backgroundColor: AppColors.darkOutline,
      ),
      trailing:
          Assets.svg.moreVert.svg(height: 17, color: AppColors.grey50).px(6).pad(12).onTap(() {}),
    );
  }

  Row buildActionRow(BuildContext context) {
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);
    return Row(
      children: [
        StatefulBuilder(builder: (context, stfSetState) {
          return Assets.svg.icons.heartUntitledIcon
              .svg(height: 17, color: isLiked ? AppColors.likeRed : null)
              .pad(12)
              .onTap(() {
            isLiked = !isLiked;
            // Todo Connect to server!
            stfSetState(() {});
          });
        }),
        Assets.svg.icons.shareClassicUntitledIcon.svg(height: 17).pad(12).onTap(() {}),
        Row(
          children: [
            Assets.svg.icons.commentUntitledIcon.svg(height: 17).pOnly(right: 6),
            '5'.toText(color: AppColors.grey50, fontSize: 12),
          ],
        ).pad(12).onTap(() {}),
        Spacer(),
        OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2.0, color: AppColors.darkOutline),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
            ),
            onPressed: () {},
            icon: Assets.svg.icons.dmPlaneUntitledIcon.svg(height: 17),
            label: 'DM'.toText(fontSize: 12))
      ],
    );
  }
}
