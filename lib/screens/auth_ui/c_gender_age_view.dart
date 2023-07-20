import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

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
  var genderItems = ['Male', 'Female', '🏳️‍🌈 Other'];
  var daysItems = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
  ];
  var monthItems = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
  ];
  String selectedGender = '';
  String selectedMonth = '';
  String selectedDay = '';
  var dayController = TextEditingController();
  var monthController = TextEditingController();
  var yearController = TextEditingController();

  var dayNode = FocusNode();
  var monthNode = FocusNode();
  var yearNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var isErr = context.listenUniProvider.signupErrFound; // This will auto rebuild if err found.
    var currUser = context.listenUniProvider.currUser; // This will auto rebuild if err found.

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
          rilDropdownField(
            label: 'Gender',
            hintText: 'What is your gender?',
            genderItems,
            onChanged: (String? newValue) {
              selectedGender = newValue!;
              var index = genderItems.indexWhere((item) => item == newValue);
              var gender = GenderTypes.values[index];
              context.uniProvider.currUserUpdate(currUser.copyWith(gender: gender));
              // stfSetState(() {});
            },
          ),
          // rilTextField(label: 'Gender', hint: 'Choose your gender...'),
          55.verticalSpace,
          Align(
                  alignment: context.hebLocale ? Alignment.centerRight : Alignment.centerLeft,
                  child: 'When is your birthday?'.toText(fontSize: 13, medium: true))
              .px(30),
          18.verticalSpace,
          Row(
            children: [
              // rilDropdownField(label: 'DD', hintText: 'Day', daysItems,
              //     onChanged: (String? newValue) {
              //   selectedDay = newValue!;
              //   dayController.text = newValue;
              //   updateUserAge();
              // }).sizedBox(95, 60),

              rilDropdownField(label: 'DD', hintText: 'Day', margin: 0, daysItems,
                  onChanged: (String? newValue) {
                selectedDay = newValue!;
                dayController.text = newValue;
                isErr = false;
                setState(() {});
                updateUserAge();
              }).sizedBox(95, 60),

              10.horizontalSpace,
              rilDropdownField(label: 'MM', hintText: 'Month', margin: 0, monthItems,
                  onChanged: (String? newValue) {
                selectedMonth = newValue!;
                monthController.text = newValue;
                isErr = false;
                setState(() {});
                updateUserAge();
              }).sizedBox(95, 60),
              10.horizontalSpace,
              rilTextField(
                px: 0,
                label: 'YYYY',
                hint: 'Year',
                maxLength: 4,
                focusNode: yearNode,
                keyboardType: TextInputType.number,
                controller: yearController,
                validator: (value) {
                  if (yearController.text.isEmpty || yearController.text.length != 4) {
                    return 'YYYY Format';
                  }

                  var age = context.uniProvider.currUser.age ?? -404;
                  var validAge = age > 10 && age < 100;
                  if (!validAge) return '${"Age can't be".tr()}' "$age";

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
          ).px(20),
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

    context.uniProvider.currUserUpdate(currUser.copyWith(
      age: age,
      birthday: bDay,
    ));
  }

  Widget rilDropdownField(
    List<String> items, {
    String? hintText,
    ValueChanged<String?>? onChanged,
    double margin = 20,
    required String label,
  }) {
    return Container(
      margin: margin.horizontal,
      child: ButtonTheme(
        padding: 20.horizontal,
        alignedDropdown: true,
        child: DropdownButtonFormField(
          menuMaxHeight: 230,
          validator: (value) => value == null ? '' : null,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            focusedBorder: fieldBorderDeco,
            enabledBorder: fieldBorderDeco,
            errorBorder: fieldErrBorderDeco,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: label.tr(),
            hintText: hintText?.tr(),
            labelStyle: AppStyles.text16PxMedium.copyWith(color: AppColors.greyUnavailable),
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
          onChanged: onChanged,
        ),
      ),
    );
  }
}
