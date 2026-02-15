import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/providers/session_provider.dart';
import 'package:kids_learning_flutter_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import '../../core/constance_session.dart';
//import '../../core/constances.dart';
import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../widgets/app_page_title.dart';
import '../../widgets/app_scaffold.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    final sessionProvider = context.watch<SessionProvider>();
    //final session = context.watch<SessionProvider>();

    return AppScaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const PageTitle(text: "Login Page++"),
              const Text("Login Page 999"),

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
                child: notifyData.currentLanguage == Constant.languageEN
                    ?  Text(ConstantSession.LoginButtonEN)
                    :  Text(ConstantSession.LoginButtonFR),
              ),
            ],
          ),
        ),
      ) /*Column(
        children: [
          Center(child: Text("Login Page")),
          ElevatedButton(
              style: Constant.getTitle3ButtonStyle(),
              onPressed: () async {
                notifyData.setRole(null);
                sessionProvider.setRole(null);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              child: notifyData.currentLanguage == Constant.languageEN ? Text(ConstantSession.LoginButtonEN) : Text(ConstantSession.LoginButtonFR),
            )
        ],
      )*/, //Center(child: Text("Login Page")),
    );
  }
}
