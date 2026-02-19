import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constance_course.dart';
import '../../../core/constances.dart';
import '../../../core/notify_data.dart';
import '../../../models/child.dart';
import '../../../models/course.dart';
import '../../../providers/course_provider.dart';
import '../../../widgets/app_scaffold.dart';

class ChildPickCourse extends StatefulWidget {
  final Child child;

  const ChildPickCourse({
    super.key,
    required this.child,
  });

  @override
  State<ChildPickCourse> createState() => _ChildPickCourseState();
}

class _ChildPickCourseState extends State<ChildPickCourse> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CourseProvider>().loadChildPickCourses(widget.child.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CourseProvider>();
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      body: _buildBody(provider, notifyData),
    );
  }

  Widget _buildBody(CourseProvider provider, NotifyData notifyData) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.pickCourses.isEmpty) {
      return Center(
        child: Text(notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PickCourseNoCourseAvailableEN
            : ConstantCourse.PickCourseNoCourseAvailableFR),
      );
    }

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: Constant.getTitle1ButtonStyle(),
          child: Text("${widget.child.name} - " + (
              notifyData.currentLanguage == Constant.AppNameEN
                  ? ConstantCourse.PickCoursePickACourseEN
                  : ConstantCourse.PickCoursePickACourseFR)),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.pickCourses.length,
            itemBuilder: (context, index) {
              final course = provider.pickCourses[index];
              return _courseCard(course, notifyData);
            },
          ),
        ),
      ],
    );
  }

  Widget _courseCard(Course course, NotifyData notifyData) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
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
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _confirmPick(course, notifyData),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                    (notifyData.currentLanguage == Constant.AppNameEN
                        ? ConstantCourse.PickCoursePickACourseEN
                        : ConstantCourse.PickCoursePickACourseFR)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(Course course) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            course.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _statusBadge(),
      ],
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        "Available",
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  /// CONFIRMATION DIALOG
  void _confirmPick(Course course, NotifyData notifyData) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PickCourseConfirmTitleEN
            : ConstantCourse.PickCourseConfirmTitleFR)),
        content: Text((notifyData.currentLanguage == Constant.AppNameEN
            ? ConstantCourse.PickCourseConfirmDescriptionEN
            : ConstantCourse.PickCourseConfirmDescriptionFR)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PickCoursePickCancelBtnEN
                : ConstantCourse.PickCoursePickCancelBtnFR)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text((notifyData.currentLanguage == Constant.AppNameEN
                ? ConstantCourse.PickCoursePickConfirmBtnEN
                : ConstantCourse.PickCoursePickConfirmBtnFR)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _pickCourse(course);
    }
  }

  /// PICK COURSE ACTION
  Future<void> _pickCourse(Course course) async {
    final provider = context.read<CourseProvider>();
    final notifyData = context.read<NotifyData>();

    try {
      await provider.pickCourse(widget.child.id, course.code);

      if (!mounted) return;

      /// SUCCESS MESSAGE
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantCourse.PickCoursePickConfirmSuccessEN
              : ConstantCourse.PickCoursePickConfirmSuccessFR)),
          content: Text((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantCourse.PickCoursePickConfirmSuccessMsgEN
              : ConstantCourse.PickCoursePickConfirmSuccessMsgFR)),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                  (notifyData.currentLanguage == Constant.AppNameEN
                      ? ConstantCourse.PickCoursePickConfirmSuccessOKEN
                      : ConstantCourse.PickCoursePickConfirmSuccessOKFR)),
            ),
          ],
        ),
      );

      /// REFRESH LIST
      provider.loadChildPickCourses(widget.child.id);
    } catch (e) {
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text((notifyData.currentLanguage == Constant.AppNameEN
              ? ConstantCourse.PickCoursePickConfirmSuccessErrorEN
              : ConstantCourse.PickCoursePickConfirmSuccessErrorFR)),
          content: Text(e.toString()),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                  (notifyData.currentLanguage == Constant.AppNameEN
                      ? ConstantCourse.PickCoursePickConfirmSuccessOKEN
                      : ConstantCourse.PickCoursePickConfirmSuccessOKFR)),
            ),
          ],
        ),
      );
    }
  }
}
