import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import 'a_onboarding_screen.dart';

class GenderAgeView extends StatefulWidget {
  const GenderAgeView({Key? key}) : super(key: key);

  @override
  State<GenderAgeView> createState() => _GenderAgeViewState();
}

class _GenderAgeViewState extends State<GenderAgeView> {
  var items = ['Male', 'Female', '🏳️‍🌈 Other'];
  String dropdownVal = '';
  var dayNode = FocusNode();
  var monthNode = FocusNode();
  var yearNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          200.verticalSpace,
          'A bit about yourself'.toText(fontSize: 18, medium: true),
          75.verticalSpace,
          // 'Who are you'.toText(fontSize: 13, medium: true).centerLeft.pOnly(left: 30),
          // 'When were you born?'.toText(fontSize: 13, medium: true).centerLeft.pOnly(left: 30),
          rilDropdownField(items, dropdownVal),
          // rilTextField(label: 'Gender', hint: 'Choose your gender...'),
          55.verticalSpace,
          'When is your birthday?'.toText(fontSize: 13, medium: true).centerLeft.pOnly(left: 30),
          18.verticalSpace,
          Row(
            children: [
              rilTextField(
                px: 5,
                label: 'Day',
                hint: 'DD',
                keyboardType: TextInputType.number,
                focusNode: dayNode,
                onChanged: (val) {
                  print('val.length == 2 ${val.length == 2}');
                  if (val.length == 2) FocusScope.of(context).requestFocus(monthNode);
                },
              ).sizedBox(85, null),
              rilTextField(
                px: 5,
                label: 'Month',
                hint: 'MM',
                keyboardType: TextInputType.number,
                focusNode: monthNode,
                onChanged: (val) {
                  if (val.isEmpty) FocusScope.of(context).requestFocus(dayNode);
                  if (val.length == 2) FocusScope.of(context).requestFocus(yearNode);
                },
              ).sizedBox(85, null),
              rilTextField(
                px: 5,
                label: 'Year',
                hint: 'YYYY',
                keyboardType: TextInputType.number,
                focusNode: yearNode,
                onChanged: (val) {
                  if (val.isEmpty) FocusScope.of(context).requestFocus(monthNode);
                  if (val.length == 4) FocusScope.of(context).unfocus();
                },
              ).expanded(),
            ],
          ).px(15),
          20.verticalSpace,
          ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.zero,
                  leading: Assets.svg.icons.shieldTickUntitledIcon
                      .svg(height: 27, color: Colors.white60),
                  title: "For a safe community, you can't edit your gender & birthday later"
                      .toText(fontSize: 12, color: AppColors.grey50)
                      .centerLeft)
              .px(25),
        ],
      ),
    );
  }

  StatefulBuilder rilDropdownField(List<String> items, String dropdownValue) {
    return StatefulBuilder(builder: (context, stfSetState) {
      return Container(
        margin: 20.horizontal,
        child: ButtonTheme(
          padding: 20.horizontal,
          alignedDropdown: true,
          child: DropdownButtonFormField(
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              focusedBorder: fieldBorderDeco,
              enabledBorder: fieldBorderDeco,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: 'Gender',
              hintText: 'What is your gender',
              labelStyle: AppStyles.text16PxMedium.copyWith(color: AppColors.darkOutline50),
              hintStyle: AppStyles.text14PxMedium.copyWith(color: AppColors.white),
            ),
            dropdownColor: AppColors.primaryDark,
            borderRadius: BorderRadius.all(10.circular),
            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: item.toText(color: AppColors.white),
              );
            }).toList(),
            onChanged: (String? newValue) {
              dropdownValue = newValue!;
              stfSetState(() {});
            },
          ),
        ),
      );
    });
  }
}
