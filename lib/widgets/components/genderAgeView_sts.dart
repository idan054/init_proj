import 'package:age_calculator/age_calculator.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common/models/user/user_model.dart';
import '../../common/routes/app_router.gr.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/my_widgets.dart';

class GenderAgeView extends StatefulWidget {
  const GenderAgeView({Key? key}) : super(key: key);

  @override
  State<GenderAgeView> createState() => _GenderAgeViewState();
}

class _GenderAgeViewState extends State<GenderAgeView> {
  var ageController = TextEditingController();
  int? userAge;
  DateTime? bDay;
  String? bDayStr;
  GenderTypes? selectedGender;
  bool isGenderErr = false;
  bool isAgeErr = false;

  @override
  Widget build(BuildContext context) {
    print('START: CreateUserScreen()');

    Widget genderButton(StateSetter stfSetState, String title, GenderTypes currGender) =>
        wMainButton(context, title: title, onPressed: () {
          selectedGender = currGender;
          stfSetState(() {});
        },
            width: 100,
            textColor: selectedGender == currGender ? AppColors.darkBg : AppColors.white,
            color: selectedGender == currGender ? AppColors.greyLight : AppColors.darkGrey);

    return Column(
      children: [
        const Spacer(flex: 45),
        Text('What is your gender?',
                style: isGenderErr ? AppStyles.text16PxBold.errRed : AppStyles.text16PxBold.white)
            .pOnly(bottom: 5)
            .px(55)
            .centerLeft,
        StatefulBuilder(builder: (context, stfSetState) {
          return ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              const SizedBox(width: 55),
              genderButton(stfSetState, 'Boy', GenderTypes.boy).appearAll,
              genderButton(stfSetState, 'Girl', GenderTypes.girl).px(15).appearAll,
              genderButton(stfSetState, 'LGBTQ+', GenderTypes.lgbt).appearAll,
              const SizedBox(width: 25),
            ],
          ).advancedSizedBox(context, width: context.width, height: 55);
        }),
        StatefulBuilder(builder: (context, stfSetState) {
          DateDuration? nextBirthdayIn;
          if (ageController.text.length == 10) {
            DateFormat dateFormat = DateFormat("dd/MM/yyyy");
            bDay = dateFormat.parse(ageController.text);
            userAge = AgeCalculator.age(bDay!).years;
            nextBirthdayIn = AgeCalculator.timeToNextBirthday(bDay!);
            print('nextBirthdayIn $nextBirthdayIn');
          }

          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            wMainTextField(
              context,
              ageController,
              topLabelStyle:
                  isAgeErr ? AppStyles.text16PxBold.errRed : AppStyles.text16PxBold.white,
              topLabel: ageController.text.length == 10
                  ? 'Your $userAge years old!'
                  : 'When is your birthday?',
              hintText: '01/12/2001',
              maxLength: 10,
              keyboardType: TextInputType.datetime,
              onChanged: (val) {
                var ageLen = ageController.text.length;
                // To hide / show widget below.
                if (ageLen == 0 || ageLen == 1 || ageLen == 9 || ageLen == 10) stfSetState(() {});
                if (ageLen == 2 || ageLen == 5) {
                  ageController.text = '${ageController.text}/';
                  ageController.selection =
                      TextSelection.fromPosition(TextPosition(offset: ageController.text.length));
                }
              },
            ),
            if (ageController.text.isNotEmpty)
              Row(
                children: [
                  Text('01/12/2001', style: AppStyles.text12PxBold.greyLight),
                  const Spacer(),
                  InkWell(
                    onTap: () => stfSetState(() => ageController.text = ''),
                    child: Text('erase', style: AppStyles.text12PxBold.greyLight),
                  )
                ],
              ).px(55).offset(0, -5),
          ]).pOnly(bottom: 15, top: 20).appearAll;
        }),
        buildSubmitButton(),
        const Spacer(
          flex: 70,
        ),
      ],
    ).center;
  }

  bool get genderAgeValid {
    selectedGender == null ? isGenderErr = true : isGenderErr = false;
    userAge == null || ageController.text.length != 10 ? isAgeErr = true : isAgeErr = false;
    if ((userAge != null && userAge! < 0) || (userAge != null && userAge! > 100)) isAgeErr = true;
    if (isAgeErr || isGenderErr) return false;
    return true;
  }

  Widget buildSubmitButton() {
    return wMainButton(context, title: 'Done', onPressed: () {
      if (genderAgeValid) {
        var currUser = context.uniProvider.currUser;
        currUser = currUser.copyWith(birthday: bDay, age: userAge, gender: selectedGender);
        Database().updateFirestore(
            collection: 'users',
            docName: '${currUser.email}',
            toJson: context.uniProvider.currUser.toJson());
        context.router.replace(DashboardRoute());
      } else {
        setState(() {});
      }
    }).appearAll;
  }
}
