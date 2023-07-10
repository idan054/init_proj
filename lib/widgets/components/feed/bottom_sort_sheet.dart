import 'dart:ui';

import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/models/feedFilterModel/sort_feed_model.dart';
import '../../../common/service/mixins/assets.gen.dart';

final sortByDefault = SortFeedModel(
  title: 'Default',
  desc: 'Latest Rils by timeline',
  svg: Assets.svg.icons.sortByDefault,
  solidSvg: Assets.svg.icons.sortByDefaultSolid,
  type: FilterTypes.sortFeedByDefault,
);
final sortByLocation = SortFeedModel(
  title: 'Your location',
  desc: 'Latest Rils by members around you',
  svg: Assets.svg.icons.sortByLocation,
  solidSvg: Assets.svg.icons.sortByLocationSolid,
  type: FilterTypes.sortFeedByLocation,
);
final sortByTopic = SortFeedModel(
  title: 'Your topics',
  desc: 'Latest Rils by members like you',
  // svg: Assets.svg.icons.wisdomMultiLightStar,
  svg: Assets.svg.icons.sortByTopic,
  solidSvg: Assets.svg.icons.sortByTopicSolid,
  type: FilterTypes.sortFeedByTopics,
);
final sortByAge = SortFeedModel(
  title: 'Your age',
  desc: 'Latest Rils by members in your age',
  svg: Assets.svg.icons.sortByAge,
  solidSvg: Assets.svg.icons.sortByAgeSolid,
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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Material(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            25.verticalSpace,
            'Sort by'.toText(bold: true, fontSize: 20),
            10.verticalSpace,
            selectedFeedSort.desc.toText(fontSize: 14, color: AppColors.greyLight),
            10.verticalSpace,
            buildRadioItem(sortByDefault),
            buildRadioItem(sortByLocation, isActive: false),
            buildRadioItem(sortByTopic, isActive: false),
            buildRadioItem(sortByAge),
            20.verticalSpace,
          ],
        ).px(20),
      ),
    );
  }

  Widget buildRadioItem(SortFeedModel filter, {bool isActive = true}) {
    void updateValue() {
      selectedFeedSort = filter;
      context.uniProvider.sortFeedByUpdate(filter);
      setState(() {});
      Navigator.pop(context);
    }

    return ListTile(
      shape: 10.roundedShape,
      onTap: isActive ? updateValue : null,
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
      leading: filter.svg.svg(
        color: isActive
            // ? (selectedFeedSort == filter ? AppColors.primaryOriginal : AppColors.white)
            ? AppColors.white
            : AppColors.darkOutline50,
        height: 22,
      ),
      trailing: Radio(
        activeColor: AppColors.primaryOriginal,
        fillColor: isActive ? null : MaterialStateProperty.all(AppColors.darkOutline50),
        value: filter,
        groupValue: selectedFeedSort,
        onChanged: isActive ? (value) => updateValue() : null,
      ).scale(scale: 1.15),
    );
  }
}
