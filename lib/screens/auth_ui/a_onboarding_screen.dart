// ignore_for_file: non_constant_identifier_names

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/routes/app_router.gr.dart';
import '../../common/service/Database/firebase_database.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/my_dialog.dart';
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
    _tabController = TabController(length: 3, vsync: this);
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
          Form(
            key: registerFormKey,
            child: TabBarView(
              controller: _tabController,
              // This needed to make sure user fill the info.
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                NameProfileView(),
                GenderAgeView(),
                // VerifyView(_tabController!), // TODO ADD ON POST MVP ONLY: VerifyView()
                TagsView(),
              ],
            ),
          ),
          buildTopBar(context),
          buildPageIndicator(),
        ],
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Column(
      children: [
        90.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            10.horizontalSpace,
            IconButton(
                icon: Assets.svg.icons.arrowNarrowLeft.svg(color: AppColors.darkOutline50),
                onPressed: () {
                  if (_tabController!.index == 0) {
                    context.router.replaceAll([const LoginRoute()]);
                  } else {
                    _tabController!.animateTo(_tabController!.index - 1);
                  }
                }),
            const Spacer(),
            riltopiaHorizontalLogo(ratio: 1.2),
            const Spacer(),
            // PlaceHolder:
            Opacity(
                opacity: 0.0,
                child: IconButton(
                    icon: Assets.svg.icons.arrowNarrowLeft.svg(color: AppColors.white),
                    onPressed: () {})),
            10.horizontalSpace,
          ],
        ),
        50.verticalSpace,
      ],
    ).center;
  }

  Widget buildPageIndicator() {
    // var isLoading = context.listenUniProvider.isLoading; // This will auto rebuild if err found.

    if (MediaQuery.of(context).viewInsets.bottom != 0.0) {
      return const Offstage();
    }

    return Builder(builder: (context) {
      bool nameProfile_b_View = _tabController!.index == 0;
      bool genderAge_c_View = _tabController!.index == 1;
      bool verify_d_View = _tabController!.index == 404; // AKA unavailable yet..
      bool tags_e_View = _tabController!.index == 2;
      return Positioned(
        bottom: verify_d_View ? 60 : 100,
        left: 0,
        right: 0,
        child: Column(
          children: [
            TabPageSelector(
              controller: _tabController,
              indicatorSize: 8,
              selectedColor: AppColors.white,
              color: AppColors.darkOutline50,
              borderStyle: BorderStyle.none,
            ).center,
            25.verticalSpace,
            wMainButton(context,
                radius: 99,
                isWide: true,
                // title: isLoading ? 'Loading... ' : tags_e_View ? "Let's Start!" : 'Next ',
                title: tags_e_View ? "Let's Start!" : 'Next ',
                color: AppColors.white,
                textColor: AppColors.darkBg, onPressed: () {
              context.uniProvider.updateErrFound(false);

              // Image validation
              var currUser = context.uniProvider.currUser;
              var imageErr = nameProfile_b_View && (currUser.photoUrl == null || currUser.photoUrl!.isEmpty);
              var tagsErr = tags_e_View && (currUser.tags.isEmpty);
              if (imageErr || tagsErr) context.uniProvider.updateErrFound(true);

              // formKey - Name, Age, Gender validation
              var validState = registerFormKey.currentState!.validate();
              if (!validState || imageErr || tagsErr) {
                return; // AKA ERR;
              }

              if (genderAge_c_View) {
                var user = context.uniProvider.currUser;
                var gender = user.gender == GenderTypes.other ? '🏳️‍🌈 Other' : user.gender?.name;
                var title = "You're ${user.age} y.o $gender";
                showRilDialog(context,
                    title: title,
                    desc: "You can't change your age & gender later".toText(fontSize: 13),
                    secondaryBtn: TextButton(
                        child: 'Confirm'.toText(color: AppColors.primaryLight),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Future.delayed(150.milliseconds)
                              .then((_) => _tabController!.animateTo(_tabController!.index + 1));
                        }));
                return;
              }

              if (tags_e_View) {
                // print('currUser ${currUser.toJson()}');
                Database().updateFirestore(
                    collection: 'users',
                    docName: '${currUser.email}',
                    toJson: context.uniProvider.currUser.toJson());
                context.router.replace(DashboardRoute());
                return;
              }

              // Default
              _tabController!.animateTo(_tabController!.index + 1);
            }),
            if (verify_d_View)
              Column(
                children: [
                  const SizedBox(height: 20),
                  // TODO Add R U SURE POPUP
                  SizedBox(
                      height: 20,
                      child: 'Thanks, I don’t want verification'
                          .toText(fontSize: 15, color: AppColors.darkOutline50))
                  // .appearOpacity
                ],
              )
          ],
        ),
      );
    });
  }
}

final registerFormKey = GlobalKey<FormState>();

var fieldBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.darkOutline50, width: 2),
    borderRadius: BorderRadius.circular(10));

var fieldFocusBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.grey50, width: 2.5),
    borderRadius: BorderRadius.circular(10));

var fieldErrBorderDeco = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.errRed, width: 2.5),
    borderRadius: BorderRadius.circular(10));

Widget rilTextField(
    {required String label,
    String? hint,
    double px = 20,
    FocusNode? focusNode,
    // String? errorText,
    int? maxLength,
    TextInputType? keyboardType,
    TextEditingController? controller,
    FormFieldValidator? validator,
    void Function(String)? onChanged}) {
  return TextFormField(
          validator: validator,
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          maxLength: maxLength,
          style: AppStyles.text14PxMedium.copyWith(color: AppColors.white),
          keyboardType: keyboardType,
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: label,
              hintText: hint,
              // labelStyle: AppStyles.text16PxMedium.copyWith(color: errorText != null ? AppColors.errRed : AppColors.darkOutline50),
              labelStyle: AppStyles.text16PxMedium.copyWith(color: AppColors.darkOutline50),
              hintStyle: AppStyles.text14PxMedium.copyWith(color: AppColors.white),
              // errorText: errorText,
              errorBorder: fieldErrBorderDeco,
              enabledBorder: fieldBorderDeco,
              focusedBorder: fieldFocusBorderDeco))
      .px(px);
}
