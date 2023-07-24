import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/feedFilterModel/sort_feed_model.dart';
import '../../../common/service/Database/db_advanced.dart';
import '../../../common/service/mixins/assets.gen.dart';
import '../postBlock_stf.dart';

final sortByDefault = SortFeedModel(
  title: 'Default',
  desc: 'Rils from members by timeline',
  svg: 'assets/svg/icons/sort-by-default.svg',
  solidSvg: 'assets/svg/icons/sort-by-default-solid.svg',
  type: FilterTypes.sortFeedByDefault,
);
final sortByIsOnline = SortFeedModel(
  title: 'Online members',
  desc: 'Rils from online members',
  svg: 'assets/svg/icons/user-circle-outline.svg',
  solidSvg: 'assets/svg/icons/user-circle-solid.svg',
  type: FilterTypes.sortFeedByIsOnline,
);
final sortByLocation = SortFeedModel(
  title: 'Your location',
  // desc: 'Latest Rils by members around you',
  desc: 'Rils from members around you',
  svg: 'assets/svg/icons/sort-by-location.svg',
  solidSvg: 'assets/svg/icons/sort-by-location-solid.svg',
  type: FilterTypes.sortFeedByLocation,
);
final sortByTopic = SortFeedModel(
  title: 'Your topics',
  // desc: 'Latest Rils by members like you',
  // desc: 'Rils from members like you',
  desc: 'Rils from your topics',
  // svg: Assets.svg.icons.wisdomMultiLightStar,
  svg: 'assets/svg/icons/sort-by-topic.svg',
  solidSvg: 'assets/svg/icons/sort-by-topic-solid.svg',
  type: FilterTypes.sortFeedByTopics,
);
final sortByAge = SortFeedModel(
  title: 'Your age',
  // desc: 'Latest Rils by members in your age',
  desc: 'Rils from members in your age',
  svg: 'assets/svg/icons/sort-by-age.svg',
  solidSvg: 'assets/svg/icons/sort-by-age-solid.svg',
  type: FilterTypes.sortFeedByAge,
);

class BottomSortSheet extends StatefulWidget {
  const BottomSortSheet({Key? key}) : super(key: key);

  @override
  State<BottomSortSheet> createState() => _BottomSortSheetState();
}

class _BottomSortSheetState extends State<BottomSortSheet> {
  late SortFeedModel selectedFeedSort;

  @override
  void initState() {
    selectedFeedSort = context.uniProvider.sortFeedBy;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currUser = context.uniProvider.currUser;
    final ageRange = ageRangeList(currUser);
    final ageRangeStr = ' (${ageRange.first} - ${ageRange.last})';
    String desc = selectedFeedSort.desc.tr();

    if (selectedFeedSort.type == FilterTypes.sortFeedByAge) {
      desc += ageRangeStr;
    }

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Material(
        child: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                25.verticalSpace,
                'Sort by'.toText(bold: true, fontSize: 20),
                10.verticalSpace,
                desc.toText(fontSize: 14, color: AppColors.greyLight),
                10.verticalSpace,
                buildRadioItem(sortByDefault),
                buildRadioItem(sortByLocation),
                buildRadioItem(sortByTopic),
                buildRadioItem(sortByAge),
                buildRadioItem(sortByIsOnline, isActive: false),
                10.verticalSpace,
              ],
            ).px(20),
            Positioned(
                top: 0,
                right: context.hebLocale ? null : 0,
                left: context.hebLocale ? 0 : null,
                child: Icons.close_rounded
                    .icon(color: AppColors.greyUnavailable, size: 22)
                    .px(12)
                    .py(12)
                    .onTap(() => updateValue(selectedFeedSort, alsoClose: true), radius: 10))
          ],
        ),
      ),
    );
  }

  void updateValue(SortFeedModel filter, {bool alsoClose = false}) {
    selectedFeedSort = filter;
    context.uniProvider.sortFeedByUpdate(filter, notify: false);
    setState(() {});
    if (alsoClose) Navigator.pop(context);
  }

  Widget buildRadioItem(SortFeedModel filter, {bool isActive = true}) {
    return ListTile(
      shape: 10.roundedShape,
      onTap: isActive ? () => updateValue(filter) : null,
      horizontalTitleGap: 10,
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      title: filter.title.toText(
        medium: true,
        fontSize: 15,
        color: isActive
            // ? (selectedFeedSort == filter ? AppColors.primaryOriginal : AppColors.white)
            ? AppColors.white
            : AppColors.darkOutline50,
      ),
      subtitle: isActive
          ? null
          : 'coming soon!'.toText(
              fontSize: 13,
              color: AppColors.darkOutline50,
            ),
      leading: Stack(
        children: [
          SvgGenImage(filter.svg).svg(
            color: isActive
                // ? (selectedFeedSort == filter ? AppColors.primaryOriginal : AppColors.white)
                ? AppColors.white
                : AppColors.darkOutline50,
            height: 22,
          ),
          if (filter.type == FilterTypes.sortFeedByIsOnline) buildUserCircleOnline(isActive),
        ],
      ),
      trailing: Radio(
        activeColor: AppColors.primaryOriginal,
        fillColor: isActive ? null : MaterialStateProperty.all(AppColors.darkOutline50),
        value: filter,
        groupValue: selectedFeedSort,
        onChanged: isActive ? (val) => updateValue(filter) : null,
      ).scale(scale: 1.15),
    );
  }
}

//~Main widget is buildOnlineBadge()
// This Used only for userCircleSolid user-circle ICON
Positioned buildUserCircleOnline(bool isActive) {
  return Positioned(
      top: -2,
      right: -2,
      child: CircleAvatar(
          radius: 6,
          backgroundColor: AppColors.darkBg,
          child:
              Opacity(opacity: isActive ? 1.0 : 0.35, child: const BlinkingOnlineBadge(ratio: 1))));
}
