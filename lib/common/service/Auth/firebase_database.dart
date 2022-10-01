import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/user/user_model.dart';

class Database {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<UserModel>>? streamUsers() {
    print('START: streamUsers()');
    return _db.collection('users').snapshots().map((QuerySnapshot list) {
      return list.docs.map((DocumentSnapshot snap) {
        print('DOC ID: ${snap.id}');
        // print(snap.data());
        return UserModel.fromJson(snap.data() as Map<String, dynamic>);
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
