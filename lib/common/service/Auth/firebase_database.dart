// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;
import '../Hive/timestamp_convert.dart';

/// ChatService Available At [auth.AuthService] // <<---
/// newChat() & sendMessage() Available At [chat.ChatService] // <<---

class Database {
  //> .get() = READ.
  //> .set() / .update() = WRITE.

  static final db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  void updateFirestore(
      {required String collection,
      String? docName,
      required Map<String, dynamic> toJson}) {
    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: true))
        .onError((error, stackTrace) => print('updateFirestore ERR - $error'));
  }

  void addToBatch(
      {required WriteBatch batch,
      required String collection,
      String? docName,
      required Map<String, dynamic> toJson}) {
    batch.set(db.collection(collection).doc(docName), toJson,
        SetOptions(merge: true));

    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: true))
        .onError((error, stackTrace) => print('addToBatch ERR - $error'));
  }

  static Future<DocumentSnapshot> getStartAtDoc(
      String collection, String? docId) async {
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

// TODO: remove duplications! & limit the list to lasted 100. (From getPosts - jsonPostsList)

  //~ Made for specific scenario:
  //~ =========================

  static Future<List<PostModel>?> getPostsStartAt(
      BuildContext context, DocumentSnapshot startAtDoc) async {
    print('START: getPosts()');
    print('startAtDoc ${startAtDoc.id}');

    return db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .startAtDocument(startAtDoc)
        .limit(4)
        .get()
        .then((snap) async {
      var posts =
          snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

      return posts;
    }).onError((e, stackTrace) {
      print('ERROR: getPosts() E:  $e');
      return [];
    });
  }

  static Future<List<PostModel>?> getPostsEndBefore(
      BuildContext context, DocumentSnapshot endBeforeDoc) async {
    print('START: getPosts()');
    print('startAtDoc ${endBeforeDoc.id}');

    return db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .endBeforeDocument(endBeforeDoc)
        .limit(4)
        .get()
        .then((snap) async {
      var posts =
      snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();

      return posts;
    }).onError((e, stackTrace) {
      print('ERROR: getPosts() E:  $e');
      return [];
    });
  }

  static Stream<List<ChatModel>>? streamChats(String currUserId) {
    print('START: streamChats()');
    return db
        .collection('chats')
        .where('usersIds', arrayContains: currUserId)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        print('CHAT_DOC_ID: ${snap.id}');
        // print(snap.data());
        return ChatModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('EEE $e');
    });
  }

  static Stream<List<UserModel>>? streamUsers() {
    print('START: streamUsers()');
    return db.collection('users').snapshots().map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        //> print('USER_DOC_ID: ${snap.id}');
        // print(snap.data());
        return UserModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('ERROR: streamUsers() E:  $e');
    });
  }

  static Stream<List<MessageModel>>? streamMessages(String chatId) {
    print('START: streamMessages()');
    print('chatId ${chatId}');
    return db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        // .limit(1)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        //> print('MSG_DOC_ID: ${snap.id}');
        return MessageModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('ERROR: streamMessages() E: $e');
    });
  }
}
