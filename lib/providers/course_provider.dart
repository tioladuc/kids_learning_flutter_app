import 'package:flutter/material.dart';
import 'package:kids_learning_flutter_app/core/notify_data.dart';
import 'package:kids_learning_flutter_app/providers/session_provider.dart';

import '../core/api_client.dart';
import '../models/course.dart';
import 'session_base.dart';

class CourseProvider extends SessionBase {
  bool isLoading = false;
  String? errorMessage;

  List<Course> pendingCourses = [];
  List<Course> pickCourses = [];

  Future<bool> loadChildPendingCourses(String childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/course/loadChildPendingCourses', {
        "childid": childId,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadChildPendingCoursesError',
        );
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*isLoading = true;
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
    }*/
  }

  Future<bool> loadChildPickCourses(String childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/course/loadChildPickCourses', {
        "childid": childId,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadChildPickCoursesError',
        );
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*isLoading = true;
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
    }*/
  }

  Future<bool> payCourse({
    required String childId,
    required String courseCode,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/course/payCourse', {
        "childid": childId,
        "coursecode": courseCode,
        "parentid": SessionProvider.parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('PayCourseError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*isLoading = true;
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
    }*/
  }

  Future<bool> removeCourse({
    required String childId,
    required String courseCode,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/course/removeCourse', {
        "childid": childId,
        "coursecode": courseCode,
        "parentid": SessionProvider.parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('RemoveCourseError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*isLoading = true;
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
    }*/
  }

  Future<bool> pickCourse(String childId, String courseCode) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/course/pickCourse', {
        "childid": childId,
        "coursecode": courseCode,
        "parentid": SessionProvider.parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('PickCourseError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*// Call API to register course
    // Remove course locally or reload list
    pickCourses.removeWhere((elt) => elt.code == courseCode);*/
  }
}
