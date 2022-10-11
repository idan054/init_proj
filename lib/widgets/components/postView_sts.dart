import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/service/Chat/chat_services.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // likeByIds.contains is the initial. (isLiked will change when click)
    var isLiked = post.likeByIds.contains(context.uniProvider.currUser.uid);

    TextAlign? postAlign; // Todo: Frontend so Hebrew will be only center || right Based .isHebrew
    if (post.textAlign == 'right') postAlign = TextAlign.end;
    if (post.textAlign == 'center') postAlign = TextAlign.center;
    if (post.textAlign == 'right') postAlign = TextAlign.end;

    return StatefulBuilder(builder: (context, setState) {
      return GestureDetector(
        onDoubleTap: () {
          // FeedService().setPostLike(context, post, isLiked);
          // setState(() => isLiked = !isLiked);
        },
        child: Stack(
          children: [
            Container(
                height: 100 * postRatio,
                width: context.width /2,
                color: post.colorCover,
                child:
                Text(post.textContent,
                    textAlign: postAlign,
                    softWrap: true,
                    maxLines: 15,
                    style: AppStyles.text18PxBold.copyWith(
                        fontSize: 14,
                        fontFamily: FontFamily.rilTopia,
                        color: post.isDarkText
                            ? AppColors.darkBlack
                            : AppColors.white)).px(20)
                    .pOnly(top: post.textContent.length > 230 ? 35 : 0).center
            ),
            buildTop(postRatio, isLiked),
            buildBottom(context, postRatio, isLiked).offset(0, 10),
          ],
        ),
      );
    });
  }
  Container buildTop(double postRatio, bool isLiked) {

    return Container(
      // color: AppColors.testGreen,
      alignment: Alignment.topCenter,
      height: 100 * postRatio,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          stops: const [0.75, 0.99],
          colors: [
            AppColors.transparent,
            AppColors.darkBlack.withOpacity(0.40),
          ],
        ),
      ),
      child: StatefulBuilder(builder: (context, stfSetState) {
        return ListTile(
            onTap: () {
            },
            horizontalTitleGap: 0.0,
            minVerticalPadding: 0.0,
            contentPadding: const EdgeInsets.only(left: 10, right: 0),
            trailing: FontAwesomeIcons.share
                .iconAwesome(size: 18)
                .offset(0, -6).px(10),
          leading: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('${post.creatorUser!.photoUrl}'),
            backgroundColor: AppColors.darkBlack.withOpacity(0.33),
          ).pOnly(right: 5),
            title: post.creatorUser!.name!.toText(
                fontSize: 13, softWrap: true),
            subtitle: Row(
              children: [
                '${post.timestamp!.hour}:'
                    '${post.timestamp!.minute.toString().length == 1 ? '0' : ''}'
                    '${post.timestamp!.minute}'
                    .toText(
                    bold: true, fontSize: 10, color: AppColors.greyLight),
                const Spacer(),
              ],
            ).pOnly(right: 10, top: 0)
        );
      }),
    );
  }

  Container buildBottom(BuildContext context, double postRatio, bool isLiked) {
    var currUser = context.uniProvider.currUser;

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
        final isNewLike = !post.likeByIds.contains(context.uniProvider.currUser.uid);
        return ListTile(
            onTap: () {
              // U might change this view to STF & add the update on dispose()
              // Todo: Add like update on feed_services.dart
              print('isLiked ${isLiked}');
              // likeByIds.contains is a checker. (No change)
              FeedService().setPostLike(context, post, isLiked);
              stfSetState(() => isLiked = !isLiked);
            },
            horizontalTitleGap: 0.0,
            minVerticalPadding: 0.0,
            contentPadding: const EdgeInsets.only(left: 10, right: 0),
            subtitle: Builder(
              builder: (context) {
                var likes = post.likeCounter;
                if(isNewLike && isLiked) likes = post.likeCounter! + 1;
                if(!isNewLike && !isLiked) likes = post.likeCounter! - 1;

                return Row(
                  children: [
                    const Spacer(),

                    //> Like button:
                    if (post.enableLikes && post.likeCounter != null)
                          '${likes == 0 ? '' : likes}'
                              .toText(
                                  bold: true,
                                  fontSize: isLiked ? 11 : 10,
                                  color:
                                      isLiked ? AppColors.white : AppColors.greyLight).offset(0, 2),

                    if (post.enableLikes)
                      isLiked
                          ? FontAwesomeIcons.solidHeart
                              .iconAwesome(size: 18)
                              .offset(0, 2)
                          : FontAwesomeIcons.heart
                              .iconAwesome(size: 18)
                              .offset(0, 2),


                    //> DM / Comment button:
                    // if(post.enableComments)
                    //   '12'.toText(
                    //       bold: true,
                    //       fontSize: isLiked ? 11 : 10,
                    //       color:
                    //       isLiked ? AppColors.white : AppColors.greyLight).offset(4, 2),
                    // if(post.enableComments)
                    //   FontAwesomeIcons.commentDots
                    //       .iconAwesome(size: 12)
                    //       .offset(0, 2).pOnly(left: 10),

                    if(post.enableComments == false && post.creatorUser!.uid != currUser.uid)...[
                    FontAwesomeIcons.solidPaperPlane
                        .iconAwesome(size: 18).pOnly(right: 5, left: 20).ltr.onTap(() =>
                            ChatService().openChat(context, otherUser: post.creatorUser!)),
                    ]
                  ],
                ).offset(0, -8).pOnly(right: 10);
              }
            )
        );
      }),
    );
  }
}
