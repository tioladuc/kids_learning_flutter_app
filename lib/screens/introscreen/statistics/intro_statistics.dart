import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_statistics.dart';
import '../../../core/constances.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
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
  Child? child;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async{
      child = await context.read<StatisticsProvider>().getBasicInformation(widget.child);

      await context.read<StatisticsProvider>().loadVisitedCourses(widget.child);
      await context.read<StatisticsProvider>().loadCompletedCourses(widget.child);
      await context.read<StatisticsProvider>().loadNeverDoneCourses(widget.child);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatisticsProvider>();
    final notifyData = context.watch<NotifyData>();

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
          _sectionTitle((notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.IntroStatTitleBasicInformationEN
              : ConstantStatistics.IntroStatTitleBasicInformationFR)),
          _basicInfo(notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.IntroStatTitleLastConnectionEN
              : ConstantStatistics.IntroStatTitleLastConnectionFR)),
          _connectionInfo(provider, notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.IntroStatTitleCoursesVisitedEN
              : ConstantStatistics.IntroStatTitleCoursesVisitedFR)),
          _coursesVisited(provider, notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.IntroStatTitleCoursesCompletedEN
              : ConstantStatistics.IntroStatTitleCoursesCompletedFR)),
          _coursesCompleted(provider, notifyData),
          const SizedBox(height: 16),
          _sectionTitle((notifyData.currentLanguage == Constant.languageEN
              ? ConstantStatistics.IntroStatTitleCoursesNeverDoneEN
              : ConstantStatistics.IntroStatTitleCoursesNeverDoneFR)),
          _coursesNeverDone(provider, notifyData),
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
        subtitle: Text((notifyData.currentLanguage == Constant.languageEN
                ? ConstantStatistics.IntroStatLoginEN
                : ConstantStatistics.IntroStatLoginFR)
            .replaceAll('{1}', child!.login)),
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
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatAgeEN
                    : ConstantStatistics.IntroStatAgeFR),
                "${child!.age ?? '-'}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatCompletedTasksEN
                    : ConstantStatistics.IntroStatCompletedTasksFR),
                "${child!.completedTasks ?? 0}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatTotalTasksEN
                    : ConstantStatistics.IntroStatTotalTasksFR),
                "${child!.totalTasks ?? 0}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatTotalTimeEN
                    : ConstantStatistics.IntroStatTotalTimeFR),
                (notifyData.currentLanguage == Constant.languageEN
                        ? ConstantStatistics.IntroStatMinuteEN
                        : ConstantStatistics.IntroStatMinuteFR)
                    .replaceAll('{0}', (child!.totalTimeMinutes ?? 0).toString())),
            _infoRow(
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatStreakDaysEN
                    : ConstantStatistics.IntroStatStreakDaysFR),
                (notifyData.currentLanguage == Constant.languageEN
                        ? ConstantStatistics.IntroStatDaysEN
                        : ConstantStatistics.IntroStatDaysFR)
                    .replaceAll('{0}', (child!.streakDays ?? 0).toString())),
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
                (notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatLastConnectionEN
                    : ConstantStatistics.IntroStatLastConnectionFR),
                provider.lastConnectionTime ?? "-"),
            _infoRow(
                (notifyData.currentLanguage == Constant.languageEN
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
      return Text((notifyData.currentLanguage == Constant.languageEN
          ? ConstantStatistics.IntroStatNoCoursesVisitedEN
          : ConstantStatistics.IntroStatNoCoursesVisitedFR));
    }

    return Column(
      children: provider.visitedCourses.map((item) {
        final course = item.course;
        final duration = item.timeSpent;
        final lastDateConnection = item.lastDateConnection;

        return Card(
          child: ListTile(
            title: Text(course.name),
            subtitle: Text((notifyData.currentLanguage == Constant.languageEN
                    ? ConstantStatistics.IntroStatTimeSpentEN
                    : ConstantStatistics.IntroStatTimeSpentFR)
                .replaceAll('{0}', duration.toString())
                .replaceAll('{1}', _formatDate(lastDateConnection))),
            leading: const Icon(Icons.visibility),
            onTap: (){
              setState(() {
                Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => StatisticsCourse(child: child!, course: item.course,)),
      );
              });
            },
          ),
        );
      }).toList(),
    );
  }

  /// COURSES COMPLETED
  Widget _coursesCompleted(StatisticsProvider provider, NotifyData notifyData) {
    if (provider.completedCourses.isEmpty) {
      return Text((notifyData.currentLanguage == Constant.languageEN
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
      return Text((notifyData.currentLanguage == Constant.languageEN
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
            subtitle: Text((notifyData.currentLanguage == Constant.languageEN
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
