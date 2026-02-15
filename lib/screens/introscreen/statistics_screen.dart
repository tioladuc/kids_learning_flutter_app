import 'package:flutter/material.dart';

import '../../widgets/app_scaffold.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Statistics")),
      body: const Center(child: Text("Statistics Page")),
    );
  }
}
