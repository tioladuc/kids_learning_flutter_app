import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/session_provider.dart';
import 'screens/login_screen.dart';
import 'screens/audio_list_screen.dart';
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
          if (session.isLoggedIn) {
            return const AudioListScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
