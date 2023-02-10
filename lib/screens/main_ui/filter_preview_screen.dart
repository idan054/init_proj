// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
import 'dart:async';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/report/report_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/screens/feed_ui/main_feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share/share.dart';
import '../../common/extensions/color_printer.dart';
import '../../common/models/post/post_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_styles.dart';
import 'dart:io' show Platform;

import '../../widgets/components/feed/buildFeed.dart';
import '../../widgets/components/postBlock_stf.dart';
import '../../widgets/components/reported_user_block.dart';
import '../../widgets/my_widgets.dart';

class FilterPreviewScreen extends StatefulWidget {
  const FilterPreviewScreen({Key? key}) : super(key: key);

  @override
  State<FilterPreviewScreen> createState() => _FilterPreviewScreenState();
}

class _FilterPreviewScreenState extends State<FilterPreviewScreen> {
  var index = 0;
  var images = [
    Assets.images.filterPreviewFull1,
    Assets.images.filterPreviewFull2,
    Assets.images.filterPreviewFull3,
    Assets.images.filterPreviewFull4,
  ];

  @override
  void initState() {
    // Timer.periodic(4.seconds, (timer) {
    //   index++;
    //   if (index == 4) index = 0;
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('START: AdminScreen()');

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: Column(
        children: [
          images[3].image().advancedSizedBox(context).appearOpacity,
          30.verticalSpace,
          Column(
            children: [
              Assets.svg.icons.wisdomMultiLightStar.svg(color: AppColors.white, height: 22),
              10.verticalSpace,
              'Filters will be available soon!'.toText(fontSize: 18, medium: true),
              10.verticalSpace,
              'by Interests, Age, Gender, Distance...'
                  .toText(fontSize: 13, color: AppColors.grey50, textAlign: TextAlign.center),
              2.verticalSpace,
              'Share & Rate us to support'
                  .toText(fontSize: 13, color: AppColors.grey50, textAlign: TextAlign.center),
            ],
          ).appearAll,
          60.verticalSpace,
          rilClassicButton(
            context,
            radius: 99,
            padding: 35,
            isWide: true,
            icon: Assets.images.logoCircularRilTopiaLogo.image(height: 25),
            title: 'Share RilTopia',
            bgColor: AppColors.white,
            textColor: AppColors.darkBg,
            onPressed: () => Share.share('https://rebrand.ly/RiTopia-7d448'),
          ),
          20.verticalSpace,
          rilClassicButton(
            context,
            radius: 99,
            padding: 35,
            isWide: true,
            title: 'Just Rate us',
            bgColor: AppColors.transparent,
            borderColor: AppColors.white,
            textColor: AppColors.white,
            onPressed: () async {
              final inAppReview = InAppReview.instance;
              var isAvailable = await inAppReview.isAvailable();
              if (isAvailable) inAppReview.requestReview();
            },
          ),
          20.verticalSpace,
          'Go back, I don\'t want to support'
              .toText(
                  fontSize: 11,
                  color: AppColors.grey50,
                  textAlign: TextAlign.center,
                  underline: true)
              .pad(4)
              .onTap(() {
            Navigator.pop(context);
          }, radius: 5),
        ],
      ),
    );
  }
}
