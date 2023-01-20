import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';

import 'chat/chat_model.dart';

import 'package:flutter/foundation.dart';

// class OnBoardingProvider with ChangeNotifier {
//
// }

class UniProvider with ChangeNotifier {
  String? status;
  void updateStatus(String? data) {
    status = data;
    notifyListeners();
  }

  bool isLoading = false;
  void updateIsLoading(bool data) {
    isLoading = data;
    notifyListeners();
  }

  bool errFound = false;
  void updateErrFound(bool data, {bool notify = true}) {
    errFound = data;
    if(notify) notifyListeners();
  }

  bool postUploaded = false;
  void updatePostUploaded(bool data, {bool notify = true}) {
    postUploaded = data;
    if(notify) notifyListeners();
  }

  String? selectedTag = 'New';
  void updateSelectedTag(String data) {
    selectedTag = data;
    notifyListeners();
  }


  String? startAtDocId;
  void updateStartAtDocId(String data) {
    startAtDocId = data;
    notifyListeners();
  }

  UserModel currUser = const UserModel();
  void updateUser(UserModel data) {
    currUser = data;
    notifyListeners();
    // return data;
  }

  List<ChatModel> chatList = [];
  void updateChatList(List<ChatModel> data) {
    chatList = data;
    notifyListeners();
  }

  List<MessageModel> messages = [];
  void updateMessages(List<MessageModel> data) {
    messages = data;
    notifyListeners();
  }


  // List<PostModel>? postsList;
  // void updatePostsList(List<PostModel> data) {
  //   postsList = data;
  //   notifyListeners();
  // }

// PostModel? lastedUploadedPost;
// void updatePostUploaded(PostModel data) {
//   lastedUploadedPost = data;
//   notifyListeners();
// }
}

