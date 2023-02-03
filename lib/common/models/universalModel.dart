import 'package:example/common/models/appConfig/app_config_model.dart';
import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'dart:io' show Platform;
import '../service/Database/firebase_db.dart';
import 'chat/chat_model.dart';
import 'package:flutter/foundation.dart';

// class OnBoardingProvider with ChangeNotifier {
//
// }

class UniProvider with ChangeNotifier {
  AppConfigModel localConfig = AppConfigModel(
    publicVersionAndroid: 1,  //> Auto set on getAppConfig()
    publicVersionIos: 1,      //> Auto set on getAppConfig()
    // whatsNew: 'Here's what new!',
    // updateType: UpdateTypes.needed,
    // status: 'ok',
    // statusCode: 200,
    osType: Platform.isAndroid ? OsTypes.android : OsTypes.ios,
  );

  AppConfigModel? serverConfig;
  UserModel currUser = const UserModel();
  bool showFab = true;
  FilterTypes currFilter = FilterTypes.postWithoutComments;
  FeedTypes feedType = FeedTypes.members;
  bool isLoading = false;
  bool signupErrFound = false;
  bool postUploaded = false; // To auto refresh when user post.
  String? selectedTag = 'New'; // When filters will be in use
  ChatModel? activeChat; // Might be unnecessary
  List<ChatModel> chatList = [];
  List<UserModel> fetchedUsers = [];

  void updateFetchedUsers(List<UserModel> data, {bool notify = true}) {
    fetchedUsers = data;
    if(notify) notifyListeners();
  }

  AppConfigModel updateLocalVersion(AppConfigModel data) {
    localConfig = data;
    notifyListeners();
    return data;
  }

  void updateServerConfig(AppConfigModel? data) {
    serverConfig = data;
    notifyListeners();
  }

  void updateShowFab(bool data) {
    showFab = data;
    notifyListeners();
  }

  void updateCurrFilter(FilterTypes data, {bool notify = true}) {
    currFilter = data;
    if(notify) notifyListeners();
  }

  void updateFeedType(FeedTypes data) {
    feedType = data;
    notifyListeners();
  }

  void updateIsLoading(bool data) {
    isLoading = data;
    notifyListeners();
  }

  void updateErrFound(bool data, {bool notify = true}) {
    signupErrFound = data;
    if(notify) notifyListeners();
  }

  void updatePostUploaded(bool data, {bool notify = true}) {
    postUploaded = data;
    if(notify) notifyListeners();
  }

  void updateSelectedTag(String data) {
    selectedTag = data;
    notifyListeners();
  }


  void updateUser(UserModel data) {
    currUser = data;
    notifyListeners();
    // return data;
  }


  void updateActiveChat(ChatModel? data) {
    activeChat = data;
    notifyListeners();
  }

  void updateChatList(List<ChatModel> data, {bool notify = true}) {
    chatList = data;
    if(notify) notifyListeners();
  }
}

