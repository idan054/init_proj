import 'package:badges/badges.dart';
import 'package:example/common/models/user/user_model.dart';
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
    var topPadding = 125.0;
    var user = context.uniProvider.currUser;

    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Column(
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
                    child: Icons.arrow_back_rounded.icon(size: 18, color: AppColors.white),
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
              offset: Offset(0, -(topPadding * 0.40)),
              child: Column(
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
                  16.verticalSpace,
                  '${user.name}'.toText(fontSize: 18, bold: true),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Badge(
                          badgeContent: '+2'.toText(fontSize: 10),
                          padding: const EdgeInsets.all(5),
                          elevation: 0,
                          badgeColor: AppColors.darkOutline50,
                          // stackFit: StackFit.loose,
                          // shape:
                          child: buildChip('Gaming')),
                      18.horizontalSpace,
                      buildChip('${user.gender?.name}', icon: Assets.svg.icons.manProfile.svg()),
                      18.horizontalSpace,
                      buildChip('${user.age} y.o', icon: Assets.svg.icons.dateTimeCalender.svg()),
                    ],
                  ),
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
      label: label.toText(fontSize: 13),
      avatar: icon,
      shape: 10.roundedShape,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
