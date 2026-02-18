import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/course.dart';
import '../models/course_statistics.dart';

class StatisticsProvider extends ChangeNotifier {
  bool isLoading = false;

  String? lastConnectionTime;
  String? lastConnectionDuration;

  List<VisitedCourse> visitedCourses = [];
  List<Course> completedCourses = [];
  List<NeverDoneCourse> neverDoneCourses = [];

  Future<void> getBasicInformation(Child child) async {
    isLoading = true;
    notifyListeners();

    // API CALL HERE

    isLoading = false;
    notifyListeners();
  }

  List<CourseStatistics> courseStatistics = [];

  Future<void> loadCourseStatistics(String childId, String courseId) async {
    isLoading = true;
    notifyListeners();

    // API call here

    // IMPORTANT: order by date (latest first or oldest first)
    courseStatistics.sort((a, b) => b.startDate.compareTo(a.startDate));

    isLoading = false;
    notifyListeners();
  }
}
