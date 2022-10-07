import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../widgets/my_widgets.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  Color postColor = AppColors.darkGrey;
  bool simplePicker = true;

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');

    return Scaffold(
      backgroundColor: postColor,
      body: Stack(
        children: [
          Column(
            children: const [
              Spacer(),
            ],
          ),
          Container(
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(5)),
              ),
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(
                  left: 15, right: 17.5, top: 35, bottom: 12.5),
              child: Row(
                children: [
                  Icons.border_color.icon(size: 30),
                  IconButton(
                      onPressed: () {
                        // postColor = Colors.primaries[
                        //     Random().nextInt(Colors.primaries.length)];
                        // setState(() {});
                        showPickerDialog();
                      },
                      icon: Icons.palette.icon(size: 30)),
                ],
              )),
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
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(5)),
              ),
              padding: const EdgeInsets.only(
                  left: 15, right: 17.5, top: 35, bottom: 12.5),
              child: riltopiaLogo(fontSize: 35, rilPostTxt: true)),
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
