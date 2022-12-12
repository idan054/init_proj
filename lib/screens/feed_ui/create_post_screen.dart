import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/models/post/post_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Feed/feed_services.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/my_widgets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var postTextController = TextEditingController();
  var textAlignStr = 'center';
  Color postColor = AppColors.primary;
  bool isDarkText = false;
  bool simplePicker = true;

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    TextAlign textAlign = textAlignStr == 'center'
        ? TextAlign.center
        : textAlignStr == 'right'
            ? TextAlign.right
            : TextAlign.left;
    // bool isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
    UserModel currUser = context.uniProvider.currUser;
    var textColor = isDarkText ? AppColors.darkBlack : AppColors.white;
    var textDir = postTextController.text.isHebrew ? TextDirection.rtl : TextDirection.ltr;

    return Scaffold(
      backgroundColor: postColor,
      body: Stack(
        children: [
          ListView(
            children: [
              TextField(
                maxLength: 255,
                minLines: 1,
                maxLines: 10,
                autofocus: true,
                cursorColor: textColor,
                textDirection: textDir,
                controller: postTextController,
                onChanged: (val) {
                  setState(() {});
                },
                textAlign: textAlign,
                style: AppStyles.text18PxBold.copyWith(color: textColor),
                decoration: InputDecoration(
                    counter: const Offstage(),
                    border: InputBorder.none,
                    hintText: 'Type your message...',
                    hintStyle: AppStyles.text18PxBold.copyWith(color: textColor)),
              ),
              // if (!isKeyboardVisible)
            ],
          ).px(15).py(60).center,
          Positioned(
            bottom: 0,
            child: Container(
                height: 100,
                width: context.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.01, 0.99],
                    colors: [
                      AppColors.darkBlack.withOpacity(0.40),
                      AppColors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.only(left: 15, right: 17.5, top: 35, bottom: 12.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () => setState(() => isDarkText = !isDarkText),
                        icon: Icons.invert_colors.icon(size: 30)),
                    //
                    // riltopiaLogo(fontSize: 25),
                    if (textAlignStr == 'center' && postTextController.text.isHebrew)
                      Icons.format_align_center
                          .icon(size: 30)
                          .onTap(() => setState(() => textAlignStr = 'right')),
                    if (textAlignStr == 'center' && !postTextController.text.isHebrew)
                      Icons.format_align_left
                          .icon(size: 30)
                          .onTap(() => setState(() => textAlignStr = 'left')),
                    if (textAlignStr == 'right' || textAlignStr == TextAlign.left)
                      Icons.format_align_right
                          .icon(size: 30)
                          .onTap(() => setState(() => textAlignStr = 'center')),
                    //
                    IconButton(
                        onPressed: () => showPickerDialog(), icon: Icons.palette.icon(size: 30)),
                  ],
                )).bottom,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.01, 0.99],
                colors: [
                  AppColors.transparent,
                  AppColors.darkBlack.withOpacity(0.40),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 35, bottom: 12.5),
            child: Row(
              children: [
                Icons.arrow_back_ios_new_rounded.icon().pad(15).onTap(() => context.router.pop()),
                15.horizontalSpace,
                Builder(builder: (context) {
                  var counter = postTextController.text.length;
                  return '$counter/255'
                      .toText(color: counter == 255 ? AppColors.errRed : AppColors.white);
                }),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Ril', style: AppStyles.text18PxBold.white.rilTopiaFont),
                    Text('Post', style: AppStyles.text18PxRegular.white.rilTopiaFont),
                  ],
                ).py(10).px(10).onTap(() {
                  var post = PostModel(
                    textContent: postTextController.text,
                    id: '${currUser.email}${UniqueKey()}',
                    textAlign: textAlignStr,
                    creatorUser: currUser,
                    isDarkText: isDarkText,
                    colorCover: postColor,
                    timestamp: DateTime.now(),
                    likeCounter: 0,
                    isSubPost: false,
                    enableComments: true,
                    enableLikes: true,
                  );
                  // context.uniProvider.updatePostUploaded(post);
                  FeedService.uploadPost(context, post);
                  context.router.pop();
                }, radius: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showPickerDialog() {
    print('simplePicker $simplePicker');
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.darkGrey,
        title: Row(
          children: [
            wMainButton(
              context,
              title: 'Simple',
              color: AppColors.darkGrey,
              width: 100,
              textColor: simplePicker ? AppColors.primary : AppColors.greyUnavailable,
              onPressed: () {
                simplePicker = true;
                Navigator.of(context).pop();
                showPickerDialog();
              },
            ),
            wMainButton(
              context,
              title: 'Advanced',
              color: AppColors.darkGrey,
              width: 110,
              textColor: simplePicker ? AppColors.greyUnavailable : AppColors.primary,
              onPressed: () {
                simplePicker = false;
                Navigator.of(context).pop();
                showPickerDialog();
              },
            ),
          ],
        ),
        content: SizedBox(
          height: context.height / 2.5,
          child: simplePicker
              ? BlockPicker(
                  useInShowDialog: true,
                  pickerColor: postColor,
                  onColorChanged: (color) => setState(() => postColor = color),
                )
              : MaterialPicker(
                  pickerColor: postColor,
                  onColorChanged: (color) => setState(() => postColor = color),
                  // onColorChanged: (color) => postColor = color,
                ),
        ),
        actions: <Widget>[
          wMainButton(
            context,
            title: 'Done',
            color: AppColors.darkGrey,
            onPressed: () {
              // setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
