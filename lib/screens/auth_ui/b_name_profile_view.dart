// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../common/models/user/user_model.dart';
import '../../common/service/mixins/assets.gen.dart';
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

  @override
  Widget build(BuildContext context) {
    var isErr = context.listenUniProvider.errFound; // This will auto rebuild if err found.
    var currUser = context.uniProvider.currUser;

    bool nameErr = false;
    bool imageErr = false;
    if (isErr) {
      nameErr = currUser.name == null || currUser.name!.isEmpty;
      imageErr = currUser.photoUrl == null || currUser.photoUrl!.isEmpty;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          200.verticalSpace,
          'Let’s set up your profile!'.toText(fontSize: 18, medium: true),
          50.verticalSpace,
          Badge(
            position: BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: imageErr ? AppColors.errRed : AppColors.grey50,
            padding: 10.all,
            badgeContent:
                Assets.svg.icons.plusAddUntitledIcon.svg(height: 20, color: AppColors.darkBg),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: imageErr ? AppColors.errRed : AppColors.darkOutline50,
              child: CircleAvatar(
                backgroundColor: AppColors.darkBg,
                backgroundImage: image == null ? null : FileImage(File(image!.path)),
                radius: 57,
                child: image != null ? null : Assets.svg.icons.manProfileOutline.svg(height: 55),
              ),
            ),
          ).onTap(() async {
            final ImagePicker picker = ImagePicker();
            image = await picker.pickImage(source: ImageSource.gallery);
            rilFlushBar(context, 'Uploading photo...', isShimmer: true);
            setState(() {});

            var imageUrl = await uploadProfilePhoto(currUser, File(image!.path));
            context.uniProvider.updateUser(currUser.copyWith(photoUrl: imageUrl));
          }),
          20.verticalSpace,
          'Add a profile picture'.toText(fontSize: 13, medium: true),
          50.verticalSpace,
          rilTextField(
            label: 'Nickname',
            hint: 'What is your name?',
            errorText: nameErr ? '' : null,
            onChanged: (val) => context.uniProvider.updateUser(currUser.copyWith(name: val)),
          )
        ],
      ),
    );
  }

  Future<String> uploadProfilePhoto(UserModel currUser, File image) async {
    print('START: uploadProfilePhoto()');

    // cleanSnack(context, text: 'Update profile photo...', sec: 2, showSnackAction: false);

    var refFile = FirebaseStorage.instance
        .ref()
        .child('${FirebaseAuth.instance.currentUser?.displayName}_Profile_${DateTime.now()}');

    await refFile.putFile(image).then((_) {
      isPhotoUploaded = true;
      rilFlushBar(context, 'photo uploaded successfully!', duration: 2, isShimmer: false);
    }).catchError((e) => print('putFile ERR: $e'));

    var imageUrl = await refFile.getDownloadURL();
    FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
    return imageUrl;
  }
}
