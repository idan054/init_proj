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

class GenderAgeView extends StatelessWidget {
  const GenderAgeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'Item 1';

    // List of items in our dropdown menu
    var items = ['Male', 'Female', '🏳️‍🌈 Other'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        200.verticalSpace,
        'A bit about yourself'.toText(fontSize: 18, medium: true),
        75.verticalSpace,
        // 'Who are you'.toText(fontSize: 13, medium: true).centerLeft.pOnly(left: 30),
        'When were you born?'.toText(fontSize: 13, medium: true).centerLeft.pOnly(left: 30),
        18.verticalSpace,
        Row(
          children: [
            rilTextField(label: 'Day', hint: 'DD', px: 5).sizedBox(85, null),
            rilTextField(label: 'Month', hint: 'MM', px: 5).sizedBox(85, null),
            rilTextField(label: 'Year', hint: 'YYYY', px: 5).expanded(),
          ],
        ).px(15),
        // rilTextField(label: 'Gender', hint: 'Choose your gender...'),
        86.verticalSpace,
        rilDropdownField(items, dropdownvalue),
      ],
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
