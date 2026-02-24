import 'package:flutter/material.dart';

import '../models/course.dart';

class CourseProvider with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  List<Course> pendingCourses = [];
  List<Course> pickCourses = [];

  Future<void> loadChildPendingCourses(String childId) async {
    isLoading = true;
    notifyListeners();

    try {
      // TODO: Replace with API
      await Future.delayed(const Duration(seconds: 2));
      pendingCourses = [
        Course(
          code: "C001CCC",
          name: "Mathematics",
          amount: 50,
          validity: "1 Month",
          isRegistered: false,
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C002",
          name: "Reading",
          amount: 30,
          validity: "1 Term",
          isRegistered: true,
          expiryDate: DateTime.now().add(const Duration(days: 5)),
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C003",
          name: "Mathematics++",
          amount: 50,
          validity: "1 Month",
          isRegistered: false,
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C004",
          name: "Reading++",
          amount: 30,
          validity: "1 Term",
          isRegistered: true,
          expiryDate: DateTime.now().add(const Duration(days: 5)),
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
      ];
    } catch (e) {
      errorMessage = "Failed to load courses";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadChildPickCourses(String childId) async {
    isLoading = true;
    notifyListeners();

    try {
      // TODO: Replace with API
      await Future.delayed(const Duration(seconds: 2));
      pickCourses = [
        Course(
          code: "C001",
          name: "Mathematics",
          amount: 50,
          validity: "1 Month",
          isRegistered: false,
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C002",
          name: "Reading",
          amount: 30,
          validity: "1 Term",
          isRegistered: true,
          expiryDate: DateTime.now().add(const Duration(days: 5)),
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C003",
          name: "Mathematics++",
          amount: 50,
          validity: "1 Month",
          isRegistered: false,
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
        Course(
          code: "C004",
          name: "Reading++",
          amount: 30,
          validity: "1 Term",
          isRegistered: true,
          expiryDate: DateTime.now().add(const Duration(days: 5)),
          description:
              'rap the ListView with an Expanded or Flexible widget to allow it to fill the remaining available space within the C',
        ),
      ];
    } catch (e) {
      errorMessage = "Failed to load courses";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> payCourse({
    required String childId,
    required String courseCode,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      // TODO: Call API
      await Future.delayed(const Duration(seconds: 2));

      // Remove the paid course from the list
      pendingCourses.removeWhere((c) => c.code == courseCode);

      return true;
    } catch (e) {
      errorMessage = "Payment failed";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> removeCourse({
    required String childId,
    required String courseCode,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      // TODO: Call API
      await Future.delayed(const Duration(seconds: 2));

      // Remove the paid course from the list
      pendingCourses.removeWhere((c) => c.code == courseCode);

      return true;
    } catch (e) {
      errorMessage = "Payment failed";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickCourse(String childId, String courseCode) async {
    // Call API to register course
    // Remove course locally or reload list
    pickCourses.removeWhere((elt) => elt.code == courseCode);
  }
}
