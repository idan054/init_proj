import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:example/common/models/user/user_model.dart';

class Database {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<UserModel>>? streamUsers() {
    _db
        .collection('users')
        .snapshots()
        .map((QuerySnapshot list) => list.docs.map((DocumentSnapshot snap) {
              // User.fromMap(snap.data)
              UserModel.fromJson(snap.data() as Map<String, dynamic>);
            }).toList())
        .handleError((dynamic e) {
      print(e);
    });
    return null;
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
