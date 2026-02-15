import 'package:flutter/material.dart';

import '../../widgets/app_scaffold.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Pending Validation")),
      body: const Center(child: Text("Pending Courses Page")),
    );
  }
}
