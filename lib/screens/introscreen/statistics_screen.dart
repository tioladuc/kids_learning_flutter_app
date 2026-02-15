import 'package:flutter/material.dart';

import '../../widgets/app_page_title.dart';
import '../../widgets/app_scaffold.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      //appBar: AppBar(title: const Text("Statistics")),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              PageTitle(text:"Statistics++"),
              const Text("Statistics 999")
            ],
          ),
        ),
      ),

      //const Center(child: Text("Statistics Page")),
    );
  }
}
