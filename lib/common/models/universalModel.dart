import 'package:example/common/models/profile/user_model.dart';
import 'package:flutter/foundation.dart';

class UniModel with ChangeNotifier {
  var user = const UserModel();

  updateUser(UserModel data) => _notifyAction(user, data);
  //     String? name,
  //     String? email,
  //     String? uid,
  //     String? photoUrl,

  void _notifyAction(value, data) {
    value = data;
    notifyListeners();
  }

// bool fromBoarding = false; // Does the user goToProfile from boarding?
//
// void fromBoardingIs(bool data){
//   fromBoarding = data;
//   print('fromBoarding $fromBoarding');
//   notifyListeners();
// }
}
