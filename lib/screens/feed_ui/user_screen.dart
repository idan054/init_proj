import 'package:badges/badges.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';

// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common/models/post/post_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/components/postBlock_sts.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    print('START: PostScreen()');
    var topPadding = 100.0;
    var user = context.uniProvider.currUser;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        body: ListView(
          children: [
            Container(
              height: topPadding,
              color: AppColors.darkOutline,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.darkOutline50,
                    // child: Icons.arrow_back_rounded.icon(size: 18, color: AppColors.white),
                    child: Assets.svg.icons.arrowBackLeft.svg(height: 14, color: AppColors.white),
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.darkOutline50,
                    child: Assets.svg.moreVert.svg(height: 18, color: AppColors.white),
                  ).onTap(() {}),
                ],
              ).px(20),
            ),
            Transform.translate(
              offset: Offset(0, -(topPadding * 0.50)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 46,
                            backgroundColor: AppColors.darkOutline,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(user.photoUrl!),
                              backgroundColor: AppColors.darkGrey,
                            ).center,
                          ),
                          buildOnlineBadge(doubleSize: true),
                        ],
                      ),
                      16.verticalSpace,
                      '${user.name}'.toText(fontSize: 18, medium: true),
                      20.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Badge(
                              badgeContent:
                                  '+2'.toText(fontSize: 10, color: Colors.white70, medium: true),
                              padding: const EdgeInsets.all(5),
                              elevation: 0,
                              badgeColor: AppColors.darkOutline50,
                              // stackFit: StackFit.loose,
                              // shape:
                              child: buildChip('Gaming')),
                          18.horizontalSpace,
                          buildChip('${user.gender?.name}',
                              icon: Assets.svg.icons.manProfile.svg()),
                          18.horizontalSpace,
                          buildChip('${user.age} y.o',
                              icon: Assets.svg.icons.dateTimeCalender.svg()),
                        ],
                      ),
                      20.verticalSpace,
                      ExpandableText(
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already '
                          'let’s try to think of an interesting topic or fdsk conte to fill this post  with many fdsh fh feaiufe fwhsu fc words as possible... I think I’ve already ',
                          maxLines: 5,
                          expandText: 'Expand',
                          collapseText: 'Collape',
                          animation: true,
                          animationDuration: 1000.milliseconds,
                          // overflow: TextOverflow.ellipsis,
                          // textDirection: post.textContent.isHebrew ? TextDirection.rtl : TextDirection.ltr,
                          textAlign: TextAlign.center,
                          linkStyle: AppStyles.text14PxMedium,
                          style: AppStyles.text14PxRegular.copyWith(color: AppColors.grey50)),
                      24.verticalSpace,
                      SizedBox(
                        width: context.width * 0.5,
                        height: 40,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            // side: const BorderSide(width: 2.0, color: AppColors.darkOutline),
                            shape: 10.roundedShape,
                          ),
                          icon: Assets.svg.icons.dmPlaneUntitledIcon
                              .svg(height: 17, color: AppColors.darkBg),
                          label:
                              'Send DM'.toText(fontSize: 13, color: AppColors.darkBg, bold: true),
                          onPressed: () {},
                        ),
                      ),
                      16.verticalSpace,
                      Row(
                        children: [
                          Assets.svg.icons.groupMultiPeople
                              .svg(width: 17, color: Colors.white70)
                              .pOnly(right: 10),
                          "You both interesting in Gaming... that's cool!"
                              .toText(color: AppColors.grey50, fontSize: 12)
                              .expanded(),
                        ],
                      ),
                    ],
                  ).px(25),
                  12.verticalSpace,
                  const Divider(
                    thickness: 2,
                    color: AppColors.darkOutline,
                  ),
                  "${user.name}'s Rils"
                      .toText(fontSize: 18, medium: true)
                      .centerLeft
                      .py(12)
                      .px(25)
                      .pOnly(bottom: 4),
                  // const Divider(
                  //   thickness: 2,
                  //   color: AppColors.darkOutline,
                  // ),
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 16,
                      itemBuilder: (BuildContext context, int i) {
                        // PostView(postList[i])
                        var post = PostModel(
                          id: 'TEST',
                          creatorUser: user,
                          enableComments: true,
                          isSubPost: false,
                          textContent: 'This is just A Test Off example user\'s post',
                          likeByIds: [],
                          timestamp: DateTime.now(),
                        );
                        return PostBlock(post);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChip(String label, {Widget? icon}) {
    return Chip(
      backgroundColor: AppColors.darkOutline,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      // side: BorderSide(width: 2.0, color: AppColors.transparent),
      label: label.toText(fontSize: 13, color: Colors.white70),
      avatar: icon,
      shape: 10.roundedShape,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
