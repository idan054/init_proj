// ignore_for_file: avoid_print
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:example/delete_me.dart';
import 'package:example/screens/auth_ui/widgets/camera_widget.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import '../user_ui/user_screen.dart';
import 'a_onboarding_screen.dart';

class VerifyView extends StatefulWidget {
  final TabController tabController;

  const VerifyView(this.tabController, {Key? key}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  CameraController? camController;
  XFile? capturedImage;
  bool permissionDenied = false;

  Future<XFile?> takeShot(StateSetter stfState) async {
    if (camController!.value.isTakingPicture) return null;

    try {
      capturedImage = await camController!.takePicture();
      stfState(() {});
      return capturedImage;
    } on CameraException catch (e) {
      print('Error occurred while taking picture: $e');
      return null;
    }
  }

  Future initCamera(StateSetter stfState) async {
    var cams = await availableCameras();
    var i = cams.indexWhere((cam) => cam.lensDirection == CameraLensDirection.front);
    camController = CameraController(cams[i], ResolutionPreset.high, enableAudio: false);

    try {
      await camController!.initialize();
      permissionDenied = false;
      stfState(() {});
    } catch (e) {
      debugPrint("camera error $e");
      permissionDenied = true;
      await openAppSettings();
      stfState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    bool verifiedOnly = true;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          190.verticalSpace,
          'Quick verify, so\neveryone will trust you'
              .toText(fontSize: 18, medium: true, textAlign: TextAlign.center),
          10.verticalSpace,
          // "This what makes us a reliable & safe place".toText(color: AppColors.grey50, fontSize: 11),
          "And you will know every member is Ril".toText(color: AppColors.grey50, fontSize: 11),
          40.verticalSpace,
          SizedBox(
            height: 200,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatefulBuilder(builder: (context, stfState) {
                  var camAvailable = camController != null && camController!.value.isInitialized;
                  var imageAvailable = capturedImage != null;
                  return Stack(
                    children: [
                      Container(
                              color: AppColors.lightOutline50,
                              height: 240,
                              width: 140,
                              child: imageAvailable
                                  ? Image.file(File(capturedImage!.path)).appearScale
                                  : camAvailable
                                      ? CameraWidget(camController!)
                                      : buildCameraPlaceHolder())
                          .rounded(radius: 10)
                          .onTap(() {
                        initCamera(stfState);
                      }),
                      if (camAvailable) buildTakeShotButton(imageAvailable, stfState, camAvailable)
                    ],
                  );
                }),
                // Spacer(),
                25.horizontalSpace,
                buildGenderAgeTags(),
              ],
            ).px(40),
          ),
          20.verticalSpace,
          StatefulBuilder(builder: (context, stfSetState) {
            return ListTile(
              horizontalTitleGap: 0,
              contentPadding: EdgeInsets.zero,
              leading:
                  Assets.svg.icons.checkVerifiedOutline.svg(height: 25, color: AppColors.grey50),
              // visualDensity: VisualDensity.compact,
              title: 'Show verified members only'.toText(fontSize: 13),

              // title: 'Verified members only'.toText(fontSize: 13, medium: true),
              // subtitle: 'Show only Rils of verified members'.toText(color: AppColors.grey50, fontSize: 11),
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
      ),
    );
  }

  Positioned buildTakeShotButton(bool imageAvailable, StateSetter stfState, bool camAvailable) {
    return Positioned(
      bottom: 10,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.lightOutline50,
        child: CircleAvatar(
          backgroundColor: AppColors.darkBg,
          radius: 22,
          child: imageAvailable
              ? Icons.close_rounded.icon(size: 20, color: AppColors.white).appearOpacity
              : null,
        ),
      ).onTap(() {
        if (imageAvailable) {
          capturedImage = null;
          stfState(() {});
        } else {
          if (!camAvailable) initCamera(stfState);
          takeShot(stfState);
        }
      }).sizedBox(140, null),
    );
  }

  Container buildCameraPlaceHolder() {
    return Container(
        color: AppColors.darkOutline,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.darkBg,
                child: permissionDenied
                    ? Assets.svg.icons.settings01.svg(color: AppColors.lightOutline50, height: 30)
                    : Assets.svg.icons.camera.svg(color: AppColors.lightOutline50, height: 30)),
            15.verticalSpace,
            (permissionDenied ? 'Camera permission needed' : 'Take shot')
                .toText(color: AppColors.grey50, textAlign: TextAlign.center, maxLines: 3)
                .px(5)
          ],
        ).center);
  }

  Column buildGenderAgeTags() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildVerifyBadge(child: buildRilChip('Male', icon: Assets.svg.icons.manProfile.svg())),
        18.verticalSpace,
        _buildVerifyBadge(
            child: buildRilChip('19 y.o', icon: Assets.svg.icons.dateTimeCalender.svg())),
        const Spacer(),
        Text(
          '< Go back',
          style: AppStyles.text12PxRegular
              .copyWith(color: AppColors.grey50, decoration: TextDecoration.underline),
        ).pad(5).onTap(() => widget.tabController.animateTo(widget.tabController.previousIndex))
      ],
    );
  }

  badge.Badge _buildVerifyBadge({required Widget child}) {
    return badge.Badge(
        badgeContent: Assets.images.checkVerifiedImage.image(height: 16),
        position: badge.BadgePosition.topEnd(end: -10, top: -10),
        // badgeColor: AppColors.darkOutline50,
        badgeColor: AppColors.transparent,
        elevation: 0,
        padding: 4.all,
        child: child);
  }
}
