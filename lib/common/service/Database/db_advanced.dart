// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/report/report_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/dump/hive_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:haversine_distance/haversine_distance.dart';
import 'firebase_db.dart';

import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/screens/auth_ui/a_onboarding_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/routes/app_router.dart';
import 'package:example/common/routes/app_router.gr.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Database/firebase_db.dart';
import 'package:example/common/service/Feed/feed_services.dart';
import 'package:example/common/themes/app_colors_inverted.dart';
import 'package:example/common/themes/app_styles.dart';
import 'package:example/main.dart';
import 'package:collection/collection.dart'; // You have to add this manually,
// import 'package:example/common/service/Auth/firebase_db.dart';
import 'package:example/common/dump/postViewOld_sts.dart';
import 'package:example/widgets/my_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:transparent_image/transparent_image.dart';

class FsAdvanced {
  static final db = FirebaseFirestore.instance;

  Future<List> handleGetModel(
    BuildContext context,
    ModelTypes modelType,
    List? currList, {
    UserModel? otherUser, // For User_page.dart
    String? collectionReference,
    FilterTypes? filter,
  }) async {
    var collectionRef = collectionReference ?? modelType.name;
    print('START: handleGetModel() [$collectionRef]');
    var modelList = currList ?? [];

    Timestamp? timeStamp;
    if (currList != null && currList.isNotEmpty) {
      //Todo: Every Model must have 'timestamp'! (postModel, userModel etc...)
      timeStamp = Timestamp.fromDate(currList.last.timestamp!);
    }

    // 1/2) Set modelList from Database snap:
    printWhite('Start fetch From: ${timeStamp == null ? 'Most recent' : 'timeStamp'}');
    var snap =
        await getDocsBasedModel(context, timeStamp, modelType, collectionRef, filter, otherUser);

    // 2/2) .fromJson() To postModel, userModel etc...
    if (snap.docs.isNotEmpty) {
      var newItems = await _docsToModelList(context, snap, modelType);

      modelList = [...modelList, ...newItems];
      print('✴️ SUMMARY: ${modelList.length} ${collectionRef.toUpperCase()}');
      return modelList;
    } else {
      print(' SUMMARY: No new ${modelType.name} Found.');
      // throw Exception('No More $collectionRef Found!!!');
      return [];
    }
  }

