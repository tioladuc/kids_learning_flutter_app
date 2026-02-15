import 'package:flutter/material.dart';

import '../../widgets/app_page_title.dart';
import '../../widgets/app_scaffold.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Pending Validation")),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              PageTitle(text:"Pending Courses Page++"),
              const Text("Pending Courses Page 999")
            ],
          ),
        ),
      ),//const Center(child: Text("Pending Courses Page")),
    );
  }
}
