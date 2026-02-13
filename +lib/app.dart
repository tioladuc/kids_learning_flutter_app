import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme.dart';
import 'screens/splash_screen.dart';
import 'state/audio_provider.dart';
import 'state/session_provider.dart';


import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ], 
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample App++',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    ));
    /*MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sample App++',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );*/
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample App"),
        actions: [
          IconButton(
            icon: Icon(
              _isLoggedIn ? Icons.logout : Icons.login,
            ),
            onPressed: () {
              setState(() {
                _isLoggedIn = !_isLoggedIn;
              });
            },
          ),
        ],
      ),

      // BODY
      body: Column(
        children: [
          // Fixed header section (optional)
          Container(
            height: 60,
            width: double.infinity,
            color: Colors.blue.shade50,
            alignment: Alignment.center,
            child: Text(
              "Current tab: ${_getTitle()}",
              style: const TextStyle(fontSize: 16),
            ),
          ),

          MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),

          // FIXED but SCROLLABLE middle
          /*Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: List.generate(
                  30,
                  (index) => Card(
                    child: ListTile(
                      leading: const Icon(Icons.star),
                      title: Text("Scrollable item ${index + 1}"),
                    ),
                  ),
                ),
              ),
            ),
          ),*/
        ],
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: "Operations",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  String _getTitle() {
    switch (_currentIndex) {
      case 0:
        return "Home";
      case 1:
        return "Settings";
      case 2:
        return "Operations";
      case 3:
        return "Profile";
      default:
        return "";
    }
  }
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
*/
