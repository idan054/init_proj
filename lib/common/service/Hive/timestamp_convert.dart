// //~ Cant say it was the best choice. But at least I have
// //> timestamp for Firestore
// //> dateTime for Provider
// //> int for Hive
//
// // insert post.toJson() here to save on Hive.
// // its convert the Timestamp to int
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// Map<String, dynamic> jsonWithTimestampToHive(Map<String, dynamic> json) {
//   try {
//     var timestamp = json['timestamp'].toDate().millisecondsSinceEpoch;
//     json['timestamp'] = timestamp;
//   } catch (e) {}
//   //
//   try {
//     var creatorUser =
//         json['creatorUser']['birthday'].toDate().millisecondsSinceEpoch;
//     json['creatorUser']['birthday'] = creatorUser;
//   } catch (e) {}
//
//   //
//   try {
//     var birthday = json['birthday'].toDate().millisecondsSinceEpoch;
//     json['birthday'] = birthday;
//   } catch (e) {}
//   return json;
// }
//
// // Use this after fetch json from Hive.
// // its convert the int bach to Timestamp (UserModel.fromJson will than make it dateTime)
// Map<String, dynamic> jsonWithTimestampFromHive(Map<String, dynamic> json) {
//   try {
//     var timestamp = json['timestamp'];
//     json['timestamp'] = Timestamp.fromMillisecondsSinceEpoch(timestamp);
//   } catch (e) {}
//   //
//   try {
//     var creatorUser = json['creatorUser']['birthday'];
//     json['creatorUser']['birthday'] =
//         Timestamp.fromMillisecondsSinceEpoch(creatorUser);
//   } catch (e) {}
//
//   //
//   try {
//     var birthday = json['birthday'];
//     json['birthday'] = Timestamp.fromMillisecondsSinceEpoch(birthday);
//   } catch (e) {}
//   return json;
// }
