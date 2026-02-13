import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  String? role = 'sds'; // parent | child

  bool get isLoggedIn => role != null;

  void login(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void logout() {
    role = null;
    notifyListeners();
  }
}
