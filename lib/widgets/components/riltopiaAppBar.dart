import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Database/firebase_database.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';

// import 'package:example/common/service/Auth/firebase_database.dart';
import 'package:example/widgets/components/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import '../../common/models/post/post_model.dart';
import '../../common/service/mixins/assets.gen.dart';
import '../../widgets/components/postBlock_sts.dart';

import '../../common/themes/app_colors.dart';

List<String> tags = [
  'New',
  'Gaming',
  'Sport',
  'Music',
  'Netflix',
  'TV',
  'Gaming 2',
  'Sport 2',
  'Music 2',
  'Netflix 2',
  'TV 2',
];

class RiltopiaAppBar extends StatelessWidget {
  final int selectedTag;
  final ValueChanged<bool>? onSelected;
  const RiltopiaAppBar(this.selectedTag, {this.onSelected, Key? key}) : super(key: key);

  @override
  PreferredSizeWidget build(BuildContext context) {
    var chipsController = ScrollController();

    return AppBar(
      elevation: 2,
      centerTitle: true,
      backgroundColor: AppColors.primaryDarkOriginal,
      leading: Transform.translate(
        offset: const Offset(5, 0),
        child: CircleAvatar(
          backgroundColor: AppColors.darkGrey,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(context.uniProvider.currUser.photoUrl!),
            backgroundColor: AppColors.darkGrey,
          ),
        ).px(10),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.logoCircularRilTopiaLogo.image(height: 25),
          10.horizontalSpace,
          'RilTopia'.toText(),
        ],
      ),
      actions: [Assets.svg.icons.bellUntitledIcon.svg().px(20).onTap(() {})],
      bottom: PreferredSize(
        preferredSize: const Size(00.0, 50.0),
        child: Card(
          elevation: 0,
          color: AppColors.primaryDarkOriginal,
          child: SizedBox(
            height: 50.0,
            child: ListView(
              controller: chipsController,
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(
                tags.length,
                    (int i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ChoiceChip(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: 10.roundedShape,
                      selected: selectedTag == i,
                      backgroundColor: AppColors.darkOutline,
                      selectedColor: AppColors.white,
                      side: BorderSide(width: 2.0, color: AppColors.grey50.withOpacity(0.20)),
                      // side: BorderSide.none,
                      labelStyle: AppStyles.text14PxSemiBold.copyWith(
                          color: selectedTag == i ? AppColors.primaryDarkOriginal : AppColors.white,
                          fontWeight: selectedTag == i ? FontWeight.bold : FontWeight.normal,
                          // fontWeight: FontWeight.bold,
                          fontSize: 12),
                      label: Text(tags[i]),
                      onSelected: onSelected,
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
