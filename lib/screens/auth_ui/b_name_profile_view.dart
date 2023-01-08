import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import 'a_onboarding_screen.dart';

class NameProfileView extends StatefulWidget {
  const NameProfileView({Key? key}) : super(key: key);

  @override
  State<NameProfileView> createState() => _NameProfileViewState();
}

class _NameProfileViewState extends State<NameProfileView> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          200.verticalSpace,
          'Let’s set up your profile!'.toText(fontSize: 18, medium: true),
          50.verticalSpace,
          Badge(
            position: BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: AppColors.grey50,
            padding: 10.all,
            badgeContent:
                Assets.svg.icons.plusAddUntitledIcon.svg(height: 20, color: AppColors.darkBg),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.darkOutline50,
              child: CircleAvatar(
                backgroundColor: AppColors.darkBg,
                backgroundImage: image == null ? null : FileImage(File(image!.path)),
                radius: 57,
                child: image != null ? null : Assets.svg.icons.manProfileOutline.svg(height: 55),
              ),
            ),
          ).onTap(() async {
            final ImagePicker _picker = ImagePicker();
            image = await _picker.pickImage(source: ImageSource.gallery);
            setState(() {});
          }),
          20.verticalSpace,
          'Add a profile picture'.toText(fontSize: 13, medium: true),
          50.verticalSpace,
          rilTextField(label: 'Nickname', hint: 'What is your name?')
        ],
      ),
    );
  }
}
