import '../../base_translator.dart';
import 'en.dart';
import 'fr.dart';

class ConstantPresentationLangue  extends BaseTranslator{
  @override
  static Map<String, String> getDefault() {
    return En.data;
  }

  @override
  static Map<String, String> getDictionnary(String lang) {
    if(lang == 'EN') {
      return En.data; 
    }
    else if(lang == 'FR') {
      return Fr.data; 
    }
    return Map();
  }
}