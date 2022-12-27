import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:example/common/service/hive_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebase_database.dart';

class FsAdvanced {
  static final db = FirebaseFirestore.instance;

  Future<List> handleGetModel(BuildContext context, ModelTypes modelType, List? currList,
      {String? collectionReference}) async {
    var collectionRef = collectionReference ?? modelType.name;
    print('START: handleGetModel() [$collectionRef]');
    var modelList = currList ?? [];
    var currUser = context.uniProvider.currUser;

    Timestamp? timeStamp;
    if (currList != null && currList.isNotEmpty) {
      // DocumentSnapshot? startAtDoc;
      // startAtDoc = await db.collection(collectionRef).doc(currList.last.id).get(); // OLD VERSION

      // Every Model must have 'timestamp'! (postModel, userModel etc...)
      timeStamp = Timestamp.fromDate(currList.last.timestamp!);
    }

    // 2) Set modelList from Database snap:
    print('Start fetch From: ${timeStamp == null ? 'Most recent' : 'timeStamp'}');
    var snap = await getDocsBasedModel(currUser.uid!, timeStamp, modelType, collectionRef);

    // 3) .fromJson() To postModel, userModel etc...
    if (snap.docs.isNotEmpty) {
      var newItems = await docsToModelList(snap, modelType);

      modelList = [...modelList, ...newItems];
      print('✴️ SUMMARY: ${modelList.length} ${collectionRef.toUpperCase()}');
      return modelList;
    } else {
      // throw Exception('No More $collectionRef Found!!!');
      return [];
    }
  }

  // static Future<List<PostModel>?> getDocsEndBefore
  Future<QuerySnapshot<Map<String, dynamic>>> getDocsBasedModel(
      String uid, Timestamp? timestamp, ModelTypes modelType, String collectionRef) async {
    print('START: getDocsBasedModel() - ${modelType.name}');
    print(timestamp == null
        ? 'timestamp not found! - Get most recent instead.'
        : 'timestamp: $timestamp');

    QuerySnapshot<Map<String, dynamic>>? docs;
    var reqBase = db.collection(collectionRef).orderBy('timestamp', descending: true).limit(8);

    switch (modelType) {
      case ModelTypes.posts: // Same as below V
      case ModelTypes.messages: // Same as below V
      case ModelTypes.users: // Same as below V
        docs =
            timestamp == null ? await reqBase.get() : await reqBase.startAfter([timestamp]).get();
        break;
      case ModelTypes.chats:
        reqBase = reqBase.where('usersIds', arrayContains: uid);
        docs =
            timestamp == null ? await reqBase.get() : await reqBase.startAfter([timestamp]).get();
        break;
    }

    return docs;
  }

  Future<List> docsToModelList(
      QuerySnapshot<Map<String, dynamic>> snap, ModelTypes modelType) async {
    print('START: docsToModelList() - ${modelType.name}');

    List listModel;
    switch (modelType) {
      case ModelTypes.posts:
        listModel = snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
        break;
      case ModelTypes.chats:
        listModel = snap.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
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
