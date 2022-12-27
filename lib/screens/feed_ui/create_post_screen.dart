import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/models/post/post_model.dart';
import '../../common/models/user/user_model.dart';
import '../../common/service/Feed/feed_services.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/components/riltopiaAppBar.dart';
import '../../widgets/my_widgets.dart';
import 'main_feed_screen.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  bool isAddTag = false;
  int? tagIndex;

  @override
  Widget build(BuildContext context) {
    print('START: CreatePostScreen()');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkOutline,
        borderRadius: BorderRadius.only(
          topLeft: 20.circular,
          topRight: 20.circular,
        ),
      ),
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (val) => setState(() {print('STATE SET');}),
            autofocus: true,
            keyboardType: TextInputType.multiline,
            keyboardAppearance: Brightness.dark,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              hintText: 'Share your Ril thoughts...',
              hintStyle: AppStyles.text16PxRegular.copyWith(color: AppColors.grey50),
              fillColor: Colors.transparent,
              border: InputBorder.none,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: isAddTag
                    ? _tagsChoiceList(context)
                    : buildChoiceChip(
                        context,
                        label: const Text('Add tag'),
                        selected: isAddTag,
                        onSelect: (bool newSelection) {
                          isAddTag = !isAddTag;
                          setState(() {});
                        },
                      ).centerLeft,
              ),
              Container(
                height: 35,
                width: 35,
                color: AppColors.darkOutline50,
                child: Assets.svg.icons.dmPlaneUntitledIcon.svg().pad(7.5),
              ).rounded(radius: 10).px(15)
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _tagsChoiceList(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List<Widget>.generate(
          tags.length,
          (int i) {
            var isChipSelected = tagIndex == i;

            return buildChoiceChip(
              context,
              label: Text(tags[i]),
              showClose: true,
              selected: isChipSelected,
              onSelect: (bool newSelection) {
                if (newSelection) {
                  tagIndex = i;
                } else {
                  isAddTag = false;
                }
                setState(() {});
              },
            );
          },
        ).toList(),
      ),
    );
  }
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
