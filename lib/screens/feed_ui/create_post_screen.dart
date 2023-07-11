// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:ui';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../common/models/post/post_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Database/firebase_db.dart';
import '../../common/service/Feed/feed_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/clean_snackbar.dart';
import '../../widgets/my_widgets.dart';
import 'main_feed_screen.dart';

class CreatePostScreen extends StatefulWidget {
  final bool replyStyle;
  final Function onChange;

  const CreatePostScreen(this.replyStyle, {required this.onChange, Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var postController = TextEditingController();
  bool isComments = false;

  // bool isTagScreen = false;
  int? tagIndex;

  @override
  void initState() {
    // isTagScreen = context.uniProvider.selectedTag != 'New';

    isComments = !(widget.replyStyle); // no comments when reply mode!
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    print('isTagAdded $isComments');
    var textDir = postController.text.isHebrew ? TextDirection.rtl : TextDirection.ltr;
    // var selectedTag = context.uniProvider.selectedTag; // When filters in use

    return Container(
      decoration: BoxDecoration(
        // color: AppColors.darkOutline,
        color: AppColors.darkBg,
        borderRadius: BorderRadius.only(
          topLeft: 10.circular,
          topRight: 10.circular,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.99),
        //     offset: const Offset(0.0, 1.5), //(x,y)
        //     blurRadius: 4.0,
        //   ),
        // ],
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (isTagScreen)
          //   '#$selectedTag'
          //       .toText(color: AppColors.darkOutline50)
          //       .pOnly(left: 10, top: 10)
          //       .centerLeft,
          TextField(
            maxLines: 11,
            minLines: 1,
            maxLength: isComments ? 512 : 256,
            // X2 for conversion
            buildCounter: (context, {required currentLength, required isFocused, maxLength}) =>
                postController.text.length == (isComments ? 512 : 256)
                    ? 'Max length'.toText(
                        fontSize: 12,
                        color: AppColors.errRed,
                      )
                    : const Offstage(),
            autofocus: true,
            textDirection: textDir,
            controller: postController,
            keyboardAppearance: Brightness.dark,
            keyboardType: TextInputType.multiline,
            style: AppStyles.text16PxRegular.copyWith(color: AppColors.white),
            onChanged: (val) => setState(() {}),
            // inputFormatters: [LengthLimitingTextInputFormatter(350)],
            cursorColor: AppColors.yellowAlert,
            decoration: InputDecoration(
              filled: true,
              hintText: isComments ? 'Start a Talk about...' : 'Share your Ril thoughts...',
              hintStyle: AppStyles.text16PxRegular.copyWith(color: AppColors.greyUnavailable),
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              buildChoiceChip(context,
                      selectedColor: AppColors.darkGrey,
                      // borderColor: AppColors.primaryLight2,
                      borderColor: AppColors.transparent,
                      customIcon: isComments
                          ? Assets.svg.icons.messageSmile
                              .svg(height: 20, color: AppColors.primaryLight2)
                          : Assets.svg.icons.dmPlaneUntitledIcon
                              .svg(height: 15, color: AppColors.primaryLight2),
                      // label: (isComments ? 'With comments' : 'Reply only') // Reply only
                      label: (isComments ? 'With comments' : 'Chat only') // Reply only
                          .toText(color: AppColors.primaryLight2),
                      //
                      onSelect: (bool newSelection) {
                isComments = !isComments;
                widget.onChange(isComments);
                setState(() {});
              }, selected: isComments)
                  .centerLeft
                  .pOnly(left: 5),

              // Expanded(
              //   child: isTagAdded
              //       ? _tagsChoiceList(context)
              //       : buildChoiceChip(context, label: const Text('Add tag'),
              //               onSelect: (bool newSelection) {
              //           isTagAdded = !isTagAdded;
              //           setState(() {});
              //         }, selected: isTagAdded)
              //           .centerLeft
              //           .pOnly(left: 5),
              // ),

              const Spacer(),
              buildSendButton(
                  isActive: postController.text.isNotEmpty &&
                      (postController.text.replaceAll(' ', '').isNotEmpty),
                  withBg: true,
                  onTap: () async {
                    final currUser = context.uniProvider.currUser;
                    await updateUserLocation(context);

                    return;
                    // UserModel currUser = context.uniProvider.currUser;
                    var post = PostModel(
                      textContent: postController.text,
                      id: '${currUser.email}${UniqueKey()}',
                      //  TODO ADD ON POST MVP ONLY: Use UID instead creatorUser so
                      // details will be update if user edit his info
                      creatorUser: currUser,
                      timestamp: DateTime.now(),
                      enableComments: isComments,
                      postType: isComments ? PostType.conversationRil : PostType.dmRil,
                      commentedUsersEmails: isComments ? [currUser.email.toString()] : [],
                    );
                    context.uniProvider.postUploadedUpdate(true);
                    FeedService.uploadPost(context, post);
                    context.router.pop();
                  },
                  isConversationSend: isComments)
            ],
          ).pOnly(bottom: 5),
        ],
      ),
    );
  }

// SizedBox _tagsChoiceList(BuildContext context) {
//   return SizedBox(
//     height: 50.0,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: List<Widget>.generate(
//         tags.length,
//         (int i) {
//           var isChipSelected = tagIndex == i;
//
//           return buildChoiceChip(
//             context,
//             label: Text(tags[i]),
//             showCloseIcon: true,
//             selected: isChipSelected,
//             onSelect: (bool newSelection) {
//               if (newSelection) {
//                 tagIndex = i;
//               } else {
//                 tagIndex = null; // To do not remember selection.
//
//                 isTagAdded = false;
//               }
//               setState(() {});
//             },
//           );
//         },
//       ).toList(),
//     ),
//   );
// }
}

Future updateUserLocation(BuildContext context, {bool force = false}) async {
  print('START: updateUserLocation()');
  final currUser = context.uniProvider.currUser;

  void _updateCurrentPosition() async {
    final locationData = await Geolocator.getCurrentPosition();
    print('latitude ${locationData.latitude}');
    print('longitude ${locationData.longitude}');
    final updatedUser = currUser.copyWith(lat: locationData.latitude, long: locationData.longitude);
    context.uniProvider.currUserUpdate(updatedUser);
    Database.updateFirestore(
        collection: 'users', docName: '${updatedUser.email}', toJson: updatedUser.toJson());
  }

  if (currUser.lat == null || currUser.long == null || force) {
    final isGranted = await Permission.locationWhenInUse.isGranted;
    if (isGranted) {
      _updateCurrentPosition();
    } else {
      final status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        _updateCurrentPosition();
      } else {
        rilFlushBar(context, 'Allow location on settings...');
        await Future.delayed(2.seconds);
        await openAppSettings();
      }
    }
  }
  return;
}

Widget buildSendButton(
    {GestureTapCallback? onTap,
    Color? color,
    bool isActive = true,
    bool isConversationSend = false,
    bool withBg = false}) {
  return Opacity(
    opacity: isActive ? 1.0 : .3,
    child: Container(
      height: 34,
      width: 34,
      color: withBg ? AppColors.primaryOriginal : AppColors.transparent,
      // color: AppColors.primaryOriginal,
      // color: ,
      child: (isConversationSend
              // ? Assets.svg.icons.messageChatCircleAdd.svg(color: color?? Colors.white)
              ? Assets.images.messageSmileIconPng.image()
              : Assets.svg.icons.iconSendButton.svg(color: color ?? Colors.white).offset(1, 0))
          .pad(isConversationSend ? 8 : 9),
    ).roundedFull.py(5).px(5).onTap(isActive ? onTap : null, radius: 99).px(5).pOnly(right: 5),
  );
}

Widget quickCrossFade(bool value,
    {required Widget firstChild, required Widget secondChild, Duration? duration}) {
  return AnimatedCrossFade(
    duration: duration ?? 1.seconds,
    firstChild: firstChild,
    secondChild: secondChild,
    crossFadeState: value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
  );
}
