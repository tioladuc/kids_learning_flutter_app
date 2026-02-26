import 'lang/constance_child/constant_child_lang.dart';

class Translator {
  String translatorFile = '';
  Map<String, String> defaultLang = Map();
  Map<String, String> currLang = Map();
  
  Translator({StatusLangue status = StatusLangue.CONSTANCE_CHILD, String lang = ''}) {
    print('LANGUAGE ==== ' + lang);
    if(lang=='')return;

    switch (status) {
      case StatusLangue.CONSTANCE_CHILD:
        defaultLang = ConstantChildLangue.getDefault();
        currLang = ConstantChildLangue.getDictionnary(lang);
        print(currLang);
        print("Child constants selected");
        break;

      case StatusLangue.CONSTANCE_COURSE:
        print("Course constants selected");
        break;

      case StatusLangue.CONSTANCE_PARENT:
        print("Parent constants selected");
        break;

      case StatusLangue.CONSTANCE_PAYMENT:
        print("Payment constants selected");
        break;

      case StatusLangue.CONSTANCE_PRESENTATION:
        print("Presentation constants selected");
        break;

      case StatusLangue.CONSTANCE_SESSION:
        print("Session constants selected");
        break;

      case StatusLangue.CONSTANCE_STATISTICS:
        print("Statistics constants selected");
        break;
    }
  }

  String getText(String key) {
    print('CONTAIN KEY = ' + currLang.containsKey(key).toString());
    return currLang.containsKey(key) ? currLang[key]??'' : defaultLang[key]??'';
  }

}

enum StatusLangue {
  CONSTANCE_CHILD,
  CONSTANCE_COURSE,
  CONSTANCE_PARENT,
  CONSTANCE_PAYMENT,
  CONSTANCE_PRESENTATION,
  CONSTANCE_SESSION,
  CONSTANCE_STATISTICS,
}
