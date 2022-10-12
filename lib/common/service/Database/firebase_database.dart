// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;
import '../Hive/timestamp_convert.dart';
import 'firebase_advanced.dart';

//> MUST Be same as collection name!
enum ModelTypes { posts, chats, messages, users }

// .get() = READ.
// .set() / .update() = WRITE.
class Database {
  static final db = FirebaseFirestore.instance;
  static final advanced = FsAdvanced();

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  void updateFirestore(
      {required String collection, String? docName, required Map<String, dynamic> toJson}) {
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
    batch.set(db.collection(collection).doc(docName), toJson, SetOptions(merge: true));

    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: true))
        .onError((error, stackTrace) => print('addToBatch ERR - $error'));
  }

  static Future<List<ChatModel>>? getChatsBefore(String currUserId, DocumentSnapshot endBeforeDoc) {
    print('START: getChatsBefore()');
    print('startAtDoc ${endBeforeDoc.id}');

    return db
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .endBeforeDocument(endBeforeDoc)
        .where('usersIds', arrayContains: currUserId)
        .get()
        .then((snap) => snap.docs.map((DocumentSnapshot snap) {
      print('CHAT_DOC_ID: ${snap.id}');
      // print(snap.data());
      return ChatModel.fromJson(snap.data() as Map<String, dynamic>);
    }).toList());
  }

  static Future<List<ChatModel>>? getChatsAfter(String currUserId, DocumentSnapshot startAtDoc,) {
    print('START: getChatsAfter()');
    print('startAtDoc ${startAtDoc.id}');

    return db
        .collection('chats')
        .orderBy('timestamp', descending: true)
        .startAtDocument(startAtDoc)
        .where('usersIds', arrayContains: currUserId)
        .get()
        .then((snap) => snap.docs.map((DocumentSnapshot snap) {
      print('CHAT_DOC_ID: ${snap.id}');
      // print(snap.data());
      return ChatModel.fromJson(snap.data() as Map<String, dynamic>);
    }).toList());
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
