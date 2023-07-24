// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SortFeedModel _$$_SortFeedModelFromJson(Map<String, dynamic> json) =>
    _$_SortFeedModel(
      title: json['title'] as String,
      desc: json['desc'] as String,
      svg: json['svg'] as String,
      solidSvg: json['solidSvg'] as String,
      type: $enumDecode(_$FilterTypesEnumMap, json['type']),
    );

Map<String, dynamic> _$$_SortFeedModelToJson(_$_SortFeedModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'svg': instance.svg,
      'solidSvg': instance.solidSvg,
      'type': _$FilterTypesEnumMap[instance.type]!,
    };

const _$FilterTypesEnumMap = {
  FilterTypes.postsByUser: 'postsByUser',
  FilterTypes.conversationsPostByUser: 'conversationsPostByUser',
  FilterTypes.sortByOldestComments: 'sortByOldestComments',
  FilterTypes.notificationsPostByUser: 'notificationsPostByUser',
  FilterTypes.reportedUsers: 'reportedUsers',
  FilterTypes.reportedRils: 'reportedRils',
  FilterTypes.postWithComments: 'postWithComments',
  FilterTypes.postWithoutComments: 'postWithoutComments',
  FilterTypes.sortFeedByDefault: 'sortFeedByDefault',
  FilterTypes.sortFeedByIsOnline: 'sortFeedByIsOnline',
  FilterTypes.sortFeedByLocation: 'sortFeedByLocation',
  FilterTypes.sortFeedByTopics: 'sortFeedByTopics',
  FilterTypes.sortFeedByAge: 'sortFeedByAge',
};
