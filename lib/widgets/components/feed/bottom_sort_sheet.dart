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

class BottomSortSheet extends StatefulWidget {
  const BottomSortSheet({Key? key}) : super(key: key);

  @override
  State<BottomSortSheet> createState() => _BottomSortSheetState();
}

class _BottomSortSheetState extends State<BottomSortSheet> {
  late SortFeedModel sFilter;
  final defaultFilter = SortFeedModel(
    title: 'Default',
    desc: 'View Rils by Timeline',
    svg: Assets.svg.icons.sortByDefault,
    type: FilterTypes.sortFeedByDefault,
  );
  final locationFilter = SortFeedModel(
    title: 'Your location',
    desc: 'View Rils from members around you',
    svg: Assets.svg.icons.sortByLocation,
    type: FilterTypes.sortFeedByLocation,
  );
  final topicsFilter = SortFeedModel(
    title: 'Your topics',
    desc: 'View Rils from members like you',
    svg: Assets.svg.icons.wisdomMultiLightStar,
    type: FilterTypes.sortFeedByTopics,
  );
  final ageFilter = SortFeedModel(
    title: 'Your age',
    desc: 'View Rils from members in your age',
    svg: Assets.svg.icons.sortByAge,
    type: FilterTypes.sortFeedByAge,
  );

  @override
  void initState() {
    sFilter = defaultFilter;
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
            sFilter.desc.toText(fontSize: 14, color: AppColors.greyLight),
            10.verticalSpace,
            buildRadioItem(defaultFilter),
            buildRadioItem(locationFilter),
            buildRadioItem(topicsFilter),
            buildRadioItem(ageFilter),
            20.verticalSpace,
          ],
        ).px(20),
      ),
    );
  }

  Widget buildRadioItem(SortFeedModel filter) {
    void updateValue() {
      sFilter = filter;
      context.uniProvider.currFilterTempUpdate(filter.type);
      setState(() {});
    }

    return ListTile(
      shape: 10.roundedShape,
      onTap: updateValue,
      horizontalTitleGap: 10,
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      title: filter.title.toText(
        medium: true,
        fontSize: 15,
        color: sFilter == filter ? AppColors.primaryOriginal : AppColors.white,
      ),
      leading: filter.svg.svg(
        color: sFilter == filter ? AppColors.primaryOriginal : AppColors.white,
        height: 22,
      ),
      trailing: Radio(
        activeColor: AppColors.primaryOriginal,
        value: filter,
        groupValue: sFilter,
        onChanged: (value) => updateValue(),
      ).scale(scale: 1.15),
    );
  }
}
