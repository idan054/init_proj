import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/chat/hive/hive_chat_model.dart';
import 'package:example/common/models/message/hive/hive_message_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/post/hive/hive_post_model.dart';
import '../../models/user/hive/hive_user_model.dart';
import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;
import '../Hive/hive_services.dart';
import '../Hive/timestamp_convert.dart';
import 'firebase_database.dart';

class FsAdvanced {
  static final db = FirebaseFirestore.instance;

  //~ The AMAZING SMART func that perfectly choose
  //~ when to use Hive (cache) / Firestore (Database).
  //! Cached Also means Deleted posts/ users/ chats/ messages will still show.
  // U can fix it by request on SplashScreen "deleted_posts" doc and update Hive based.
  //> Currently use for posts & chats
  Future handleGetDocs(BuildContext context, ModelTypes modelType, {bool latest = true}) async {
    var modelTypeName = modelType.name;
    print('START: handleGetDocs of $modelTypeName()');

    //> (1) Get All posts from cache & (2) Get Latest cached post
    var cacheHiveDocsList = HiveServices.uniBox.get('cache${modelTypeName}List') ?? [];
    var results = await HiveServices.getStartEndAtDocBasedCache(cacheHiveDocsList, modelType);
    var cacheDocsList = results['cacheDocsList'];
    var endBeforeDoc = results['endBeforeDoc'];
    var startAtDoc = results['startAtDoc'];

    //> (3) Check if new & Get new posts after that from server
    // getPostsEndBefore() - Latest posts (if user upload new) - Stop on cache.
    // getPostsStartAt() - 10 new posts who didn't fetched yet - Start after cache.
    // so the post list order is [Latest posts -> cache -> older posts]

    var newDocsList;
    if (modelType == ModelTypes.posts) {
      newDocsList = latest && cacheDocsList.isNotEmpty
          ? await getDocsEndBefore(context, endBeforeDoc, modelType) ?? []
          : await getDocsStartAt(context, startAtDoc, modelType) ?? [];
    } else if (modelType == ModelTypes.chats) {
      var currUser = context.uniProvider.currUser;
      newDocsList = latest && cacheDocsList.isNotEmpty
          ? await Database.getChatsBefore(currUser.uid!, endBeforeDoc) ?? []
          : await Database.getChatsAfter(currUser.uid!, startAtDoc) ?? [];
      // newDocsList = await Database.getChats(currUser.uid!);
    } else if (modelType == ModelTypes.users) {
      newDocsList = [];
      print('No new docs found, not configured yet!');
    } else if (modelType == ModelTypes.messages) {
      newDocsList = [];
      print('No new docs found, not configured yet!');
    }

    //> (4) Remove duplicate, save to cache & Summary
    var noDuplicateList = HiveServices.updateCacheDocsList(modelType,
        latest: latest, cacheDocsList: cacheDocsList, newDocsList: newDocsList);

    print('SUMMARIES:');
    print(latest
        ? '✴️ (${newDocsList.length}) ${modelTypeName.toUpperCase()} From Database (Latest) [EndBefore] ✴️ '
        : '✴️ (${newDocsList.length}) ${modelTypeName.toUpperCase()} From Database (older) [StartAt] ✴️ ');
    print('❇️ (${cacheDocsList.length}) ${modelTypeName.toUpperCase()} From Hive CACHE ❇️ ');
    print('⚜️ Overall ${modelTypeName.toUpperCase()}: ${noDuplicateList.length} ⚜️');
    return noDuplicateList;
  }

  Future<DocumentSnapshot> getStartEndAtDoc(String collection, String? docId) async {
    print('START: getStartAtDoc()');

    if (docId != null) {
      print('GET DOC BASED OLD ONE... (StartAt)');
      var oldestSeenPostDoc = await db.collection(collection).doc(docId).get();
      return oldestSeenPostDoc;
    } else {
      print('GET DOC BASED null: USE MOST RECENT INSTEAD!');
      var mostRecentPostDoc = await db
          .collection(collection)
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get()
          .then((snapshot) => snapshot.docs.first);
      return mostRecentPostDoc;
    }
  }

  Future getDocsStartAt(
      BuildContext context, DocumentSnapshot startAtDoc, ModelTypes modelType) async {
    print('START: getDoc of: ${modelType.name}()');
    print('startAtDoc ${startAtDoc.id}');

    return db
        .collection(modelType.name)
        .orderBy('timestamp', descending: true)
        .startAtDocument(startAtDoc)
        .limit(6)
        .get()
        .then((snap) async {
      var docs;
      switch (modelType) {
        case ModelTypes.posts:
          docs = snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.chats:
          docs = snap.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.messages:
          docs = snap.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.users:
          docs = snap.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
          break;
      }
      print('DONE: startAt ${modelType.name}: ${docs.length}');
      return docs;
    }).onError((e, stackTrace) {
      print('ERROR: getDoc of: $modelType() E:  $e');
      return [];
    });
  }

  // static Future<List<PostModel>?> getDocsEndBefore
  Future getDocsEndBefore(
      BuildContext context, DocumentSnapshot endBeforeDoc, ModelTypes modelType) async {
    print('START: getDoc of: ${modelType.name}()');
    print('endBeforeDoc ${endBeforeDoc.id}');

    return db
        .collection(modelType.name)
        .orderBy('timestamp', descending: true)
        .endBeforeDocument(endBeforeDoc)
        .limit(6)
        .get()
        .then((snap) async {
      var docs;
      switch (modelType) {
        case ModelTypes.posts:
          docs = snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.chats:
          docs = snap.docs.map((doc) => ChatModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.messages:
          docs = snap.docs.map((doc) => MessageModel.fromJson(doc.data())).toList();
          break;
        case ModelTypes.users:
          docs = snap.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
          break;
      }
      print('DONE: EndBefore ${modelType.name}: ${docs.length}');
      return docs;
    }).onError((e, stackTrace) {
      print('ERROR: getDoc of: $modelType() E:  $e');
      return [];
    });
  }
}
