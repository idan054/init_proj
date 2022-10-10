import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/foundation.dart';

import 'chat/chat_model.dart';

class UniProvider with ChangeNotifier {
  UserModel currUser = const UserModel();

  void updateUser(UserModel data) {
    currUser = data;
    notifyListeners();
    // return data;
  }

  List<ChatModel>? chatList;

  void updateChatList(List<ChatModel> data) {
    chatList = data;
    notifyListeners();
  }

  List<PostModel>? postsList;

  void updatePostsList(List<PostModel> data) {
    postsList = data;
    notifyListeners();
  }

// PostModel? lastedUploadedPost;
// void updatePostUploaded(PostModel data) {
//   lastedUploadedPost = data;
//   notifyListeners();
// }
}

