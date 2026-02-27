import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_statistics.dart';
import '../../../core/constances.dart';
import '../../../core/core_translator.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
import '../../../models/course.dart';
import '../../../models/course_statistics.dart';
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
  Translator translator = Translator();
  
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<StatisticsProvider>().loadCourseStatistics(
            widget.child,
            widget.course,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StatisticsProvider>();
    final notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_STATISTICS, lang: notifyData.currentLanguage);

    return AppScaffold(
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(provider, notifyData),
    );
  }

  Widget _buildBody(StatisticsProvider provider, NotifyData notifyData) {
    if (provider.courseStatistics.isEmpty) {
      return Center(
        child: Text(translator.getText('CourseStatNoStatisticsAvailable')),
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
        subtitle: Text(translator.getText('CourseStatChild')
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
                translator.getText('CourseStatStart'),
                _formatDate(stat.startDate)),
            _infoRow(
                translator.getText('CourseStatEnd'),
                _formatDate(stat.endDate)),
            _infoRow(
                translator.getText('CourseStatDuration'),
                translator.getText('CourseStatMinute')
                    .replaceAll('{0}', stat.duration.toString())),
            const Divider(),
            _infoRow(
                translator.getText('CourseStatDetail'),
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

    if (NotifyData.CourseStatExcellentEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        NotifyData.CourseStatExcellentFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.green;
    } else if (NotifyData.CourseStatGoodEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        NotifyData.CourseStatGoodFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.blue;
    } else if (NotifyData.CourseStatAverageEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        NotifyData.CourseStatAverageFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.orange;
    } else if (NotifyData.CourseStatPoorEN.toLowerCase() ==
            appreciation.toLowerCase() ||
        NotifyData.CourseStatPoorFR.toLowerCase() ==
            appreciation.toLowerCase()) {
      color = Colors.red;
    } else {
      color = Colors.grey;
    }

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
