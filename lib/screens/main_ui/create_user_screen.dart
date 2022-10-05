import 'package:example/common/extensions/extensions.dart';
import 'package:flutter/material.dart';

import '../../common/routes/app_router.gr.dart';
import '../../common/themes/app_colors.dart';
import '../../common/themes/app_styles.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/my_widgets.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({Key? key}) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('START: CreateUserScreen()');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.darkBlack,
        appBar: darkAppBar(context,
            title: 'Create Account', leadingReplaceRoute: const LoginRoute()),
        body: PageView(
          children: [
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
                wMainButton(context, title: 'Continue', onPressed: () {})
                    .appearAll,
                const Spacer(
                  flex: 7,
                ),
              ],
            ).center,

            ///
            Column(
              children: [
                const Spacer(flex: 45),
                Text('What is your gender?',
                        style: AppStyles.text16PxBold.white)
                    .pOnly(bottom: 5)
                    .px(55)
                    .centerLeft,
                ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    const SizedBox(width: 55),
                    wMainButton(context,
                            title: 'Boy',
                            onPressed: () {},
                            width: 100,
                            color: AppColors.greyDark)
                        .appearAll,
                    wMainButton(context,
                            title: 'Girl',
                            onPressed: () {},
                            width: 100,
                            color: AppColors.greyDark)
                        .px(10)
                        .appearAll,
                    wMainButton(context,
                            title: 'LGBTQ+',
                            onPressed: () {},
                            width: 100,
                            color: AppColors.greyDark)
                        .appearAll,
                    const SizedBox(width: 25),
                  ],
                ).sizedBox(context.width, 55),
                wMainTextField(context, ageController,
                        keyboardType: TextInputType.number,
                        topLabel: 'When is your birthday?',
                        hintText: '01/01/2001')
                    .pOnly(bottom: 15, top: 20)
                    .appearAll,
                wMainButton(context, title: 'Done', onPressed: () {}).appearAll,
                const Spacer(
                  flex: 70,
                ),
              ],
            ).center
          ],
        ),
      ),
    );
  }
}
