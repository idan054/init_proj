import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';

import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;

/// ChatService Available At [auth.AuthService] // <<---
/// newChat() & sendMessage() Available At [chat.ChatService] // <<---

class Database {
  //> .get() = READ.
  //> .set() / .update() = WRITE.

  static final db = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

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

  /// Batch operations:

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

  //~ Made for specific scenario:
  //~ =========================

  static Future<List<PostModel>?> getPosts() {
    print('START: getPosts()');
    return db.collection('posts').get().then((snap) {
      var posts =
          snap.docs.map((doc) => PostModel.fromJson(doc.data())).toList();
      return posts;
    }).onError((e, stackTrace) {
      print('ERROR: getPosts() E:  $e');
      return [];
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
