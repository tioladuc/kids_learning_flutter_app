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
      context.read<StatisticsProvider>().getBasicInformation(widget.child);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatisticsProvider>();
    final notifyData = context.read<NotifyData>();

    return AppScaffold(
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(provider, notifyData),
    );
  }

  Widget _buildBody(StatisticsProvider provider, NotifyData notifyData) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _childHeader(notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantStatistics.IntroStatTitleBasicInformationEN
              : ConstantStatistics.IntroStatTitleBasicInformationFR)),
          _basicInfo(notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantStatistics.IntroStatTitleLastConnectionEN
              : ConstantStatistics.IntroStatTitleLastConnectionFR)),
          _connectionInfo(provider),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantStatistics.IntroStatTitleCoursesVisitedEN
              : ConstantStatistics.IntroStatTitleCoursesVisitedFR)),
          _coursesVisited(provider),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantStatistics.IntroStatTitleCoursesCompletedEN
              : ConstantStatistics.IntroStatTitleCoursesCompletedFR)),
          _coursesCompleted(provider),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantStatistics.IntroStatTitleCoursesNeverDoneEN
              : ConstantStatistics.IntroStatTitleCoursesNeverDoneFR)),
          _coursesNeverDone(provider),
        ],
      ),
    );
  }

  /// HEADER
  Widget _childHeader(NotifyData notifyData) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          child:
              Text(widget.child.name.isNotEmpty ? widget.child.name[0] : "?"),
        ),
        title: Text(widget.child.name),
        subtitle: Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantStatistics.IntroStatLoginEN
                : ConstantStatistics.IntroStatLoginFR)
            .replaceAll('{1}', widget.child.login)),
        trailing: widget.isResponsible
            ? const Icon(Icons.star, color: Colors.orange)
            : null,
      ),
    );
  }

  /// BASIC INFO
  Widget _basicInfo(NotifyData notifyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatAgeEN
                    : ConstantStatistics.IntroStatAgeFR),
                "${widget.child.age ?? '-'}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatCompletedTasksEN
                    : ConstantStatistics.IntroStatCompletedTasksFR),
                "${widget.child.completedTasks ?? 0}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatTotalTasksEN
                    : ConstantStatistics.IntroStatTotalTasksFR),
                "${widget.child.totalTasks ?? 0}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatTotalTimeEN
                    : ConstantStatistics.IntroStatTotalTimeFR),
                (notifyData.currentLanguage == Constant.AppNameEN
                        ? ConstantStatistics.IntroStatMinuteEN
                        : ConstantStatistics.IntroStatMinuteFR)
                    .replaceAll('{0}', (widget.child.totalTimeMinutes ?? 0))),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatStreakDaysEN
                    : ConstantStatistics.IntroStatStreakDaysFR),
                (notifyData.currentLanguage == Constant.AppNameEN
                        ? ConstantStatistics.IntroStatDaysEN
                        : ConstantStatistics.IntroStatDaysFR)
                    .replaceAll('{0}', (widget.child.streakDays ?? 0))),
          ],
        ),
      ),
    );
  }

  /// CONNECTION INFO
  Widget _connectionInfo(StatisticsProvider provider, NotifyData notifyData) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatLastConnectionEN
                    : ConstantStatistics.IntroStatLastConnectionFR),
                provider.lastConnectionTime ?? "-"),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatDurationEN
                    : ConstantStatistics.IntroStatDurationFR),
                provider.lastConnectionDuration ?? "-"),
          ],
        ),
      ),
    );
  }

  /// COURSES VISITED
  Widget _coursesVisited(StatisticsProvider provider, NotifyData notifyData) {
    if (provider.visitedCourses.isEmpty) {
      return const Text((notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantStatistics.IntroStatNoCoursesVisitedEN
          : ConstantStatistics.IntroStatNoCoursesVisitedFR));
    }

    return Column(
      children: provider.visitedCourses.map((item) {
        final course = item.course;
        final duration = item.timeSpent;

        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text((notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatTimeSpentEN
                    : ConstantStatistics.IntroStatTimeSpentFR)
                .replaceAll('{0}', $duration)),
            leading: const Icon(Icons.visibility),
          ),
        );
      }).toList(),
    );
  }

  /// COURSES COMPLETED
  Widget _coursesCompleted(StatisticsProvider provider, NotifyData notifyData) {
    if (provider.completedCourses.isEmpty) {
      return const Text((notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantStatistics.IntroStatNoCompletedCoursesEN
          : ConstantStatistics.IntroStatNoCompletedCoursesFR));
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
  Widget _coursesNeverDone(StatisticsProvider provider, NotifyData notifyData) {
    if (provider.neverDoneCourses.isEmpty) {
      return const Text((notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantStatistics.IntroStatNoPendingCoursesEN
          : ConstantStatistics.IntroStatNoPendingCoursesFR));
    }

    return Column(
      children: provider.neverDoneCourses.map((item) {
        final course = item.course;
        final date = item.pickedDate;

        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text((notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.IntroStatPickedOnEN
                    : ConstantStatistics.IntroStatPickedOnFR)
                .replaceAll('{0}', _formatDate(date))),
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
