// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/color_printer.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/service/hive_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_db.dart';

class FsAdvanced {
  static final db = FirebaseFirestore.instance;

  Future<List> handleGetModel(
    BuildContext context,
    ModelTypes modelType,
    List? currList, {
    String? uid, // Could be different than curr user, like in UserScreen()
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
    print('Start fetch From: ${timeStamp == null ? 'Most recent' : 'timeStamp'}');
    var snap = await getDocsBasedModel(context, timeStamp, modelType, collectionRef,
        filter: filter, uid: uid);

    // 2/2) .fromJson() To postModel, userModel etc...
    if (snap.docs.isNotEmpty) {
      var newItems = await docsToModelList(context, snap, modelType);

      modelList = [...modelList, ...newItems];
      print('✴️ SUMMARY: ${modelList.length} ${collectionRef.toUpperCase()}');
      return modelList;
    } else {
      print('✴️ SUMMARY: No new ${modelType.name} Found.');
      // throw Exception('No More $collectionRef Found!!!');
      return [];
    }
  }

  // 1/2
  Future<QuerySnapshot<Map<String, dynamic>>> getDocsBasedModel(
      BuildContext context, Timestamp? timestamp, ModelTypes modelType, String collectionRef,
      {FilterTypes? filter, String? uid}) async {
    print('START: getDocsBasedModel() - ${modelType.name}');

    print(timestamp == null
        ? 'timestamp not found! - Get most recent instead.'
        : 'timestamp: $timestamp');

    var limit = modelType == ModelTypes.messages ? 25 : 8;
    QuerySnapshot<Map<String, dynamic>>? docs;
    var reqBase = db.collection(collectionRef).orderBy('timestamp', descending: true).limit(limit);
    if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    switch (modelType) {
      case ModelTypes.messages: // Nothing special
      case ModelTypes.users: // Nothing special
        break;
      case ModelTypes.posts:
        //~ Filters (query) REQUIRE an index. Check log to create it.

        if (filter == FilterTypes.postsByUser) {
          reqBase = reqBase.where('creatorUser.uid', isEqualTo: uid); // curr / other user
          reqBase = reqBase.where('enableComments', isEqualTo: false);
        }
        if (filter == FilterTypes.converstionsPostByUser) {
          reqBase = reqBase.where('commentedUsersIds', arrayContains: uid!); // curr / other user
        }
        if (filter == FilterTypes.postWithComments) {
          reqBase = reqBase.where('enableComments', isEqualTo: true);
        }
        if (filter == FilterTypes.postWithoutComments) {
          reqBase = reqBase.where('enableComments', isEqualTo: false);
        }
        break;
      case ModelTypes.chats:
        reqBase = reqBase.where(
          'usersIds',
          arrayContains: context.uniProvider.currUser.uid!,
        );
        break;
    }
    docs = await reqBase.get();
    return docs;
  }

  // 2/2
  Future<List> docsToModelList(
      BuildContext context, QuerySnapshot<Map<String, dynamic>> snap, ModelTypes modelType) async {
    print('START: docsToModelList() - ${modelType.name}');
    var currUid = context.uniProvider.currUser.uid;
    List listModel;
    switch (modelType) {
      case ModelTypes.posts:
        listModel = snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

        // Remove locally because can't multiple 'isNotEqualTo' on server (Compare 2 lists)
        var blockedUsers = context.uniProvider.currUser.blockedUsers;
        for (var post in [...listModel]) {
          if (blockedUsers.contains(post.creatorUser!.uid)) {
            printYellow('Post Remove locally from ${post.creatorUser.email}');
            listModel.remove(post);
          }
        }
        break;
      case ModelTypes.chats:
        listModel = snap.docs.map((doc) {
          var chat = ChatModel.fromJson(doc.data());
          chat = chat.copyWith(unreadCounter: doc.data()['metadata']?['unreadCounter#$currUid']);
          return chat;
        }).toList();
        break;
      case ModelTypes.messages:
        listModel = snap.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
        break;
      case ModelTypes.users:
        listModel = snap.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
        break;
    }

    return listModel;
  }
}
