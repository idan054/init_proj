import 'package:auto_route/auto_route.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/components/feed/feedTitle.dart';
import '../../widgets/my_dialog.dart';
import '../../widgets/my_widgets.dart';
import '../feed_ui/main_feed_screen.dart';
import '../user_ui/user_screen.dart';
import 'a_onboarding_screen.dart';

class TagsViewScreen extends StatefulWidget {
  final UserModel? user;

  const TagsViewScreen({this.user, Key? key}) : super(key: key);

  @override
  State<TagsViewScreen> createState() => _TagsViewScreenState();
}

class _TagsViewScreenState extends State<TagsViewScreen> {
  var selectedTags = <String>[];

  @override
  void initState() {
    selectedTags = widget.user == null ? <String>[] : [...widget.user!.tags];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isEditMode = widget.user != null;

    return isEditMode
        ? WillPopScope(
            onWillPop: () async {
              _discardPopup(widget.user!);
              return false;
            },
            child: Scaffold(
              appBar: darkAppBar(
                context,
                // title: widget.otherUser.name.toString(),
                title: 'Edit interests',
                centerTitle: true,
                backAction: () => _discardPopup(widget.user!),
                actions: [
                  'Save'.toText().px(14).center.onTap(() {
                    context.uniProvider.updateUser(widget.user!.copyWith(tags: selectedTags));
                    context.router.replace(EditUserRoute(user: widget.user!));
                  }, radius: 10).pOnly(right: 5)
                ],
              ),
              backgroundColor: AppColors.darkBg,
              body: buildTagsView(selectedTags, isEditMode),
            ),
          )
        : buildTagsView(selectedTags, isEditMode);
  }

  void _discardPopup(UserModel user) {
    showRilDialog(context,
        title: 'Discard changes?',
        desc: 'Your edit will not be saved'.toText(),
        barrierDismissible: true,
        secondaryBtn: TextButton(
            onPressed: () {
              context.router.replace(EditUserRoute(user: user));
            },
            child: 'Discard'.toText(color: AppColors.primaryLight)));
  }

  SingleChildScrollView buildTagsView(List<String> selectedTags, bool isEditMode) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.user == null ? 190.verticalSpace :  130.verticalSpace,
          Builder(builder: (context) {
            var isTagsErr =
                context.listenUniProvider.signupErrFound; // This will auto rebuild if err found.
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
                  // var isSelected = false;
                  var isSelected = selectedTags.contains(tags[i]);
                  return StatefulBuilder(builder: (context, stfState) {
                    return buildChoiceChip(context,
                        selectedColor: AppColors.primaryOriginal,
                        padding: 4,
                        rounded: 8,
                        selected: isSelected,
                        label: tags[i].toText(
                            color: isSelected ? AppColors.white : AppColors.grey50,
                            fontSize: 14), onSelect: (bool newSelection) {
                      isSelected = !isSelected;
                      isSelected ? selectedTags.add(tags[i]) : selectedTags.remove(tags[i]);
                      var currUser = context.uniProvider.currUser;
                      if (!isEditMode) {
                        // On edit mode - this will be save only if 'Save' button clicked.
                        context.uniProvider.updateUser(currUser.copyWith(tags: selectedTags));
                      }
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
