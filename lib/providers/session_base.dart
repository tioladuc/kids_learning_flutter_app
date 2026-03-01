
import 'package:flutter/material.dart';

import '../core/core_translator.dart';
import '../core/notify_data.dart';

class SessionBase extends ChangeNotifier {
  static Translator translator = Translator(status: StatusLangue.CONSTANCE_CONSTANCE,
      lang: NotifyData.CurrentLanguage,);
}