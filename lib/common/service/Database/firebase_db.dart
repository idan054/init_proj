// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:example/common/extensions/extensions.dart';
import 'package:example/common/models/chat/chat_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'db_advanced.dart';

enum FeedTypes {
  rils,
  talks,
  reports,
  notifications,
}

// Mostly post filters
enum FilterTypes {
  postsByUser, //> User Screen
  conversationsPostByUser, //> User Screen
  sortByOldestComments,
  notificationsPostByUser, //? Notifications Screen
  reportedUsers, //! Admin Screen
  reportedRils, //! Admin Screen
  postWithComments, //~ Home Screen
  postWithoutComments, //~ Home Screen

  /// Main Feed
  sortFeedByDefault,
  sortFeedByIsOnline,
  sortFeedByLocation,
  sortFeedByTopics,
  sortFeedByAge,
}

//> MUST Be same as collection name!
enum ModelTypes { posts, chats, messages, users, reports }

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

  static void deleteDoc({required String collection, String? docName}) {
    db.collection(collection).doc(docName).delete();
  }

  static Future<Map<String, dynamic>?> docData(String documentPath) =>
      db.doc(documentPath).get().then((doc) => doc.data());

  static Future updateFirestore({
    required String collection,
    String? docName,
    required Map<String, dynamic> toJson,
    bool merge = true,
  }) async {
    db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: merge)) // Almost always true
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

  static Stream<int> streamNotificationCounter(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    // print('START: streamNotificationCounter()');
    // print('START: metadata.unreadNotificationCounter#${currUser.email}()');
    var exportedEmail = currUser.email!.replaceAll('.', 'DOT');
    var reqBase =
        db.collection('posts').where('metadata.${exportedEmail}_notifications', isNotEqualTo: 0);
    // if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    return reqBase.snapshots().map((snap) {
      print('NOTIFICATION_DOC_ID: ${snap.size}');
      // print('USER_DOC_ID: ${snap.docs.first.data()}');

      int overallNotificationsCount = 0;
      for (var doc in snap.docs) {
        var data = doc.data();

        var postNotificationsCount = doc.get('metadata.${exportedEmail}_notifications') as int;
        overallNotificationsCount = overallNotificationsCount + postNotificationsCount;

        var fetchedPosts = context.uniProvider.fetchedPosts;
        var post = PostModel.fromJson(doc.data());
        post = post.copyWith(notificationsCounter: postNotificationsCount);

        var fetchedPost =
            context.uniProvider.fetchedPosts.firstWhereOrNull((post) => post.id == post.id);
        context.uniProvider.fetchedPostsUpdate([post, ...fetchedPosts]);
      }
      context.uniProvider
          .currUserUpdate(currUser.copyWith(unreadNotificationCounter: overallNotificationsCount));

      return overallNotificationsCount;
    }).handleError((dynamic e) {
      print('ERROR: streamUnreadCounter() E: $e');
    });
  }

  static Stream<int> streamChatsUnreadCounter(BuildContext context) {
    var currUser = context.uniProvider.currUser;
    print('START: streamChatsUnreadCounter()');
    var reqBase =
        db.collection('chats').where('metadata.unreadCounter#${currUser.uid}', isNotEqualTo: 0);
    // if (timestamp != null) reqBase = reqBase.startAfter([timestamp]);

    return reqBase.snapshots().map((snap) {
      // print('USER_DOC_ID: ${snap.size}');
      // print('USER_DOC_ID: ${snap.docs.first.data()}');

      int chatUnreadCounter = 0;
      for (var doc in snap.docs) {
        var data = doc.data();
        // chatUnreadCounter = data['metadata']['unreadCounter#${currUser.uid}'];
        chatUnreadCounter =
            (chatUnreadCounter + doc.get('metadata.unreadCounter#${currUser.uid}')) as int;
      }
      // var updatedUser = UserModel.fromJson(snap.data() as Map<String, dynamic>);
      context.uniProvider.currUserUpdate(currUser.copyWith(unreadCounter: chatUnreadCounter));

      return chatUnreadCounter;
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
        .orderBy('timestamp', descending: false)
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
        var msgModel = MessageModel.fromJson(snap.data() as Map<String, dynamic>);
        return msgModel;
      }).toList();
    }).handleError((dynamic e) {
      print('ERROR: streamMessages() E: $e');
    });
  }
}

// "timestamp": "__Timestamp__2022-10-10T20:54:17.572Z"
// "timestamp": {"__time__": "2022-12-12T14:12:45.190999Z"}
