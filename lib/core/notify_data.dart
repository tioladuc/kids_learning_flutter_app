import 'package:flutter/material.dart';
import 'constances.dart';

class NotifyData extends ChangeNotifier {
  String _currentLanguage = Constant.currentLanguage;
  String get currentLanguage => _currentLanguage;
  
  String? _role = '';
  String? get role => _role;
  int currentBottomPosition = 0;
  
  void changeLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  void setRoleXX(String? currentRole) {
    _role = currentRole;
    notifyListeners();
  }

  void setCurrentBottomPosition(int currBottomPosition) {
    currentBottomPosition = currBottomPosition;
    notifyListeners();
  }

}