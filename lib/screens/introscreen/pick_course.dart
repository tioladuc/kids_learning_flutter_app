import 'package:flutter/material.dart';

import '../../widgets/app_page_title.dart';
import '../../widgets/app_scaffold.dart';

class PickCourse extends StatelessWidget {
  const PickCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Pick A Course")),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              PageTitle(text:"Course List Page++"),
              Text("Course List Page 999")
            ],
          ),
        ),
      ),//const Center(child: Text("Course List Page")),
    );
  }
}
