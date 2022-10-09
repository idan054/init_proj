import 'dart:io';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/models/user/user_model.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/themes/app_colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/components/genderAgeView_sts.dart';
import '../../widgets/my_widgets.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

enum GenderTypes { boy, girl, lgbt }

class _CreateUserScreenState extends State<CreateUserScreen> {
  var editPageController = PageController(initialPage: 0);
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  int? userAge;
  GenderTypes? selectedGender;

  @override
  Widget build(BuildContext context) {
    print('START: CreateUserScreen()');
    var currUser = context.uniProvider.currUser;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: darkAppBar(
          context,
          title: 'Create Account',
          backAction: () => editPageController.page == 0
              ? context.router.replace(const LoginRoute())
              : editPageController.jumpToPage(0),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: editPageController,
          children: [
            // 1St view
            Column(
              children: [
                const Spacer(flex: 3),
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () async => await updateProfilePhoto(currUser),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('${currUser.photoUrl}'),
                    backgroundColor: AppColors.primary,
                    radius: 60,
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.darkBlack.withOpacity(0.33),
                        child: Icons.collections.icon(size: 30)),
                  ).appearAll,
                ),
                wMainTextField(context, nameController,
                        hintText: '${currUser.name}',
                        topLabel: 'What is your name?')
                    .py(20)
                    .appearAll,

                //~ Continue Button:
                wMainButton(context, title: 'Continue', onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    FirebaseAuth.instance.currentUser
                        ?.updateDisplayName(nameController.text);
                    currUser = currUser.copyWith(name: nameController.text);
                    context.uniProvider.updateUser(currUser);
                  }

                  if ((currUser.name != null) && currUser.photoUrl != null) {
                    editPageController.jumpToPage(1);
                  }
                }).appearAll,
                const Spacer(
                  flex: 7,
                ),
              ],
            ).center,

            ///
            const GenderAgeView()
          ],
        ),
      ),
    );
  }

  Future updateProfilePhoto(UserModel currUser) async {
    print('START: Icons.collections()');
    var imagePath = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((image) => image?.path);
    var imageFile = File(imagePath!);
    cleanSnack(context,
        text: 'Update profile photo...', sec: 2, showSnackAction: false);

    var refFile = FirebaseStorage.instance.ref().child(
        '${AuthService.auth.currentUser?.displayName}_Profile_${DateTime.now()}');
    await refFile
        .putFile(imageFile)
        .then((_) => cleanSnack(context, text: 'Updated successfully!', sec: 3))
        .catchError((e) => print('putFile $e'));
    var imageUrl = await refFile.getDownloadURL();
    FirebaseAuth.instance.currentUser?.updatePhotoURL(imageUrl);
    context.uniProvider.updateUser(currUser.copyWith(photoUrl: imageUrl));

    setState(() {});
  }
}
