// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:badges/badges.dart'  as badge;
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/models/user/user_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/uploadServices.dart';
import '../../widgets/clean_snackbar.dart';
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
  bool isPhotoUploaded = false;
  bool isLoading = false;
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var isImageErr =
        context.listenUniProvider.signupErrFound; // This will auto rebuild if err found.
    var currUser = context.uniProvider.currUser;

    // bool nameErr = false;
    // bool imageErr = false;
    // if (isErr) {
    // nameErr = currUser.name == null || currUser.name!.isEmpty;
    // imageErr = currUser.photoUrl == null || currUser.photoUrl!.isEmpty;
    // }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          200.verticalSpace,
          'Let’s set up your profile!'.toText(fontSize: 18, medium: true),
          50.verticalSpace,
          badge.Badge(
            position:  badge.BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: isImageErr ? AppColors.errRed : AppColors.primaryOriginal,
            padding: 10.all,
            badgeContent: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ).sizedBox(20, 20)
                : Assets.svg.icons.plusAddUntitledIcon.svg(height: 20, color: AppColors.darkBg),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: isImageErr ? AppColors.errRed : AppColors.darkOutline50,
              child: CircleAvatar(
                backgroundColor: AppColors.darkBg,
                backgroundImage: image == null ? null : FileImage(File(image!.path)),
                radius: 57,
                child: image != null ? null : Assets.svg.icons.manProfileOutline.svg(height: 55, color: AppColors.darkOutline50),
              ),
            ),
          ).onTap(() async {
            final ImagePicker picker = ImagePicker();
            image = await picker.pickImage(
              source: ImageSource.gallery,
              maxHeight: 200,
              maxWidth: 200,
            );
            isLoading = true;
            setState(() {});

            if (image == null) return;
            var bytes = await image!.readAsBytes();
            String base64Image = base64Encode(bytes);

            var imageUrl = await UploadServices.imgbbUploadPhoto(base64Image);
            if (imageUrl == null) {
              image = null;
            } else {
              context.uniProvider.currUserUpdate(currUser.copyWith(photoUrl: imageUrl));
            }

            isLoading = false;
            setState(() {});
          }),
          20.verticalSpace,
          'Add a profile picture'.toText(fontSize: 13, medium: true),
          50.verticalSpace,
          rilTextField(
            // label: 'Nickname',
            label: 'Name',
            hint: 'What is your name?',
            maxLines: 1,
            maxLength: 25,
            controller: nameController,
            validator: (value) {
              if (nameController.text.replaceAll(' ', '').isEmpty) return '';
              if (nameController.text.isEmpty) return '';
              return null;
            },
            // errorText: nameErr ? '' : null,
            onChanged: (val) => context.uniProvider.currUserUpdate(currUser.copyWith(name: val)),
          )
        ],
      ),
    );
  }
}
