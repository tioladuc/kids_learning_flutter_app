import 'package:flutter/material.dart';
import 'constances.dart';

class NotifyData extends ChangeNotifier {
  String _currentLanguage = Constant.currentLanguage;
  String get currentLanguage => _currentLanguage;
  
  void changeLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

}