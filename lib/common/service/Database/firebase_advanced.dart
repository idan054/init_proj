// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers

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

  Future<List> handleGetModel(
    ModelTypes modelType,
    List? currList, {
    String? collectionReference,
    FilterTypes? filter,
    String? uid,
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
    var snap = await getDocsBasedModel(uid, timeStamp, modelType, collectionRef, filter: filter);

    // 2/2) .fromJson() To postModel, userModel etc...
    if (snap.docs.isNotEmpty) {
      var newItems = await docsToModelList(snap, modelType);

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
      String? uid, Timestamp? timestamp, ModelTypes modelType, String collectionRef,
      {FilterTypes? filter}) async {
    print('START: getDocsBasedModel() - ${modelType.name}');
    print(timestamp == null
        ? 'timestamp not found! - Get most recent instead.'
        : 'timestamp: $timestamp');

    QuerySnapshot<Map<String, dynamic>>? docs;
    var reqBase = db.collection(collectionRef).orderBy('timestamp', descending: true).limit(8);
    if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    switch (modelType) {
      case ModelTypes.messages: // Nothing special
      case ModelTypes.users: // Nothing special
        break;
      case ModelTypes.posts:
        if (filter == FilterTypes.postsByUser) {
          reqBase = reqBase.where('creatorUser.uid', isEqualTo: uid!);
        }
        break;
      case ModelTypes.chats:
        reqBase = reqBase.where('usersIds', arrayContains: uid!);
        break;
    }
    docs = await reqBase.get();
    return docs;
  }

  // 2/2
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
