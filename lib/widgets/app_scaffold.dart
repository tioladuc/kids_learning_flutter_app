import 'package:flutter/material.dart';
import 'app_header.dart';
import 'app_footer.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      bottomNavigationBar: const AppFooter(),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
