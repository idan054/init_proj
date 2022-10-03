import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/user/user_model.dart';

import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;

/// ChatService Available At [auth.AuthService] // <<---
/// newChat() & sendMessage() Available At [chat.ChatService] // <<---

class Database {
  static final db = FirebaseFirestore.instance;

  static Stream<List<UserModel>>? streamChats(String currUserId) {
    print('START: streamChats()');
    return db
        .collection('chats')
        .where('users', arrayContains: currUserId)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        //> print('CHAT_DOC_ID: ${snap.id}');
        // print(snap.data());
        return UserModel.fromJson(snap.data() as Map<String, dynamic>);
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
      print('EEE $e');
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
        .limit(20)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        //> print('MSG_DOC_ID: ${snap.id}');
        return MessageModel.fromJson(snap.data() as Map<String, dynamic>);
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
}