  // 1/2
  Future<QuerySnapshot<Map<String, dynamic>>> getDocsBasedModel(
    BuildContext context,
    Timestamp? timestamp,
    ModelTypes modelType,
    String collectionRef,
    FilterTypes? filter,
    UserModel? user,
  ) async {
    print('START: getDocsBasedModel() - ${modelType.name}');

    print(timestamp == null
        ? 'timestamp not found! - Get most recent instead.'
        : 'timestamp: ${timestamp.toDate()}');

    var currUser = context.uniProvider.currUser;
    QuerySnapshot<Map<String, dynamic>>? snap;
    var limit = modelType == ModelTypes.messages ? 24 : 16; // Original: 24 : 8
    var reqBase = db.collection(collectionRef).limit(limit);

    if (filter == FilterTypes.sortByOldestComments) {
      // Start from OLDEST Begging 1st (Comments)
      reqBase = reqBase.orderBy('timestamp', descending: false);
    } else {
      // Start from NEWEST LASTED (POSTS / MSGS..)
      reqBase = reqBase.orderBy('timestamp', descending: true);
    }
    if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    switch (modelType) {
      case ModelTypes.messages: // Nothing special
      case ModelTypes.users: // Nothing special
      case ModelTypes.reports:
        if (filter == FilterTypes.reportedRils) {
          reqBase = reqBase.where('reportStatus', isEqualTo: 'newReport');
        }
        break;
      case ModelTypes.posts:
        //~ Filters (query) REQUIRE an index. Check log to create it.

        if (filter == FilterTypes.postsByUser) {
          reqBase = reqBase.where('creatorUser.uid', isEqualTo: user!.uid); // curr / other user
          reqBase = reqBase.where('enableComments', isEqualTo: false);
        }
        if (filter == FilterTypes.conversationsPostByUser) {
          reqBase = reqBase.where('commentedUsersEmails', arrayContains: user!.email);

          // TODO Conversations User_page 2 filters: (chips Ui): (1) user Create (2) user part of.
          // reqBase = reqBase.where('creatorUser.uid', isEqualTo: uid); // curr / other user
          // reqBase = reqBase.where('enableComments', isEqualTo: true);
        }
        if (filter == FilterTypes.postWithComments) {
          reqBase = reqBase.where('enableComments', isEqualTo: true);
        }
        if (filter == FilterTypes.postWithoutComments) {
          reqBase = reqBase.where('enableComments', isEqualTo: false);

          //~ NEW SortFeedBy:
          final sortFeedBy = context.uniProvider.sortFeedBy.type;
          if (sortFeedBy == FilterTypes.sortFeedByDefault) {
            // Nothing needed
          }
          if (sortFeedBy == FilterTypes.sortFeedByLocation) {
            print('START: sortFeedByLocation()');

            //! NOT WORKING! And Not in use because limitation: https://pub.dev/packages/geoflutterfire2
            //> Do client filter instead

            // double radius = 50; // KM
            // final centerGeo = currUser.position!.geopoint!;
            // final center = GeoFirePoint(centerGeo.latitude, centerGeo.latitude);
            // // Stream<List<DocumentSnapshot>> stream
            // final stream = GeoFlutterFire().collection(collectionRef: reqBase).within(
            //       center: center,
            //       radius: radius,
            //       // field: 'position', // TEST DOC ALSO AVAILABLE
            //       field: 'creatorUser.position',
            //     );
            // stream.listen((List<DocumentSnapshot> documentList) {
            //   print('documentList $documentList');
            // });
          }
          if (sortFeedBy == FilterTypes.sortFeedByTopics) {
            // post.tag = POSTS From topics user like
            reqBase = reqBase.where('tag', whereIn: currUser.tags);
            // post.creatorUser.tag = POSTS From user with same interests
            // reqBase = reqBase.where('creatorUser.tags', arrayContainsAny: currUser.tags);

            // arrayContains = if "X" in Firestore array ["X", "Y"]
            // arrayContainsAny = if any item from ["X", "Y"] in Firestore array ["X", "Y"]
          }
          if (sortFeedBy == FilterTypes.sortFeedByAge) {
            reqBase = reqBase.where('creatorUser.age', whereIn: ageRangeList(currUser));
          }
          if (sortFeedBy == FilterTypes.sortFeedByIsOnline) {}
        }

        if (filter == FilterTypes.notificationsPostByUser) {
          reqBase =
              reqBase.where('metadata.usersWithUnreadNotification', arrayContains: currUser.email!);
        }
        break;
      case ModelTypes.chats:
        reqBase = reqBase.where('usersIds', arrayContains: currUser.uid);
        break;
    }
    snap = await reqBase.get();
    print('DONE: getDocsBasedModel() - ${modelType.name} [${snap.size} docs]');
    return snap;
  }

  // 2/2
  Future<List> _docsToModelList(
      BuildContext context, QuerySnapshot<Map<String, dynamic>> snap, ModelTypes modelType) async {
    print('START: docsToModelList() - ${modelType.name}');
    final currUser = context.uniProvider.currUser;
    final sortFeedBy = context.uniProvider.sortFeedBy.type;
    final currFilter = context.uniProvider.currFilter;

    List listModel;
    switch (modelType) {
      case ModelTypes.posts:
        listModel = snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
        if (sortFeedBy == FilterTypes.sortFeedByLocation &&
            currFilter == FilterTypes.postWithoutComments) {
          listModel = _byRangePosts(context, listModel);
        }
        listModel = _removeBlockedUsers(context, listModel);

        for (var post in [...listModel]) {
          listModel.remove(post);
          var user = await getUserByEmailIfNeeded(context, post.creatorUser);
          post = post.copyWith(creatorUser: user);
          post = updatePostNotificationIfNeeded(context, post);
          listModel.add(post);
        }
        break;

      case ModelTypes.chats:
        // Add unreadCounter to listModel
        listModel = snap.docs.map((doc) {
          var chat = ChatModel.fromJson(doc.data());
          chat = chat.copyWith(
              unreadCounter: doc.data()['metadata']?['unreadCounter#${currUser.uid}']);
          return chat;
        }).toList();

        // for (var chat in [...listModel]) {
        //   var otherUser = chat.users?.firstWhere((user) => user.email != currUser.email);
        //   listModel.remove(chat);
        //   var user = await getUserByEmailIfNeeded(context, otherUser);
        //   chat = chat.copyWith(users: [user, currUser]);
        //   listModel.add(chat);
        // }

        break;
      case ModelTypes.messages:
        listModel = snap.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
        break;
      case ModelTypes.users:
        listModel = snap.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
        break;

      case ModelTypes.reports:
        listModel = snap.docs.map((doc) => ReportModel.fromJson(doc.data())).toList();
        break;
    }

    return listModel;
  }

