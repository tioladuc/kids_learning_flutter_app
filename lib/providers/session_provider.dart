import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/parent.dart';

class SessionProvider extends ChangeNotifier {
  String? role = null; // parent | child   NOT Used

  Child child = Child(id: 'child', name: 'Child Main Principale', password: '');
  Parent parent = Parent(id: 'parent', name: 'Parent Main Principale', password: '', children: [
    Child(id: 'child01', name: 'Child Other 01', password: ''),
    Child(id: 'child02', name: 'Child Other 02', password: ''),
    Child(id: 'child03', name: 'Child Other 03', password: ''),
    Child(id: 'child04', name: 'Child Other 04', password: ''),
    Child(id: 'child05', name: 'Child Other 05', password: ''),
    Child(id: 'child06', name: 'Child Other 06', password: ''),
  ]);

  bool get isLoggedIn => role != null;

  void login(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void setRole(String? currentRole) {
    role = currentRole;
    notifyListeners();
  }

  void logout() {
    role = null;
    notifyListeners();
  }

  void addChild(String name, String password) {
    parent.children.add(
      Child(id: DateTime.now().toString(), name: name, password: password),
    );
    notifyListeners();
  }

  void changePassword(String newPassword) {
    parent.password = newPassword;
    // TODO: call API
    print("Password changed: $newPassword");
  }

  void changePasswordChild(String newPassword, Child child) {
    // TODO: call API
  parent.children.firstWhere((element) => element.id == child.id).password = newPassword;
    print("Password changed: $newPassword");
  }
}
