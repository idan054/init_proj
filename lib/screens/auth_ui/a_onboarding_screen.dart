import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import 'b_name_profile_view.dart';
import 'c_gender_age_view.dart';
import 'd_verify_view.dart';
import 'e_tags_view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with TickerProviderStateMixin {
  TabController? _tabController;

  // int _index = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    super.initState();
  }

  _handleTabSelection() {
    //   _index = _tabController!.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // implement the tab view
          Column(
            children: [
              100.verticalSpace,
              riltopiaHorizontalLogo(ratio: 1.2),
              50.verticalSpace,
            ],
          ).center,
          TabBarView(
            controller: _tabController,
            children: const [
              NameProfileView(),
              GenderAgeView(),
              VerifyView(),
              TagsView(),
            ],
          ),
          // implement the dots indicator
          Builder(builder: (context) {
            bool verifyView = _tabController!.index == 2;
            return Positioned(
              bottom: verifyView ? 60 : 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  TabPageSelector(
                    controller: _tabController,
                    indicatorSize: 8,
                    selectedColor: Colors.white,
                    color: Colors.grey,
                    borderStyle: BorderStyle.none,
                  ).center,
                  25.verticalSpace,
                  wMainButton(context,
                      radius: 99,
                      isWide: true,
                      title: 'Next',
                      color: AppColors.white,
                      textColor: AppColors.darkBg, onPressed: () {
                    _tabController!.animateTo(_tabController!.index + 1);
                  }),
                  if (verifyView)
                    Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 20,
                            child: 'Thanks, I don’t want verification'
                                .toText(fontSize: 15, color: AppColors.darkOutline50)).appearOpacity,
                      ],
                    )
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

var fieldBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.darkOutline50, width: 2),
    borderRadius: BorderRadius.circular(10));

Widget rilTextField({required String label, required String hint, double px = 20}) {
  return TextField(
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: label,
              hintText: hint,
              labelStyle: AppStyles.text16PxMedium.copyWith(color: AppColors.darkOutline50),
              hintStyle: AppStyles.text14PxMedium.copyWith(color: AppColors.white),
              enabledBorder: fieldBorderDeco,
              focusedBorder: fieldBorderDeco))
      .px(px);
}
