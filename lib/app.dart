import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constance_session.dart';
import 'providers/session_provider.dart';
import 'screens/introscreen/main_intro_screen_child.dart';
import 'screens/login_screen.dart';
import 'screens/audio/audio_list_screen.dart';
import 'core/theme.dart';

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning',
      theme: appTheme,
      home: Consumer<SessionProvider>(
        builder: (context, session, _) {
          if (session.isLoggedIn) {//MainIntroScreenChild
            return session.role == ConstantSession.ChoiceChild ? const MainIntroScreenChild(): const AudioListScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
