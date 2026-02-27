import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:provider/provider.dart';
import 'models/child.dart';
import 'providers/session_provider.dart';
import 'screens/introscreen/child/child_pick_course.dart';
import 'screens/introscreen/main_intro_screen_child.dart';
import 'screens/session/login_screen.dart';
import 'screens/audio/audio_list_screen.dart';
import 'core/theme.dart';

class KidsLearningApp extends StatefulWidget {
  const KidsLearningApp({super.key});
  @override
  State<KidsLearningApp> createState() => _KidsLearningApp();
}

class _KidsLearningApp extends State<KidsLearningApp> {
  //class KidsLearningApp extends StatelessWidget {
  // const KidsLearningApp({super.key});
  final List<Widget> _pages = [
    LoginScreen(),
    MainIntroScreenChild(),
    AudioListScreen(),
    ChildPickCourse( child:Child(  id: 's', login: 'login', name: 'name', password: 'pwd')),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning',
      theme: appTheme,
      home: Consumer2<SessionProvider, NotifyData>(
        builder: (context, session, notifyData, _) {
          

          if (session.isLoggedIn) {
            return session.role == NotifyData.ChoiceChild ? const MainIntroScreenChild(): const AudioListScreen();
          }
          return const LoginScreen();
        
        },
      ),
    );
  }
}
