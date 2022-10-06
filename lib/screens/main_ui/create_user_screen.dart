import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:flutter/material.dart';

import '../../common/routes/app_router.gr.dart';
import '../../common/themes/app_colors.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/genderAgeView_sts.dart';
import '../../widgets/my_widgets.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

enum GenderTypes { boy, girl, lgbt }

class _CreateUserScreenState extends State<CreateUserScreen> {
  var editPageController = PageController(initialPage: 0);
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  int? userAge;
  GenderTypes? selectedGender;

  @override
  Widget build(BuildContext context) {
    print('START: CreateUserScreen()');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: darkAppBar(
          context,
          title: 'Create Account',
          backAction: () => editPageController.page == 0
              ? context.router.replace(const LoginRoute())
              : editPageController.jumpToPage(0),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: editPageController,
          children: [
            // 1St view
            Column(
              children: [
                const Spacer(flex: 3),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 60,
                  child: Icons.collections.icon(size: 35),
                ).appearAll,
                wMainTextField(context, nameController,
                        hintText: '${context.uniProvider.currUser.name}')
                    .py(30)
                    .appearAll,
                wMainButton(context, title: 'Continue', onPressed: () {
                  print(
                      'editPageController.positions ${editPageController.positions}');
                  editPageController.jumpToPage(1);
                }).appearAll,
                const Spacer(
                  flex: 7,
                ),
              ],
            ).center,

            ///
            const GenderAgeView()
          ],
        ),
      ),
    );
  }
}
