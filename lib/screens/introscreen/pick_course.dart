import 'package:flutter/material.dart';

import '../../widgets/app_scaffold.dart';

class PickCourse extends StatelessWidget {
  const PickCourse({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Pick A Course")),
      body: const Center(child: Text("Course List Page")),
    );
  }
}
