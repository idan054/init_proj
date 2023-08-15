// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/chat/chat_model.dart';

class Database {
  static var db = FirebaseFirestore.instance;

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
}
