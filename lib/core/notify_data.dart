import 'package:flutter/material.dart';
import 'constances.dart';

class NotifyData extends ChangeNotifier {
  static final ChoiceChild = 'child';
  static final ChoiceParent = 'parent';
  static final String languageFR = 'FR';
  static final String languageEN = 'EN';
  /*==========================================*/
  static String CategoryRequestInformationEN = 'Request Information';
  static String CategoryRequestInformationFR = 'Demande d`Information';
  static String CategoryComplainEN = 'Complain';
  static String CategoryComplainFR = 'Complainte';
  static String CategorySuggestionEN = 'Suggestion';
  static String CategorySuggestionFR = 'Suggestion';
  static String CategoryOtherEN = 'Other';
  static String CategoryOtherFR = 'Autre';
  /*==========================================*/
  static String CourseStatExcellentEN = 'excellent';
  static String CourseStatExcellentFR = 'excellent';

  static String CourseStatGoodEN = 'good';
  static String CourseStatGoodFR = 'bien';

  static String CourseStatAverageEN = 'average';
  static String CourseStatAverageFR = 'moyen';

  static String CourseStatPoorEN = 'poor';
  static String CourseStatPoorFR = 'faible';
  /*==========================================*/
  String _currentLanguage = Constant.currentLanguage;
  String get currentLanguage => _currentLanguage;
  
  String? _role = '';
  String? get role => _role;
  int currentBottomPosition = 0;
  String displayLanguageChanger() {
    return _currentLanguage == languageFR ? languageEN : languageFR;
  }
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