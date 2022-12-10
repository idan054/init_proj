import 'dart:async';
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

  Future<List> handleGetModel(BuildContext context, ModelTypes modelType) async {
    print('START: handleGetModel()');
    var collectionName = modelType.name;
    var currUser = context.uniProvider.currUser;
    var startAtDocId = context.uniProvider.startAtDocId; // Not from Hive - Hard cache unneeded.
    DocumentSnapshot? startAtDoc;

    // 1) Get Doc based ID:
    if (startAtDocId != null) {
      startAtDoc = await db.collection(collectionName).doc(startAtDocId).get();
      context.uniProvider.updateStartAtDocId(startAtDoc.id);
    }

    // 2) Set modelList from Database docs:
    print('Start fetch From: ${startAtDoc == null ? 'Most recent' : startAtDoc.id}');
    var docs = await getDocsBasedModel(currUser.uid!, startAtDoc, modelType);
    var modelList = await docsToModelList(docs, modelType);

    print('✴️ SUMMARY: ${modelList.length} ${collectionName.toUpperCase()}');
    return modelList;
  }

  // static Future<List<PostModel>?> getDocsEndBefore
  Future<QuerySnapshot<Map<String, dynamic>>> getDocsBasedModel(
      String uid, DocumentSnapshot? startAfterDoc, ModelTypes modelType) async {
    print('START: getDocsBasedModel() - ${modelType.name}');
    print(startAfterDoc == null
        ? 'No startAfterDoc found! - Get most recent instead.'
        : 'startAfterDoc ${startAfterDoc.id}');

    QuerySnapshot<Map<String, dynamic>>? docs;
    var reqBase = db.collection(modelType.name).orderBy('timestamp', descending: true).limit(6);

    switch (modelType) {
      case ModelTypes.posts:
      case ModelTypes.messages:
      case ModelTypes.users:
        docs = startAfterDoc == null
            ? await reqBase.get()
            : await reqBase.startAfterDocument(startAfterDoc).get();
        break;
      case ModelTypes.chats:
        docs = startAfterDoc == null
            ? await reqBase.where('usersIds', arrayContains: uid).get()
            : await reqBase
                .startAfterDocument(startAfterDoc)
                .where('usersIds', arrayContains: uid)
                .get();
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
