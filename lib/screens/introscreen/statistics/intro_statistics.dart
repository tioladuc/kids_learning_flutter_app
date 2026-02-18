import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/child.dart';
import '../../../models/course.dart';
import '../../../providers/statistics_provider.dart';
import '../../../widgets/app_scaffold.dart';
import 'statistics_course.dart';

class IntroStatistics extends StatefulWidget {
  final Child child;
  final bool isViewParent;
  final bool isResponsible;

  const IntroStatistics({
    super.key,
    required this.child,
    this.isViewParent = false,
    this.isResponsible = false,
  });

  @override
  State<IntroStatistics> createState() => _IntroStatisticsState();
}

class _IntroStatisticsState extends State<IntroStatistics> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<StatisticsProvider>()
          .getBasicInformation(widget.child);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatisticsProvider>();

    return AppScaffold(
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(provider),
    );
  }

  Widget _buildBody(StatisticsProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _childHeader(),
          const SizedBox(height: 16),

          _sectionTitle("Basic Information"),
          _basicInfo(),

          const SizedBox(height: 16),
          _sectionTitle("Last Connection"),
          _connectionInfo(provider),

          const SizedBox(height: 16),
          _sectionTitle("Courses Visited"),
          _coursesVisited(provider),

          const SizedBox(height: 16),
          _sectionTitle("Courses Completed"),
          _coursesCompleted(provider),

          const SizedBox(height: 16),
          _sectionTitle("Courses Never Done"),
          _coursesNeverDone(provider),
        ],
      ),
    );
  }

  /// HEADER
  Widget _childHeader() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.child.name.isNotEmpty
              ? widget.child.name[0]
              : "?"),
        ),
        title: Text(widget.child.name),
        subtitle: Text("Login: ${widget.child.login}"),
        trailing: widget.isResponsible
            ? const Icon(Icons.star, color: Colors.orange)
            : null,
      ),
    );
  }

  /// BASIC INFO
  Widget _basicInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _infoRow("Age", "${widget.child.age ?? '-'}"),
            _infoRow("Completed Tasks",
                "${widget.child.completedTasks ?? 0}"),
            _infoRow("Total Tasks",
                "${widget.child.totalTasks ?? 0}"),
            _infoRow("Total Time",
                "${widget.child.totalTimeMinutes ?? 0} min"),
            _infoRow("Streak Days",
                "${widget.child.streakDays ?? 0} days"),
          ],
        ),
      ),
    );
  }

  /// CONNECTION INFO
  Widget _connectionInfo(StatisticsProvider provider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _infoRow("Last Connection",
                provider.lastConnectionTime ?? "-"),
            _infoRow("Duration",
                provider.lastConnectionDuration ?? "-"),
          ],
        ),
      ),
    );
  }

  /// COURSES VISITED
  Widget _coursesVisited(StatisticsProvider provider) {
    if (provider.visitedCourses.isEmpty) {
      return const Text("No courses visited");
    }

    return Column(
      children: provider.visitedCourses.map((item) {
        final course = item.course;
        final duration = item.timeSpent;

        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text("Time spent: $duration min"),
            leading: const Icon(Icons.visibility),
          ),
        );
      }).toList(),
    );
  }

  /// COURSES COMPLETED
  Widget _coursesCompleted(StatisticsProvider provider) {
    if (provider.completedCourses.isEmpty) {
      return const Text("No completed courses");
    }

    return Column(
      children: provider.completedCourses.map((course) {
        return Card(
          child: ListTile(
            title: Text(course.name),
            leading: const Icon(Icons.check_circle, color: Colors.green),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StatisticsCourse(
                    child: widget.child,
                    course: course,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  /// COURSES NEVER DONE
  Widget _coursesNeverDone(StatisticsProvider provider) {
    if (provider.neverDoneCourses.isEmpty) {
      return const Text("No pending courses");
    }

    return Column(
      children: provider.neverDoneCourses.map((item) {
        final course = item.course;
        final date = item.pickedDate;

        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text("Picked on: ${_formatDate(date)}"),
            leading: const Icon(Icons.schedule, color: Colors.orange),
          ),
        );
      }).toList(),
    );
  }

  /// UTIL
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
