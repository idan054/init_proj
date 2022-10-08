import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/mixins/fonts.gen.dart';
import '../../common/models/post/post_model.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';

class PostView extends StatelessWidget {
  final PostModel post;
  PostView(this.post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double postRatio = 3;
    bool isLiked = false;

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onDoubleTap: () {
          setState(() => isLiked = !isLiked);
        },
        child: Stack(
          children: [
            Container(
              height: 100 * postRatio,
              color: post.colorCover,
              child: Text(post.textContent,
                      textAlign: TextAlign.center,
                      style: AppStyles.text18PxBold.copyWith(
                          fontSize: 14,
                          fontFamily: FontFamily.rilTopia,
                          color: post.isDarkText
                              ? AppColors.darkBlack
                              : AppColors.white))
                  .pOnly(right: 5, left: 5)
                  .center,
            ),
            buildBottomPost(postRatio, isLiked).offset(0, 10),
          ],
        ),
      );
    });
  }

  Container buildBottomPost(double postRatio, bool isLiked) {
    return Container(
      // color: AppColors.testGreen,
      alignment: Alignment.bottomCenter,
      height: 100 * postRatio,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.01, 0.25],
          colors: [
            AppColors.darkBlack.withOpacity(0.40),
            AppColors.transparent,
          ],
        ),
      ),
      child: StatefulBuilder(builder: (context, stfSetState) {
        return ListTile(
            onTap: () {
              // U might change this view to STF & add the update on dispose()
              // Todo: Add like update on feed_services.dart
              stfSetState(() => isLiked = !isLiked);
            },
            horizontalTitleGap: 0.0,
            minVerticalPadding: 0.0,
            contentPadding: const EdgeInsets.only(left: 10, right: 0),
            leading: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('${post.creatorUser.photoUrl}'),
              backgroundColor: AppColors.darkBlack.withOpacity(0.33),
            ).pOnly(right: 5),
            title: '${post.creatorUser.name}'.toText(fontSize: 13),
            subtitle: Row(
              children: [
                '${post.timestamp.hour}:'
                        '${post.timestamp.minute.toString().length == 1 ? '0' : ''}'
                        '${post.timestamp.minute}'
                    .toText(
                        bold: true, fontSize: 10, color: AppColors.greyLight),
                const Spacer(),
                if (post.enableLikes &&
                    post.likeCounter != null &&
                    post.likeCounter != 0)
                  '${isLiked ? post.likeCounter! + 1 : post.likeCounter}  '
                      .toText(
                          bold: true,
                          fontSize: isLiked ? 11 : 10,
                          color:
                              isLiked ? AppColors.white : AppColors.greyLight),
                if (post.enableLikes)
                  isLiked
                      ? FontAwesomeIcons.solidHeart
                          .iconAwesome(size: 12)
                          .offset(0, 2)
                      : FontAwesomeIcons.heart
                          .iconAwesome(size: 12)
                          .offset(0, 2),
              ],
            ).offset(0, -8).pOnly(right: 10));
      }),
    );
  }
}
