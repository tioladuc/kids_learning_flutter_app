import 'package:flutter/material.dart';

import '../../../models/child.dart';
import '../../../widgets/app_scaffold.dart';

class ChildStatistics extends StatelessWidget {
  final Child child;

  const ChildStatistics({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    child.completedTasks = 70;
   child.totalTasks = 60;
   child.totalTimeMinutes = 50;
   child.streakDays = 20;
  child.age = 10;

    final completionRate = child.totalTasks == 0
        ? 0
        : (child.completedTasks! / child.totalTasks!);

    return AppScaffold(
      body:SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildProgressCard(completionRate.toDouble()),
          const SizedBox(height: 20),
          _buildStatsGrid(),
        ],
      ),
    ),
    );
    
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 28,
          child: Text(
            child.name[0].toUpperCase(),
            style: const TextStyle(fontSize: 22),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              child.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Age: ${child.age!}",
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildProgressCard(double completionRate) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Progress",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: completionRate,
              minHeight: 10,
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 12),
            Text(
              "${(completionRate * 100).toStringAsFixed(0)}% completed",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _buildStatCard(
          title: "Completed",
          value: "${child.completedTasks}",
          icon: Icons.check_circle,
          color: Colors.green,
        ),
        _buildStatCard(
          title: "Remaining",
          value: "${child.totalTasks! - child.completedTasks!}",
          icon: Icons.pending,
          color: Colors.orange,
        ),
        _buildStatCard(
          title: "Time Spent",
          value: "${child.totalTimeMinutes} min",
          icon: Icons.timer,
          color: Colors.blue,
        ),
        _buildStatCard(
          title: "Streak",
          value: "${child.streakDays} days",
          icon: Icons.local_fire_department,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
