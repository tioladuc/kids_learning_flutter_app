import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:provider/provider.dart';

import 'core/constance_session.dart';
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
          /**********print('toto toto toto = ' + notifyData.currentBottomPosition.toString());
          return IndexedStack(
            index: notifyData.currentBottomPosition,
            children: _pages,
          );*************/

          if (session.isLoggedIn) {//MainIntroScreenChild
            /*******if(notifyData.currentBottomPosition ==0) {
              return const Text('Home');
            }
            else if(notifyData.currentBottomPosition ==1) {
              return const Text('Setting');
            }
            else if(notifyData.currentBottomPosition ==2) {
              return const Text('Profile');
            }
            else if(notifyData.currentBottomPosition ==3) {
              return const Text('Statistics');
            }********/
            return session.role == ConstantSession.ChoiceChild ? const MainIntroScreenChild(): const AudioListScreen();
          }
          return const LoginScreen();
        
        },
      ),
    );
  }
}
