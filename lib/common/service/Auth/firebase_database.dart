import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/user/user_model.dart';

class Database {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<UserModel>>? streamUsers() {
    print('START: streamUsers()');
    return _db.collection('users').snapshots().map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        print('USER_DOC_ID: ${snap.id}');
        // print(snap.data());
        return UserModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('EEE $e');
    });
  }

  static Stream<List<MessageModel>>? streamMessages(String chatId) {
    print('START: streamMessages()');
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages-$chatId')
        .orderBy('timestamp', descending: true)
        .limit(20)
        .snapshots()
        .map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        print('MSG_DOC_ID: ${snap.id}');
        // print(snap.data());
        return MessageModel.fromJson(snap.data() as Map<String, dynamic>);
      }).toList();
    }).handleError((dynamic e) {
      print('EEE $e');
    });
  }

  void updateFirestore(
      {required String collection,
      required String docName,
      required Map<String, dynamic> toJson}) {
    _db
        .collection(collection)
        .doc(docName)
        .set(toJson, SetOptions(merge: true))
        .onError((error, stackTrace) => print('updateFirestore ERR - $error'));
  }
}
