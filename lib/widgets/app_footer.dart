import 'package:flutter/material.dart';


class AppFooter extends StatefulWidget {
  
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooter();

}

class _AppFooter  extends State<AppFooter>  {//class AppFooter extends StatelessWidget {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),

            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.white,

            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,

            selectedFontSize: 12,
            unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Report'),
      ],
    );
  }
}
