import 'package:example/common/models/appConfig/app_config_model.dart';

import 'package:example/common/models/message/message_model.dart';
import 'package:example/common/models/post/post_model.dart';
import 'package:example/common/models/user/user_model.dart';
import 'dart:io' show Platform;
import '../../widgets/components/feed/bottom_sort_sheet.dart';
import '../service/Database/firebase_db.dart';
import 'chat/chat_model.dart';
import 'package:flutter/foundation.dart';

import 'feedFilterModel/sort_feed_model.dart';

// class OnBoardingProvider with ChangeNotifier {
//
// }

class UniProvider with ChangeNotifier {
  AppConfigModel localConfig = AppConfigModel(
    publicVersionAndroid: 1, //> Auto set on getAppConfig()
    publicVersionIos: 1, //> Auto set on getAppConfig()
    // whatsNew: 'Here's what new!',
    // updateType: UpdateTypes.needed,
    // status: 'ok',
    // statusCode: 200,
    osType: Platform.isAndroid ? OsTypes.android : OsTypes.ios,
  );

  AppConfigModel? serverConfig;
  UserModel currUser = const UserModel();
  bool showFab = true;

  //! currFilter & sortFeedBy.type usage could make issues
  FilterTypes currFilter = FilterTypes.postWithoutComments;
  SortFeedModel sortFeedBy = sortByDefault;

  FeedTypes feedType = FeedTypes.rils;
  bool isLoading = false;
  bool signupErrFound = false;
  bool postUploaded = false; // To auto refresh when user post.
  String? selectedTag = 'New'; // When filters will be in use
  ChatModel? activeChat; // Need to reset unread chat counter
  List<ChatModel> chatList = [];
  List<UserModel> fetchedUsers = []; // To get most updated user info.
  List<PostModel> fetchedPosts = []; // To update each post notification

  void fetchedPostsUpdate(List<PostModel> data, {bool notify = true}) {
    fetchedPosts = data;
    if (notify) notifyListeners();
  }

  void fetchedUsersUpdate(List<UserModel> data, {bool notify = true}) {
    fetchedUsers = data;
    if (notify) notifyListeners();
  }

  AppConfigModel localVersionUpdate(AppConfigModel data) {
    localConfig = data;
    notifyListeners();
    return data;
  }

  void serverConfigUpdate(AppConfigModel? data) {
    serverConfig = data;
    notifyListeners();
  }

  void showFabUpdate(bool data) {
    showFab = data;
    notifyListeners();
  }

  void currFilterUpdate(FilterTypes data, {bool notify = true}) {
    currFilter = data;
    if (notify) notifyListeners();
  }

  void sortFeedByUpdate(SortFeedModel data, {bool notify = true}) {
    sortFeedBy = data;
    if (notify) notifyListeners();
  }

  void feedTypeUpdate(FeedTypes data, {bool notify = true}) {
    feedType = data;
    if (notify) notifyListeners();
  }

  void isLoadingUpdate(bool data) {
    isLoading = data;
    notifyListeners();
  }

  void errFoundUpdate(bool data, {bool notify = true}) {
    signupErrFound = data;
    if (notify) notifyListeners();
  }

  void postUploadedUpdate(bool data, {bool notify = true}) {
    postUploaded = data;
    if (notify) notifyListeners();
  }

  void selectedTagUpdate(String data) {
    selectedTag = data;
    notifyListeners();
  }

  void currUserUpdate(UserModel data) {
    currUser = data;
    notifyListeners();
    // return data;
  }

  void activeChatUpdate(ChatModel? data) {
    activeChat = data;
    notifyListeners();
  }

  void chatListUpdate(List<ChatModel> data, {bool notify = true}) {
    chatList = data;
    if (notify) notifyListeners();
  }
}
