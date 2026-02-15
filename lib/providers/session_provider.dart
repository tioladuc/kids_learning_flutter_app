import 'package:flutter/material.dart';

class SessionProvider extends ChangeNotifier {
  String? role = 'child'; // parent | child   NOT Used

  bool get isLoggedIn => role != null;

  void login(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void setRole(String currentRole) {
    role = currentRole;
    notifyListeners();
  }

  void logout() {
    role = null;
    notifyListeners();
  }
}
