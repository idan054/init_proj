import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/models/user/user_model.dart';
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
  var dayController = TextEditingController();
  var monthController = TextEditingController();
  var yearController = TextEditingController();

  var dayNode = FocusNode();
  var monthNode = FocusNode();
  var yearNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var isErr = context.listenUniProvider.errFound; // This will auto rebuild if err found.

    // bool genderErr = false;
    // bool ageErr = false;
    // if (isErr) {
    //   var genderErr = currUser.gender == null;
    //   var ageErr = currUser.age == null;
    // }

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
                maxLength: 2,
                controller: dayController,
                validator: (value) {
                  if (dayController.text.isEmpty ||
                      dayController.text.length != 2 ||
                      int.parse(dayController.text) >= 32) {
                    return 'DD Format';
                  }
                  return null;
                },
                // errorText:? '': null,
                onChanged: (val) {
                  if (val.length == 2) FocusScope.of(context).requestFocus(monthNode);
                  updateUserAge();
                },
              ).sizedBox(85, null),
              rilTextField(
                px: 5,
                label: 'Month',
                hint: 'MM',
                keyboardType: TextInputType.number,
                focusNode: monthNode,
                maxLength: 2,
                controller: monthController,
                validator: (value) {
                  print('monthController.text ${monthController.text}');
                  if (monthController.text.isEmpty ||
                      monthController.text.length != 2 ||
                      int.parse(monthController.text) >= 13) {
                    return 'MM Format';
                  }
                  return null;
                },
                // errorText:? '': null,
                onChanged: (val) {
                  if (val.isEmpty) FocusScope.of(context).requestFocus(dayNode);
                  if (val.length == 2) FocusScope.of(context).requestFocus(yearNode);
                  updateUserAge();
                },
              ).sizedBox(85, null),
              rilTextField(
                px: 5,
                label: 'Year',
                hint: 'YYYY',
                maxLength: 4,
                focusNode: yearNode,
                keyboardType: TextInputType.number,
                controller: yearController,
                validator: (value) {
                  if (yearController.text.isEmpty || yearController.text.length != 4) {
                    return 'YYYY Format';
                  }
                  return null;
                },
                // errorText:? '': null,
                onChanged: (val) {
                  if (val.isEmpty) FocusScope.of(context).requestFocus(monthNode);
                  if (val.length == 4) FocusScope.of(context).unfocus();
                  updateUserAge();
                },
              ).expanded(),
            ],
          ).px(15),
          20.verticalSpace,
          // ListTile(
          //         horizontalTitleGap: 0,
          //         contentPadding: EdgeInsets.zero,
          //         leading: Assets.svg.icons.shieldTickUntitledIcon
          //             .svg(height: 27, color: Colors.white60),
          //         title: "For a safe community,\nyou can't edit those details"
          //             .toText(fontSize: 12, color: AppColors.grey50)
          //             .centerLeft)
          //     .px(25),
        ],
      ),
    );
  }

  void updateUserAge() {
    print('START: updateUserAge()');
    var currUser = context.uniProvider.currUser;

    if (yearController.text.isEmpty ||
        yearController.text.length != 4 ||
        monthController.text.isEmpty ||
        monthController.text.length != 2 ||
        dayController.text.isEmpty ||
        dayController.text.length != 2) {
      return;
    }
    var year = int.parse(yearController.text);
    var month = int.parse(monthController.text);
    var day = int.parse(dayController.text);
    var bDay = DateTime(year, month, day);
    var age = (bDay.difference(DateTime.now()).inDays / ~365).round();
    // print('bDay $bDay');
    // print('age $age');

    context.uniProvider.updateUser(currUser.copyWith(
      age: age,
      birthday: bDay,
    ));
  }

  StatefulBuilder rilDropdownField(List<String> items, String dropdownValue) {
    var currUser = context.uniProvider.currUser;

    return StatefulBuilder(builder: (context, stfSetState) {
      return Container(
        margin: 20.horizontal,
        child: ButtonTheme(
          padding: 20.horizontal,
          alignedDropdown: true,
          child: DropdownButtonFormField(
            validator: (value) {
              return value == null ? '' : null;
            },
            isExpanded: true,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              focusedBorder: fieldBorderDeco,
              enabledBorder: fieldBorderDeco,
              errorBorder: fieldErrBorderDeco,
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
              var index = items.indexWhere((item) => item == newValue);
              var gender = GenderTypes.values[index];
              context.uniProvider.updateUser(currUser.copyWith(gender: gender));
              stfSetState(() {});
            },
          ),
        ),
      );
    });
  }
}
