import 'package:flutter/foundation.dart';
import 'package:example/common/models/user/user_model.dart';

class UniProvider with ChangeNotifier {
  List<UserModel> fetchedUsers = [];

  void fetchedUsersUpdate(List<UserModel> data, {bool notify = true}) {
    fetchedUsers = data;
    if (notify) notifyListeners();
  }
}
