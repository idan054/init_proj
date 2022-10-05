import 'package:example/common/models/user/user_model.dart';
import 'package:example/screens/chat_ui/chats_list_screen.dart.dart' as click;
import 'package:flutter/foundation.dart';

import 'chat/chat_model.dart';

class UniProvider with ChangeNotifier {
  UserModel currUser = const UserModel();
  List<ChatModel>? chatList;

  /// on [click.ChatsListScreen]

  void updateUser(UserModel data) {
    currUser = data;
    notifyListeners();
  }

  void updateChatList(List<ChatModel> data) {
    chatList = data;
    notifyListeners();
  }

/*  var message = MessageModel(
      fromId: '',
      sendAt: DateTime.now(),
      textContent: '',
      toId: '',
      read: false);*/

//     String? name,
//     String? email,
//     String? uid,
//     String? photoUrl,

// bool fromBoarding = false; // Does the user goToProfile from boarding?
//
// void fromBoardingIs(bool data){
//   fromBoarding = data;
//   print('fromBoarding $fromBoarding');
//   notifyListeners();
// }
}
