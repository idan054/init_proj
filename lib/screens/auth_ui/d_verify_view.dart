import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import '../feed_ui/user_screen.dart';
import 'a_onboarding_screen.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool verifiedOnly = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        200.verticalSpace,
        'Quick verify, so\neveryone will trust you'
            .toText(fontSize: 18, medium: true, textAlign: TextAlign.center),
        40.verticalSpace,
        SizedBox(
          height: 200,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(color: AppColors.darkOutline50, height: 240, width: 140)
                  .rounded(radius: 10),
              // Spacer(),
              25.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildVerifyBadge(
                      child: buildRilChip('Male', icon: Assets.svg.icons.manProfile.svg())),
                  18.verticalSpace,
                  _buildVerifyBadge(
                      child: buildRilChip('19 y.o', icon: Assets.svg.icons.dateTimeCalender.svg())),
                  const Spacer(),
                  Text(
                    '< Go back',
                    style: AppStyles.text12PxRegular.copyWith(
                      color: AppColors.grey50,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            ],
          ).px(40),
        ),
        30.verticalSpace,
        StatefulBuilder(builder: (context, stfSetState) {
          return ListTile(
            title: 'Verified members only'.toText(fontSize: 13, medium: true),
            isThreeLine: true,
            horizontalTitleGap: 0,
            contentPadding: EdgeInsets.zero,
            // visualDensity: VisualDensity.compact,
            subtitle:
                'Show only Rils of verified members'.toText(color: AppColors.grey50, fontSize: 11),
            leading: Assets.svg.icons.checkVerifiedOutline.svg(height: 25, color: AppColors.grey50),
            trailing: Switch.adaptive(
              // activeColor: AppColors.darkOutline,
              // activeTrackColor: AppColors.grey50,

              // inactiveThumbColor: AppColors.darkOutline,
              // inactiveTrackColor: AppColors.primaryDark,
              value: verifiedOnly,
              onChanged: (bool value) {
                verifiedOnly = value;
                stfSetState(() {});
              },
            ),
          ).px(25);
        }),
      ],
    );
  }

  Badge _buildVerifyBadge({required Widget child}) {
    return Badge(
        position: BadgePosition.topEnd(end: -10, top: -10),
        badgeColor: AppColors.darkOutline50,
        padding: 4.all,
        badgeContent: Assets.svg.icons.checkVerifiedOutline.svg(height: 15,
            // color: AppColors.white
        ),
        child: child);
  }
}
