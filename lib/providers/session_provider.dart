import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/parent.dart';

class SessionProvider extends ChangeNotifier {
  String? role = null; // parent | child   NOT Used

  Child? child = Child(id: 'child01', name: 'Child Main Principale', login: '01', password: '');
  Parent? parent = Parent(id: 'parent', name: 'Parent Main Principale',  login: '11',password: '', children: [
    Child(id: 'child01', name: 'Child Other 01', login: '01', password: ''),
    Child(id: 'child02', name: 'Child Other 02', login: '02', password: ''),
    Child(id: 'child03', name: 'Child Other 03', login: '03', password: ''),
    Child(id: 'child04', name: 'Child Other 04', login: '04', password: ''),
    Child(id: 'child05', name: 'Child Other 05', login: '05', password: ''),
    Child(id: 'child06', name: 'Child Other 06', login: '06', password: ''),
  ]) ;

  SessionProvider() {
    tmpParent = Parent.copy(parent!);
    tmpChild = Child.copy(child!);
  }
  Child? tmpChild; Parent? tmpParent;
  bool get isLoggedIn => role != null;

  void setCurrentChildAsParent(Child? child) {
    parent!.currentChild = child;
    notifyListeners();
  }

  void login(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void setRole(String? currentRole) {
    role = currentRole;
    notifyListeners();
  }

  void setParent(Parent? value) {
    parent = value;
    notifyListeners();
  }

  void setChild(Child? value) {
    child = value;
    notifyListeners();
  }

  void logout() {
    role = null;
    notifyListeners();
  }

  void addChild(String login, String name, String password) {
    parent?.children.add(
      Child(id: DateTime.now().toString(), name: name, login:login, password: password),
    );
    notifyListeners();
  }
  void deleteChild(String id) {
  parent?.children.removeWhere((c) => c.id == id);
  notifyListeners();
}

  void changeParentPassword(String name, String newPassword) {
    parent?.name = name;
    parent?.password = newPassword;
    // TODO: call API
    print("Password changed: $newPassword");
    notifyListeners();
  }

  void changeChildPassword(String name, String newPassword) {
    child?.name = name;
    child?.password = newPassword;
    // TODO: call API
    print("Password changed: $newPassword");
    notifyListeners();
  }

  void changePasswordParentChild(String name, String newPassword, Child child) {
    // TODO: call API
    parent?.children.firstWhere((element) => element.id == child.id).name = name;
    parent?.children.firstWhere((element) => element.id == child.id).password = newPassword;
    print("Password changed: $newPassword");
    notifyListeners();
  }
}
