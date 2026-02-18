import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/screens/session/login_screen.dart';
import 'package:provider/provider.dart';
import '../core/constances.dart';
import '../core/notify_data.dart';
import '../providers/session_provider.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeader();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _AppHeader extends State<AppHeader> with ChangeNotifier {
  String currentLanguage = Constant.currentLanguage;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppBar(
      centerTitle: true,
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 3, 54, 241),
              Color.fromARGB(255, 235, 243, 236),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: Text(
        currentLanguage == Constant.languageEN
            ? Constant.AppNameEN
            : Constant.AppNameFR,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        ElevatedButton(
          style: Constant.getTitle3ButtonStyle(),
          child: currentLanguage != Constant.languageEN
              ? Text(Constant.languageEN)
              : Text(Constant.languageFR),
          onPressed: () => {
            setState(() {
              currentLanguage = currentLanguage == Constant.languageEN
                  ? Constant.languageFR
                  : Constant.languageEN;
              Constant.currentLanguage = currentLanguage;
              notifyData.changeLanguage(currentLanguage);
              /*session.setRole(null);
              session.setParent(null);
              session.setChild(null);
              session.setCurrentChildAsParent(null);*/
            }),
          },
        ),

        IconButton(
          icon: Icon(session.isLoggedIn ? Icons.logout : Icons.login),
          onPressed: () {
            if (session.isLoggedIn) {
              session.setRole(null);
               Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>const LoginScreen(),
                    ),
                  );
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
