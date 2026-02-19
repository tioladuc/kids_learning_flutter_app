import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_course.dart';
import '../../../core/constances.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
import '../../../models/course.dart';
import '../../../providers/course_provider.dart';
import '../../../widgets/app_scaffold.dart';

class ChildPendingScreen extends StatefulWidget {
  final Child child;

  const ChildPendingScreen({super.key, required this.child});

  @override
  State<ChildPendingScreen> createState() => _ChildPendingScreenState();
}

class _ChildPendingScreenState extends State<ChildPendingScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CourseProvider>().loadChildPendingCourses(widget.child.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(body: _buildBody(provider, notifyData));
  }

  Widget _buildBody(CourseProvider provider, NotifyData notifyData) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.pendingCourses.isEmpty) {
      return Center(
          child: Text(notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantCourse.NoPendingCourseMsgEN
              : ConstantCourse.NoPendingCourseMsgFR));
    }

    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () => {}, //context.read<SessionProvider>().login('child'),
          style: Constant.getTitle1ButtonStyle(),
          child: Text("${widget.child.name} - " +
              (notifyData.currentLanguage == Constant.AppNameEN
                  ? ConstantCourse.PendingCourseTitleEN
                  : ConstantCourse.PendingCourseTitleFR)),
        ),
        Expanded(
          // <-- Use Expanded
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.pendingCourses.length,
            itemBuilder: (context, index) {
              final course = provider.pendingCourses[index];
              return _courseCard(course, provider, notifyData);
            },
          ),
        ),
      ],
    );
  }

  Widget _courseCard(
      Course course, CourseProvider courseProvider, NotifyData notifyData) {
    final isExpiringSoon = course.expiryDate != null &&
        course.expiryDate!.isBefore(
          DateTime.now().add(const Duration(days: 7)),
        );

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(course),
            const SizedBox(height: 10),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantCourse.PendingCourseCodeEN
                    : ConstantCourse.PendingCourseCodeFR),
                course.code),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantCourse.PendingCourseDescriptionEN
                    : ConstantCourse.PendingCourseDescriptionFR),
                course.description),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantCourse.PendingCourseAmountEN
                    : ConstantCourse.PendingCourseAmountFR),
                "\$${course.amount.toStringAsFixed(2)}"),
            _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantCourse.PendingCourseValidityEN
                    : ConstantCourse.PendingCourseValidityFR),
                course.validity),
            if (course.isRegistered && course.expiryDate != null)
              _infoRow(
                (notifyData.currentLanguage == Constant.AppNameEN
                    ? ConstantCourse.PendingCourseExpireEN
                    : ConstantCourse.PendingCourseExpireFR),
                _formatDate(course.expiryDate!),
                highlight: isExpiringSoon,
              ),
            _removeCourseButton(course, courseProvider, notifyData),
          ],
        ),
      ),
    );
  }

  Widget _removeCourseButton(
      Course course, CourseProvider provider, NotifyData notifyData) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: provider.isLoading
              ? null
              : () => _handleRemoveCourse(course, provider),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: provider.isLoading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(notifyData.currentLanguage == Constant.AppNameEN
                  ? ConstantCourse.PendingCourseRemoveCourseEN
                  : ConstantCourse.PendingCourseRemoveCourseFR),
        ),
      ),
    );
  }

  Future<void> _handleRemoveCourse(
    Course course,
    CourseProvider provider,
    NotifyData notifyData,
  ) async {
    final confirm = await _showConfirmationCourseRemovalDialog(course);

    if (confirm != true) return;

    final success = await provider.removeCourse(
      childId: widget.child.id,
      courseCode: course.code,
    );

    if (!mounted) return;

    if (success) {
      _showSuccessCourseRemovalDialog();
    } else {
      _showError(provider.errorMessage ??
          (notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantCourse.PendingCourseCourseRemovalFailedEN
              : ConstantCourse.PendingCourseCourseRemovalFailedFR));
    }
  }

  Future<bool?> _showConfirmationCourseRemovalDialog(
      Course course, NotifyData notifyData) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PendingCourseConfirmPaymentTitleEN
            : ConstantCourse.PendingCourseConfirmPaymentTitleFR)),
        content: Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PendingCourseRemovalMsgEN
                : ConstantCourse.PendingCourseRemovalMsgFR)
            .replaceAll('{0}', course.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PendingCourseRemovalCancelBtnEN
                : ConstantCourse.PendingCourseRemovalCancelBtnFR)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PendingCourseRemovalConfirmBtnEN
                : ConstantCourse.PendingCourseRemovalConfirmBtnFR)),
          ),
        ],
      ),
    );
  }

  void _showSuccessCourseRemovalDialog(NotifyData notifyData) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PendingCourseRemovalSuccessTitleEN
            : ConstantCourse.PendingCourseRemovalSuccessTitleFR)),
        content: const Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PendingCourseRemovalSuccessMsgEN
            : ConstantCourse.PendingCourseRemovalSuccessMsgFR)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PendingCourseRemovalSuccessOKEN
                : ConstantCourse.PendingCourseRemovalSuccessOKFR)),
          ),
        ],
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Widget _header(Course course) {
    final isExpiringSoon = course.expiryDate != null &&
        course.expiryDate!.isBefore(
          DateTime.now().add(const Duration(days: 7)),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            course.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _statusBadge(course, isExpiringSoon),
      ],
    );
  }

  Widget _statusBadge(
      Course course, bool isExpiringSoon, NotifyData notifyData) {
    String text;
    Color color;

    if (!course.isRegistered) {
      text = (notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantCourse.PendingCoursePaymentStatusPendingEN
          : ConstantCourse.PendingCoursePaymentStatusPendingFR);
      color = Colors.orange;
    } else if (isExpiringSoon) {
      text = (notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantCourse.PendingCoursePaymentStatusExpiringSoonEN
          : ConstantCourse.PendingCoursePaymentStatusExpiringSoonFR);
      color = Colors.red;
    } else {
      text = (notifyData.currentLanguage == Constant.AppNameEN
          ? ConstantCourse.PendingCoursePaymentStatusActiveEN
          : ConstantCourse.PendingCoursePaymentStatusActiveFR);
      color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: highlight ? Colors.red : Colors.black,
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
