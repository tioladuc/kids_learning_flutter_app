import 'package:flutter/material.dart';

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
  final List<Map<String, dynamic>> menuItems = [
    {"title": "Dictation", "icon": Icons.mic},
    {"title": "Pick A Course", "icon": Icons.menu_book},
    {"title": "Course Validation Pending", "icon": Icons.hourglass_top},
    {"title": "Statistics", "icon": Icons.bar_chart},
    {"title": "Logout", "icon": Icons.logout},
  ];

  void _navigateTo(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AudioListScreen()),
        );
        break;

      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PickCourse()),
        );
        break;

      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const PendingScreen()),
        );
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StatisticsScreen()),
        );
        break;

      case 4:
        _logout();
        break;
    }
  }

  void _logout() {
    // TODO: clear session / token if using Provider

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LogoutScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      /*appBar: AppBar(
        title: const Text("List of Operations"),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
          ),
        ),
      ),*/

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];

          return GestureDetector(
            onTap: () => _navigateTo(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  )
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
