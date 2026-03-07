import '../core/api_client.dart';
import '../models/child.dart';
import '../models/course.dart';
import '../models/course_statistics.dart';
import 'session_base.dart';

class StatisticsProvider extends SessionBase {
  bool isLoading = false;
  String? errorMessage;

  String? lastConnectionTime;
  String? lastConnectionDuration;

  List<VisitedCourse> visitedCourses = [];
  List<Course> completedCourses = [];
  List<NeverDoneCourse> neverDoneCourses = [];

  List<CourseStatistics> courseStatistics = [];

  Future<Child> getBasicInformation(Child child) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    Child statusResponse = Child(id: '', login: '', name: '', password: '');
    try {
      final response = await ApiClient.post('/statistics/getBasicInformation', {
        "childid": child.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        //statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'GetBasicInformationError',
        );
        //statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    
  }

  Future<bool> loadVisitedCourses(Child childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/statistics/loadVisitedCourses', {
        "childid": childId,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadVisitedCoursesError',
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
    
  }

  Future<bool> loadCompletedCourses(Child childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/statistics/loadCompletedCourses',
        {"childid": childId},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadCompletedCoursesError',
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
    
  }

  Future<bool> loadNeverDoneCourses(Child childId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/statistics/loadNeverDoneCourses',
        {"childid": childId},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadNeverDoneCoursesError',
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
    
  }

  Future<bool> loadCourseStatistics(Child childId, Course courseId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/statistics/loadCourseStatistics',
        {"childid": childId, "courseid": courseId},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'LoadCourseStatisticsError',
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
    
  }
}
