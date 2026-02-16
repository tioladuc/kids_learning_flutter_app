import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/constances.dart';
import 'package:kids_learning_flutter_app/providers/session_provider.dart';
import 'package:kids_learning_flutter_app/screens/introscreen/main_intro_screen_parent.dart';
import 'package:provider/provider.dart';
import '../../core/constance_child.dart';
import '../../core/notify_data.dart';
import '../../widgets/app_scaffold.dart';
import '../audio/audio_list_screen.dart';
import 'logout_screen.dart';
import 'pending_screen.dart';
import 'pick_course.dart';
import 'statistics_screen.dart';

class MainIntroScreenChild extends StatefulWidget {
  const MainIntroScreenChild({super.key});

  @override
  State<MainIntroScreenChild> createState() => _MainIntroScreenChild();
}

class _MainIntroScreenChild extends State<MainIntroScreenChild> {
  List<Map<String, dynamic>> menuItems = [];

  List<Map<String, dynamic>> produceMenuItems(
    String langue,
    SessionProvider session,
  ) {
    String logoutDisplay = '';

    if (session.parent != null) {
      logoutDisplay = langue == Constant.languageEN
          ? ConstantChild.menuLogoutChildParentEN
          : ConstantChild.menuLogoutChildParentFR;
    } else {
      logoutDisplay = langue == Constant.languageEN
          ? ConstantChild.menuLogoutEN
          : ConstantChild.menuLogoutFR;
    }
    return [
      {
        "title": langue == Constant.languageEN
            ? ConstantChild.menuDictationEN
            : ConstantChild.menuDictationFR,
        "icon": Icons.mic,
        "key": 'Dictation',
      },
      {
        "title": langue == Constant.languageEN
            ? ConstantChild.menuPickCourseEN
            : ConstantChild.menuPickCourseFR,
        "icon": Icons.menu_book,
        "key": 'PickACourse',
      },
      {
        "title": langue == Constant.languageEN
            ? ConstantChild.menuCoursesValidationPendingEN
            : ConstantChild.menuCoursesValidationPendingFR,
        "icon": Icons.hourglass_top,
        "key": 'CourseValidationPending',
      },
      {
        "title": langue == Constant.languageEN
            ? ConstantChild.menuStatisticsEN
            : ConstantChild.menuStatisticsFR,
        "icon": Icons.bar_chart,
        "key": 'Statistics',
      },
      {"title": logoutDisplay, "icon": Icons.logout, "key": 'Logout'},
    ];
  }

  void _navigateTo(Map<String, dynamic> item, SessionProvider session) {
    if (item['key'] == 'Dictation') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AudioListScreen()),
      );
    }

    if (item['key'] == 'PickACourse') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PickCourse()),
      );
    }

    if (item['key'] == 'CourseValidationPending') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const PendingScreen()),
      );
    }

    if (item['key'] == 'Statistics') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const StatisticsScreen()),
      );
    }

    if (item['key'] == 'Logout') {
      if (session.parent == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LogoutScreen()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const MainIntroScreenParent()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    final session = context.watch<SessionProvider>();
    menuItems = produceMenuItems(notifyData.currentLanguage, session);

    return AppScaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];

          return GestureDetector(
            onTap: () => _navigateTo(item, session),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(item['icon'], color: Colors.blue),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
