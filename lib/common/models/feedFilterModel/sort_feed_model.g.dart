// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SortFeedModel _$$_SortFeedModelFromJson(Map<String, dynamic> json) =>
    _$_SortFeedModel(
      title: json['title'] as String,
      desc: json['desc'] as String,
      svg: json['svg'],
      type: $enumDecode(_$FilterTypesEnumMap, json['type']),
    );

Map<String, dynamic> _$$_SortFeedModelToJson(_$_SortFeedModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'desc': instance.desc,
      'svg': instance.svg,
      'type': _$FilterTypesEnumMap[instance.type]!,
    };

const _$FilterTypesEnumMap = {
  FilterTypes.postsByUser: 'postsByUser',
  FilterTypes.conversationsPostByUser: 'conversationsPostByUser',
  FilterTypes.notificationsPostByUser: 'notificationsPostByUser',
  FilterTypes.postWithoutComments: 'postWithoutComments',
  FilterTypes.postWithComments: 'postWithComments',
  FilterTypes.reportedUsers: 'reportedUsers',
  FilterTypes.reportedRils: 'reportedRils',
  FilterTypes.sortByOldestComments: 'sortByOldestComments',
  FilterTypes.sortFeedByDefault: 'sortFeedByDefault',
  FilterTypes.sortFeedByLocation: 'sortFeedByLocation',
  FilterTypes.sortFeedByTopics: 'sortFeedByTopics',
  FilterTypes.sortFeedByAge: 'sortFeedByAge',
};
