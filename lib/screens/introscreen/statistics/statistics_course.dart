import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_statistics.dart';
import '../../../core/constances.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
import '../../../models/course.dart';
import '../../../models/course_statistics.dart';
import '../../../providers/course_provider.dart';
import '../../../providers/statistics_provider.dart';
import '../../../widgets/app_scaffold.dart';

class StatisticsCourse extends StatefulWidget {
  final Child child;
  final Course course;

  const StatisticsCourse({
    super.key,
    required this.child,
    required this.course,
  });

  @override
  State<StatisticsCourse> createState() => _StatisticsCourseState();
}

class _StatisticsCourseState extends State<StatisticsCourse> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StatisticsProvider>().loadCourseStatistics(
            widget.child.id,
            widget.course.code,
          );
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
    if (provider.courseStatistics.isEmpty) {
      return Center(
        child: Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantStatistics.CourseStatNoStatisticsAvailableEN
            : ConstantStatistics.CourseStatNoStatisticsAvailableFR)),
      );
    }

    return Column(
      children: [
        _header(notifyData),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.courseStatistics.length,
            itemBuilder: (context, index) {
              final stat = provider.courseStatistics[index];
              return _statCard(stat, notifyData);
            },
          ),
        ),
      ],
    );
  }

  /// HEADER
  Widget _header(NotifyData notifyData) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.bar_chart, size: 40),
        title: Text(widget.course.name),
        subtitle: Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantStatistics.CourseStatChildEN
                : ConstantStatistics.CourseStatChildFR)
            .replaceAll('{0}', widget.child.name)),
      ),
    );
  }

  /// STAT CARD
  Widget _statCard(CourseStatistics stat, NotifyData notifyData) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _dateHeader(stat),
            const SizedBox(height: 8),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.CourseStatStartEN
                    : ConstantStatistics.CourseStatStartFR),
                _formatDate(stat.startDate)),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.CourseStatEndEN
                    : ConstantStatistics.CourseStatEndFR),
                _formatDate(stat.endDate)),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.CourseStatDurationEN
                    : ConstantStatistics.CourseStatDurationFR),
                (notifyData.currentLanguage == Constant.AppNameEN
                        ? ConstantStatistics.CourseStatMinuteEN
                        : ConstantStatistics.CourseStatMinuteFR)
                    .replaceAll('{0}', stat.duration.toString())),
            const Divider(),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantStatistics.CourseStatDetailEN
                    : ConstantStatistics.CourseStatDetailFR),
                stat.detail),
            const SizedBox(height: 8),
            _appreciationBadge(stat.appreciation, notifyData),
          ],
        ),
      ),
    );
  }

  /// DATE HEADER
  Widget _dateHeader(CourseStatistics stat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _formatDate(stat.startDate),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const Icon(Icons.history, size: 18),
      ],
    );
  }

  /// APPRECIATION BADGE
  Widget _appreciationBadge(String appreciation, NotifyData notifyData) {
    Color color;

    if (ConstantStatistics.CourseStatExcellentEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        ConstantStatistics.CourseStatExcellentFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.green;
    } else if (ConstantStatistics.CourseStatGoodEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        ConstantStatistics.CourseStatGoodFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.blue;
    } else if (ConstantStatistics.CourseStatAverageEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        ConstantStatistics.CourseStatAverageFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.orange;
    } else if (ConstantStatistics.CourseStatPoorEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        ConstantStatistics.CourseStatPoorFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }

    /*switch (appreciation.toLowerCase()) {
      case "excellent":
        color = Colors.green;
        break;
      case "good":
        color = Colors.blue;
        break;
      case "average":
        color = Colors.orange;
        break;
      case "poor":
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }*/

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        appreciation,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// INFO ROW
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  /// DATE FORMAT
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
