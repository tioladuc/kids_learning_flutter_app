import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/session_provider.dart';
import 'login_screen.dart';
import 'audio_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionProvider>();

    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
          session.isLoggedIn ? const AudioListScreen() : const LoginScreen(),
        ),
      );
    });

    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
