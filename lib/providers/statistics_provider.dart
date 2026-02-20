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

  List<CourseStatistics> courseStatistics = [];

  Future<Child> getBasicInformation(Child child) async {
    isLoading = true;
    notifyListeners();
    
    // API CALL HERE

    isLoading = false;
    notifyListeners();
    Child childTmp = Child(id: child.id, name: child.name, login: child.login, password: child.password);
    childTmp.age = 100;
    childTmp.name = child.name;
    childTmp.completedTasks = 125;
    childTmp.streakDays = 546;
    childTmp.totalTasks = 458;
    childTmp.totalTimeMinutes = 745;  

    lastConnectionDuration = 'assad asd asdas dasd';
    lastConnectionTime = 'asdasd asd d asd';


    return childTmp;
  }

  

  Future<void> loadVisitedCourses(Child childId) async {
    isLoading = true;
    notifyListeners();

    // API call here

    // IMPORTANT: order by date (latest first or oldest first)
    visitedCourses = [
  VisitedCourse(
    Course(
      code: "FR101",
      name: "Basic French",
      amount: 49.99,
      expiryDate: DateTime(2026, 12, 31),
      validity: "1 year",
      isRegistered: true,
      description: "Learn basic French vocabulary and grammar.",
    ),
    120, // timeSpent in minutes
    DateTime(2026, 2, 15),
  ),

  VisitedCourse(
    Course(
      code: "EN201",
      name: "Intermediate English",
      amount: 59.99,
      expiryDate: DateTime(2026, 6, 30),
      validity: "6 months",
      isRegistered: true,
      description: "Improve your English speaking and writing skills.",
    ),
    85,
    DateTime(2026, 2, 18),
  ),

  VisitedCourse(
    Course(
      code: "MATH101",
      name: "Basic Mathematics",
      amount: 39.99,
      expiryDate: null, // no expiry
      validity: "lifetime",
      isRegistered: false,
      description: "Introduction to basic math concepts.",
    ),
    40,
    DateTime(2026, 1, 28),
  ),

  VisitedCourse(
    Course(
      code: "SCI301",
      name: "General Science",
      amount: 79.99,
      expiryDate: DateTime(2027, 1, 1),
      validity: "1 year",
      isRegistered: true,
      description: "Explore physics, chemistry, and biology basics.",
    ),
    200,
    DateTime(2026, 2, 10),
  ),

  VisitedCourse(
    Course(
      code: "HIST101",
      name: "World History",
      amount: 29.99,
      expiryDate: DateTime(2026, 9, 1),
      validity: "1 term",
      isRegistered: false,
      description: "Discover important events in world history.",
    ),
    60,
    DateTime(2026, 2, 5),
  ),
];

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadCompletedCourses(Child childId) async {
    isLoading = true;
    notifyListeners();

    // API call here

    // IMPORTANT: order by date (latest first or oldest first)
    completedCourses = [
  Course(
    code: "FR101",
    name: "Basic French",
    amount: 49.99,
    expiryDate: DateTime(2026, 12, 31),
    validity: "1 year",
    isRegistered: true,
    description: "Learn basic French vocabulary and grammar.",
  ),

  Course(
    code: "FR201",
    name: "Intermediate French",
    amount: 69.99,
    expiryDate: DateTime(2026, 6, 30),
    validity: "6 months",
    isRegistered: false,
    description: "Improve your French speaking and writing skills.",
  ),

  Course(
    code: "EN101",
    name: "Basic English",
    amount: 39.99,
    expiryDate: null, // lifetime access
    validity: "lifetime",
    isRegistered: true,
    description: "Introduction to English for beginners.",
  ),

  Course(
    code: "MATH101",
    name: "Basic Mathematics",
    amount: 29.99,
    expiryDate: DateTime(2026, 9, 1),
    validity: "1 term",
    isRegistered: false,
    description: "Understand numbers, operations, and simple problems.",
  ),

  Course(
    code: "SCI101",
    name: "General Science",
    amount: 59.99,
    expiryDate: DateTime(2027, 1, 1),
    validity: "1 year",
    isRegistered: true,
    description: "Explore physics, chemistry, and biology basics.",
  ),

  Course(
    code: "HIST101",
    name: "World History",
    amount: 24.99,
    expiryDate: DateTime(2026, 5, 15),
    validity: "1 term",
    isRegistered: false,
    description: "Learn about major historical events and civilizations.",
  ),

  Course(
    code: "COMP101",
    name: "Introduction to Computers",
    amount: 79.99,
    expiryDate: null,
    validity: "lifetime",
    isRegistered: true,
    description: "Basics of computers, internet, and digital tools.",
  ),

  Course(
    code: "ART101",
    name: "Creative Arts",
    amount: 34.99,
    expiryDate: DateTime(2026, 8, 20),
    validity: "6 months",
    isRegistered: false,
    description: "Express creativity through drawing and painting.",
  ),
];

    isLoading = false;
    notifyListeners();
  }

  Future<void> loadNeverDoneCourses(Child childId) async {
    isLoading = true;
    notifyListeners();

    // API call here

    // IMPORTANT: order by date (latest first or oldest first) neverDoneCourses
    neverDoneCourses = [
  NeverDoneCourse(
    Course(
      code: "FR301",
      name: "Advanced French",
      amount: 79.99,
      expiryDate: DateTime(2027, 1, 1),
      validity: "1 year",
      isRegistered: false,
      description: "Master advanced grammar and conversation in French.",
    ),
    DateTime(2026, 2, 10),
  ),

  NeverDoneCourse(
    Course(
      code: "EN301",
      name: "Advanced English",
      amount: 89.99,
      expiryDate: DateTime(2026, 12, 31),
      validity: "1 year",
      isRegistered: false,
      description: "Enhance fluency and professional communication skills.",
    ),
    DateTime(2026, 2, 12),
  ),

  NeverDoneCourse(
    Course(
      code: "MATH201",
      name: "Intermediate Mathematics",
      amount: 49.99,
      expiryDate: DateTime(2026, 9, 1),
      validity: "6 months",
      isRegistered: false,
      description: "Algebra, geometry, and problem-solving techniques.",
    ),
    DateTime(2026, 1, 25),
  ),

  NeverDoneCourse(
    Course(
      code: "SCI201",
      name: "Applied Science",
      amount: 69.99,
      expiryDate: null,
      validity: "lifetime",
      isRegistered: false,
      description: "Practical science experiments and applications.",
    ),
    DateTime(2026, 2, 5),
  ),

  NeverDoneCourse(
    Course(
      code: "COMP201",
      name: "Programming Basics",
      amount: 99.99,
      expiryDate: null,
      validity: "lifetime",
      isRegistered: false,
      description: "Learn programming fundamentals with simple projects.",
    ),
    DateTime(2026, 2, 18),
  ),

  NeverDoneCourse(
    Course(
      code: "ART201",
      name: "Digital Art",
      amount: 59.99,
      expiryDate: DateTime(2026, 11, 15),
      validity: "6 months",
      isRegistered: false,
      description: "Create digital illustrations and designs.",
    ),
    DateTime(2026, 1, 30),
  ),
];

    isLoading = false;
    notifyListeners();
  }

  

  Future<void> loadCourseStatistics(Child childId, Course courseId) async {
    isLoading = true;
    notifyListeners();

    // API call here

    // IMPORTANT: order by date (latest first or oldest first)
  courseStatistics = [
  CourseStatistics(
    startDate: DateTime(2026, 1, 10),
    endDate: DateTime(2026, 1, 20),
    duration: 10,
    detail: "Completed basic lessons with good consistency.",
    appreciation: "Good progress",
  ),

  CourseStatistics(
    startDate: DateTime(2026, 1, 25),
    endDate: DateTime(2026, 2, 5),
    duration: 11,
    detail: "Improved understanding of grammar and vocabulary.",
    appreciation: "Very good",
  ),

  CourseStatistics(
    startDate: DateTime(2026, 2, 1),
    endDate: DateTime(2026, 2, 10),
    duration: 9,
    detail: "Regular practice sessions, slight improvement needed in exercises.",
    appreciation: "Average",
  ),

  CourseStatistics(
    startDate: DateTime(2026, 2, 5),
    endDate: DateTime(2026, 2, 18),
    duration: 13,
    detail: "Excellent participation and task completion.",
    appreciation: "Excellent",
  ),

  CourseStatistics(
    startDate: DateTime(2026, 1, 15),
    endDate: DateTime(2026, 1, 30),
    duration: 15,
    detail: "Completed all modules with high accuracy.",
    appreciation: "Outstanding",
  ),

  CourseStatistics(
    startDate: DateTime(2026, 2, 10),
    endDate: DateTime(2026, 2, 19),
    duration: 9,
    detail: "Good engagement, but needs more revision on key topics.",
    appreciation: "Satisfactory",
  ),
];

    isLoading = false;
    notifyListeners();
  }
}
