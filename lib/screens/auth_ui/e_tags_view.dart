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
import '../feed_ui/user_screen.dart';
import 'a_onboarding_screen.dart';

class TagsView extends StatelessWidget {
  const TagsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedTags = <String>[];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          190.verticalSpace,
          Builder(builder: (context) {
            var isTagsErr =
                context.listenUniProvider.errFound; // This will auto rebuild if err found.
            return (isTagsErr
                    ? 'Choose at least one interest'
                    : 'Choose interests, so\nothers will know you better')
                .toText(
                    textAlign: TextAlign.center,
                    fontSize: 18,
                    medium: true,
                    color: isTagsErr ? AppColors.errRed : AppColors.white);
          }),
          40.verticalSpace,
          Wrap(
            // alignment: WrapAlignment.center,
            spacing: 0,
            runSpacing: 11,
            children: [
              // for (int i = 0; i < 15; i++) ...[
              for (int i = 0; i < tags.length; i++) ...[
                Builder(builder: (context) {
                  var isSelected = false;
                  return StatefulBuilder(builder: (context, stfState) {
                    return buildChoiceChip(context,
                        selectedColor: AppColors.darkOutline50,
                        isUnselectedBorder: false,
                        padding: 4,
                        selected: isSelected,
                        label: tags[i].toText(
                            color: isSelected ? AppColors.white : AppColors.grey50,
                            fontSize: 14), onSelect: (bool newSelection) {
                      isSelected = !isSelected;
                      isSelected ? selectedTags.add(tags[i]) : selectedTags.remove(tags[i]);
                      var currUser = context.uniProvider.currUser;
                      context.uniProvider.updateUser(currUser.copyWith(tags: selectedTags));
                      stfState(() {});
                    });
                  });
                })
              ]
            ],
          ).px(25),
        ],
      ),
    );
  }
}
