import 'package:flutter/material.dart';
import '../providers/session_base.dart';
import 'constances.dart';
import 'core_translator.dart';

class NotifyData extends ChangeNotifier {
  static final ChoiceChild = 'child';
  static final ChoiceParent = 'parent';
  static final String languageFR = 'FR';
  static final String languageEN = 'EN';

  static final CategoryEmailTables = [
    'CategoryRequestInformation',
    'CategoryComplain',
    'CategorySuggestion',
    'CategoryOther',
  ];
  static final CourseStatCodes = [
    'CourseStatExcellent',
    'CourseStatGood',
    'CourseStatAverage',
    'CourseStatPoor',
  ];
  String _currentLanguage = Constant.currentLanguage;
  String get currentLanguage => _currentLanguage;
  static String CurrentLanguage = Constant.currentLanguage;

  String? _role = '';
  String? get role => _role;
  int currentBottomPosition = 0;
  String displayLanguageChanger() {
    return _currentLanguage == languageFR ? languageEN : languageFR;
  }

  void changeLanguage(String language) {
    _currentLanguage = language;
    CurrentLanguage = language;
    SessionBase.translator = Translator(
      status: StatusLangue.CONSTANCE_CONSTANCE,
      lang: language,
    );
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
