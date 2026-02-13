import 'package:flutter/material.dart';
import '../models/user.dart';

class SessionProvider extends ChangeNotifier {
  User? user;

  bool get isLoggedIn => user != null;

  void setUser(User u) {
    user = u;
    notifyListeners();
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
