// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:badges/badges.dart'  as badge;
import 'package:camera/camera.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/screens/user_ui/user_screen.dart';
import 'package:example/widgets/my_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
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
import '../../common/service/Database/db_advanced.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/service/uploadServices.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/my_widgets.dart';
import '../auth_ui/a_onboarding_screen.dart';
import '../auth_ui/b_name_profile_view.dart';
import '../feed_ui/main_feed_screen.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_colors_inverted.dart';
import '../../widgets/app_bar.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class EditUserScreen extends StatefulWidget {
  final UserModel user;

  const EditUserScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

String? tempName;
String? tempBio;

class _EditUserScreenState extends State<EditUserScreen> {
  final editUserFormKey = GlobalKey<FormState>();
  XFile? selectedImage;
  bool isPhotoUploaded = false;
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var isLoading = false;

  @override
  void initState() {
    print('START: initState() EditUserScreen');
    var currUser = context.uniProvider.currUser;
    nameController.text = tempName ?? currUser.name ?? '';
    bioController.text = tempBio ?? currUser.bio ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var currUser = context.uniProvider.currUser;
    var currUser = context.listenUniProvider.currUser;
    print('currUser.bio ${currUser.bio}');

    return WillPopScope(
      onWillPop: () async {
        _discardPopup(currUser);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBg,
        appBar: darkAppBar(
          context,
          // title: widget.otherUser.name.toString(),
          title: 'Edit profile',
          centerTitle: true,
          backAction: () => _discardPopup(currUser),
          actions: [
            if (!isLoading)
              'Save'.toText().px(14).center.onTap(() async {
                tempName = null;
                tempBio == null;
                var updatedUser =
                    currUser.copyWith(name: nameController.text, bio: bioController.text);
                context.uniProvider.currUserUpdate(updatedUser);

                Database.updateFirestore(
                    collection: 'users',
                    docName: '${updatedUser.email}',
                    toJson: updatedUser.toJson());

                //~ The NEW method
                var alreadyFetchedUsers = context.uniProvider.fetchedUsers;
                context.uniProvider.fetchedUsersUpdate([updatedUser, ...alreadyFetchedUsers]);

                //! Expensive Way! REPLACED by getUserByEmailIfNeeded() method
                // var snap = await FsAdvanced.db
                //     .collection('posts')
                //     .orderBy('timestamp', descending: true)
                //     .where('creatorUser.uid', isEqualTo: updatedUser.uid)
                //     .get();
                //
                // List posts = await FsAdvanced().docsToModelList(context, snap, ModelTypes.posts);
                // for (PostModel post in posts) {
                //   var updatedPost = post.copyWith(creatorUser: updatedUser);
                //   // print('posts.length ${posts.length}');
                //   // print('updatedPost.toJson() ${updatedPost.toJson()}');
                //   Database.updateFirestore(
                //       collection: 'posts', docName: updatedPost.id, toJson: updatedPost.toJson());
                //   // return;
                // }

                context.router.replace(UserRoute(user: updatedUser, fromEditScreen: true));
              }, radius: 10).pOnly(right: 5)
          ],
        ),
        body: Stack(
          children: [
            Container(
              width: context.width,
              height: 80,
              color: AppColors.primaryOriginal,
              child: Assets.images.squresBg.image(fit: BoxFit.cover),
            ),
            Form(
              key: editUserFormKey,
              child: ListView(
                children: [
                  Container(height: 25, color: AppColors.transparent),
                  //> Image:
                  buildEditProfileImage(currUser),
                  //> Nickname
                  30.verticalSpace,
                  'Your interests'.toText().px(25),
                  13.verticalSpace,
                  buildTagsRow(currUser,
                      addonName: 'Edit',
                      onAddonTap: () => context.router.push(TagsViewRoute(user: currUser))).px(20),
                  30.verticalSpace,
                  rilTextField(
                    // label: 'Nickname',
                    label: 'Name',
                    textAlign: TextAlign.left,
                    controller: nameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value(' ', '').isEmpty) return '';
                      if (nameController.text.isEmpty) return '';
                      return null;
                    },
                    // errorText: nameErr ? '' : null,
                    // onChanged: (val) => context.uniProvider.updateUser(currUser.copyWith(name: val)),
                    onChanged: (val) => tempName = val,
                  ),
                  30.verticalSpace,
                  StatefulBuilder(builder: (context, stfState) {
                    return rilTextField(
                      label: 'Bio',
                      textAlign: bioController.text.isEmpty ? TextAlign.left : TextAlign.center,
                      hint: 'Tell everyone about yourself...',
                      minLines: 3,
                      maxLines: 15,
                      maxLength: 1250,
                      controller: bioController,
                      validator: (value) {
                        // if (bioController.text.isEmpty) return '';
                        return null;
                      },
                      // errorText: nameErr ? '' : null,
                      onChanged: (val) {
                        tempBio = val;
                        stfState(() {});
                      },
                    );
                  }),
                  30.verticalSpace,
                ],
              ),
            ),
            if (Platform.isIOS || kDebugMode)
              rilClassicButton(context,
                  radius: 10,
                  isWide: true,
                  title: 'Delete my account',
                  bgColor: AppColors.errRed,
                  textColor: AppColors.darkBg, onPressed: () async {
                _deleteUserPopup(context);
              }).scale(scale: 0.7).bottom.pOnly(bottom: 25)
          ],
        ),
      ),
    );
  }

  void _deleteUserPopup(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    // print('currUser.email ${currUser.email}');

    Future.delayed(150.milliseconds).then((_) {
      showRilDialog(context,
          title: 'Are you sure want to DELETE this account?',
          desc: 'Any of your content will be lost & you will lose access to this user'
              // 'You can\'t Undo it. Are you sure?'
              .toText(maxLines: 10),
          barrierDismissible: true,
          secondaryBtn: TextButton(
              onPressed: () async {
                Database.deleteDoc(collection: 'users', docName: currUser.email.toString());
                context.router.replaceAll([const LoginRoute()]);
              },
              child: 'Delete account'.toText(color: AppColors.primaryLight)));
    });
  }

  void _discardPopup(UserModel user) {
    showRilDialog(context,
        title: 'Discard changes?',
        desc: 'Your edit will not be saved'.toText(),
        barrierDismissible: true,
        secondaryBtn: TextButton(
            onPressed: () {
              tempName = null;
              tempBio == null;
              //- context.uniProvider.updateUser(updatedUser);
              context.router.replace(UserRoute(user: user, fromEditScreen: true));
            },
            child: 'Discard'.toText(color: AppColors.primaryLight)));
  }

  Widget buildEditProfileImage(UserModel currUser) {
    return badge.Badge(
            position: badge.BadgePosition.bottomEnd(bottom: 0, end: 0),
            badgeColor: AppColors.primaryOriginal,
            padding: 7.all,
            badgeContent: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 1,
                  ).sizedBox(14, 14)
                : Assets.svg.icons.refreshArrows.svg(height: 14, color: AppColors.darkBg),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.darkOutline,
              child: Builder(builder: (context) {
                var imageProvider = selectedImage == null
                    ? NetworkImage(widget.user.photoUrl!)
                    : FileImage(File(selectedImage!.path));
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: imageProvider as ImageProvider<Object>?,
                  backgroundColor: AppColors.darkOutline,
                );
              }),
            )).pad(5).onTap(() async {
      print('START: ImagePicker()');
      final ImagePicker picker = ImagePicker();
      selectedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 200,
        maxWidth: 200,
      );

      isLoading = true;
      setState(() {});

      if (selectedImage == null) return;
      var bytes = await selectedImage!.readAsBytes();
      String base64Image = base64Encode(bytes);

      var imageUrl = await UploadServices.imgbbUploadPhoto(base64Image);
      if (imageUrl == null) {
        selectedImage = null;
      } else {
        context.uniProvider.currUserUpdate(currUser.copyWith(photoUrl: imageUrl));
      }

      isLoading = false;
      setState(() {});
    })
        // .centerLeft
        .center;
  }
}
