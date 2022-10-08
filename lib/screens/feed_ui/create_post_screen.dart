import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../common/themes/app_styles.dart';
import '../../widgets/my_widgets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  var postTextController = TextEditingController();
  Color postColor = AppColors.primary;
  bool isDarkText = true;
  bool simplePicker = true;

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');
    bool isKeyboardVisible =
        WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
    print('isKeyboardVisible ${isKeyboardVisible}');
    var textColor = isDarkText ? AppColors.darkBlack : AppColors.white;
    var textDir = postTextController.text.isHebrew
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Scaffold(
      backgroundColor: postColor,
      body: Stack(
        children: [
          Column(
            children: [
              const Spacer(),
              TextField(
                maxLength: 255,
                maxLines: 3,
                autofocus: true,
                cursorColor: textColor,
                textDirection: textDir,
                controller: postTextController,
                onChanged: (val) {
                  setState(() {});
                },
                textAlign: TextAlign.center,
                style: AppStyles.text18PxBold.copyWith(color: textColor),
                decoration: InputDecoration(
                    counter: const Offstage(),
                    border: InputBorder.none,
                    hintText: 'Type your message...',
                    hintStyle:
                        AppStyles.text18PxBold.copyWith(color: textColor)),
              ),
              if (!isKeyboardVisible) const Spacer(),
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
                padding: const EdgeInsets.only(
                    left: 15, right: 17.5, top: 35, bottom: 12.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () =>
                            setState(() => isDarkText = !isDarkText),
                        icon: Icons.invert_colors.icon(size: 30)),
                    //
                    riltopiaLogo(fontSize: 25, shadowActive: false),
                    //
                    IconButton(
                        onPressed: () => showPickerDialog(),
                        icon: Icons.palette.icon(size: 30)),
                  ],
                )).bottom,
          ),
          InkWell(
            onTap: () => context.router.pop(),
            child: Container(
                height: 100,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(
                    left: 15, right: 17.5, top: 35, bottom: 12.5),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.darkBlack,
                  child: Icons.arrow_forward_ios_rounded.icon(),
                )),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(5)),
            ),
            padding: const EdgeInsets.only(
                left: 15, right: 17.5, top: 35, bottom: 12.5),
            child: Builder(builder: (context) {
              var counter = postTextController.text.length;
              return '$counter/255'.toText(
                  color: counter == 255 ? AppColors.errRed : AppColors.white);
            }),
          ),
        ],
      ),
    );
  }

  void showPickerDialog() {
    print('simplePicker ${simplePicker}');
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
              textColor:
                  simplePicker ? AppColors.primary : AppColors.greyUnavailable,
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
              textColor:
                  simplePicker ? AppColors.greyUnavailable : AppColors.primary,
              onPressed: () {
                simplePicker = false;
                Navigator.of(context).pop();
                showPickerDialog();
              },
            ),
          ],
        ),
        content: Container(
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
