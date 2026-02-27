import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/providers/session_provider.dart';
import 'package:kids_learning_flutter_app/screens/session/login_screen.dart';
import 'package:provider/provider.dart';
//import '../../core/constances.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../core/notify_data.dart';
import '../../widgets/app_page_title.dart';
import '../../widgets/app_scaffold.dart';

class LogoutScreen extends StatelessWidget {
  LogoutScreen({super.key});
  
  Translator translator = Translator();

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_SESSION, lang: notifyData.currentLanguage);
    final sessionProvider = context.watch<SessionProvider>();

    return AppScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              PageTitle(
                text: translator.getText('LogoutTitle'),
              ),

              const SizedBox(height: 20),
              Text(translator.getText('LogoutMessage'),
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: Constant.getTitle3ButtonStyle(),
                onPressed: () async {
                  //notifyData.setRole(null);
                  sessionProvider.setRole(null);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                child: Text(translator.getText('LogoutButton'))
              ),
            ],
          ),
        ),
      ),
    );
  }
}
