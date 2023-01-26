// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Auth/auth_services.dart' as auth;
import '../Chat/chat_services.dart' as chat;
import '../timestamp_convert.dart';
import 'db_advanced.dart';
import 'package:hive/hive.dart';

enum FilterTypes { postsByUser , postWithoutComments, postWithComments, postConversionsOfUser}

//> MUST Be same as collection name!
enum ModelTypes { posts, chats, messages, users }

// .get() = READ.
// .set() / .update() = WRITE.
class Database {
  static var db = FirebaseFirestore.instance;

  // var db = Database.db;
  //
  get dbSetting {
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  static final advanced = FsAdvanced();

  void deleteDoc({required String collection, String? docName}) {
    db.collection(collection).doc(docName).delete();
  }

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  static void updateFirestore(
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
        .update(toJson)
        // .set(toJson, SetOptions(merge: true))
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

  static Future<List<ChatModel>>? getChatsAfter(
    String currUserId,
    DocumentSnapshot startAtDoc,
  ) {
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

  static Stream<List<PostModel>> streamPosts() {
    print('START: streamPosts()');
    return db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        print('CHAT_DOC_ID: ${snap.id}');
        // print(snap.data());
        return PostModel.fromJson(snap.data() as Map<String, dynamic>);
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

  //
  // var db = Database.db;
  //
  // db.settings = const Settings(
  // persistenceEnabled: true,
  // cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  // );

  static Stream<int?>? streamUnreadCounter(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    print('START: streamUnreadCounter()');
    var reqBase = db.collection('users').doc(currUser.email);
    // if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    return reqBase.snapshots().map((docUpdate) {
      print('USER_DOC_ID: ${docUpdate.id}');
      print('USER_DOC_ID: unreadCounter:${docUpdate.data()?['unreadCounter']}');

      var updatedUser = UserModel.fromJson(docUpdate.data() as Map<String, dynamic>);
      context.uniProvider.updateUser(updatedUser);

      return updatedUser.unreadCounter;
    }).handleError((dynamic e) {
      print('ERROR: streamUnreadCounter() E: $e');
    });
  }

  static Stream<List<PostModel>>? streamComments(String postId, {required int limit}) {
    print('START: streamComments()');
    print('chatId $postId');
    var reqBase = db
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .limit(limit);
    // if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    return reqBase.snapshots().map((QuerySnapshot list) {
      print('post comments - list ${list.docs.length}');
      return list.docs.map((DocumentSnapshot snap) {
        print('POST_COMMENT_DOC_ID: ${snap.id}');
        return PostModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('ERROR: streamMessages() E: $e');
    });
  }


  static Stream<List<MessageModel>>? streamMessages(String chatId, {required int limit}) {
    print('START: streamMessages()');
    print('chatId ${chatId}');
    var reqBase = db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(limit);
    // if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    return reqBase.snapshots().map((QuerySnapshot list) {
      print('chats - list ${list.docs.length}');
      return list.docs.map((DocumentSnapshot snap) {
        print('MSG_DOC_ID: ${snap.id}');
        return MessageModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('ERROR: streamMessages() E: $e');
    });
  }
}

// "timestamp": "__Timestamp__2022-10-10T20:54:17.572Z"
// "timestamp": {"__time__": "2022-12-12T14:12:45.190999Z"}