  List _byRangePosts(BuildContext context, List listModel) {
    print('START: _inRangePosts()');
    const range = 175; // KM
    final inRangePosts = <PostModel>[];
    for (PostModel post in [...listModel]) {
      final postLatitude = post.creatorUser?.position?.geopoint?.latitude;
      final postLongitude = post.creatorUser?.position?.geopoint?.longitude;
      final currUserLatitude = context.uniProvider.currUser.position?.geopoint?.latitude;
      final currUserLongitude = context.uniProvider.currUser.position?.geopoint?.longitude;

      if (postLatitude == null || currUserLatitude == null) {
      } else {
        final haversineDistance = HaversineDistance();
        final startCoordinate = Location(postLatitude, postLongitude!);
        final endCoordinate = Location(currUserLatitude, currUserLongitude!);
        var distance = haversineDistance.haversine(startCoordinate, endCoordinate, Unit.KM).floor();
        print('${post.textContent} - distance $distance');

        final postInRange = post.copyWith(distance: distance.toInt());
        if (distance <= range) inRangePosts.add(postInRange);
      }
    }
    return inRangePosts;
  }

  List _removeBlockedUsers(BuildContext context, List listModel) {
    print('START: _removeBlockedUsers()');
    var blockedUsers = context.uniProvider.currUser.blockedUsers;
    for (var post in [...listModel]) {
      if (blockedUsers.contains(post.creatorUser!.uid)) {
        printYellow('POST Remove locally from ${post.creatorUser?.email}');
        listModel.remove(post);
      }
    }
    return listModel;
  }

  // Also update uniProvider
  // This actually called on openChat(), PostModel & ChatModel
  static Future<UserModel> getUserByEmailIfNeeded(
      BuildContext context, UserModel userSource) async {
    // print('START: getUserByEmailIfNeeded()');
    String? userEmail = userSource.email;
    var alreadyFetchedUsers = context.uniProvider.fetchedUsers;
    var isAlreadyFetched = alreadyFetchedUsers.any((user) => user.email == userEmail);

    UserModel? existUser;
    if (isAlreadyFetched) {
      printGreen('USER STATUS: $userEmail ALREADY FETCHED (:');
      existUser = alreadyFetchedUsers.firstWhere((user) => user.email == userEmail);
    } else {
      var userData = await Database.docData('users/$userEmail');
      if (userData == null) {
        printRed('Couldn\'t fetch User $userEmail');
        return userSource;
      } else {
        printOrange('USER STATUS: $userEmail FETCHED SUCCESSFULLY!');
        var newUser = UserModel.fromJson(userData);
        // Will rebuild
        // context.uniProvider.fetchedUsersUpdate([newUser, ...alreadyFetchedUsers]);
        // Will NOT rebuild
        context.uniProvider.fetchedUsers = [newUser, ...alreadyFetchedUsers];
        return newUser;
      }
    }
    return existUser;
  }

  static PostModel updatePostNotificationIfNeeded(BuildContext context, PostModel post) {
    var fetchedPosts = context.uniProvider.fetchedPosts;

    PostModel? fetchedPost = fetchedPosts.firstWhereOrNull((_post) => _post.id == post.id);
    if (fetchedPost != null) {
      post = post.copyWith(notificationsCounter: fetchedPost.notificationsCounter);
    }
    return post;
  }
}

// Example: 12, 13, 14, (15), 16, 17, 18
List ageRangeList(UserModel currUser) {
  List ageRangeList = [];
  int age = currUser.age!;
  int range = 3;
  for (int i = age - range; i <= age + range; i++) {
    ageRangeList.add(i);
  }
  return ageRangeList;
}
