import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constances.dart';
import '../core/notify_data.dart';
import '../providers/session_provider.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget{
  
  const AppHeader({super.key});

  @override
  State<AppHeader> createState() => _AppHeader();

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class _AppHeader  extends State<AppHeader>  with ChangeNotifier {
  
  String currentLanguage = Constant.currentLanguage;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppBar(
      title: currentLanguage==Constant.languageEN ? Text(Constant.AppNameEN) : Text(Constant.AppNameFR),
      actions: [
        
        ElevatedButton(
          style: Constant.getTitle3ButtonStyle(),
          child: currentLanguage!=Constant.languageEN ? Text(Constant.languageEN) : Text(Constant.languageFR),
          onPressed: () => {
            setState(() {
              currentLanguage = currentLanguage==Constant.languageEN ? Constant.languageFR : Constant.languageEN;
              Constant.currentLanguage = currentLanguage;
              notifyData.changeLanguage(currentLanguage);
            })},
        ),
        
        IconButton(
          icon: Icon(session.isLoggedIn ? Icons.logout : Icons.login),
          onPressed: () {
            if (session.isLoggedIn) {
              session.logout();
            }
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
