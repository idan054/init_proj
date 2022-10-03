import 'package:example/common/models/user/user_model.dart';
import 'package:flutter/foundation.dart';

class UniProvider with ChangeNotifier {
  var currUser = const UserModel();

  updateUser(UserModel data) {
    currUser = data;
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
