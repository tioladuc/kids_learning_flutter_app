import 'package:flutter/material.dart';

import '../models/child.dart';
import '../models/news.dart';
import '../models/parent.dart';
import '../models/payment_model.dart';

class SessionProvider extends ChangeNotifier {
  String? role = null; // parent | child   NOT Used

  Child? child = Child(
    id: 'child01',
    name: 'Child Main Principale',
    login: '01',
    password: '',
  );
  Parent? parent = Parent(
    id: 'parent',
    name: 'Parent Main Principale',
    login: '11',
    password: '',
    children: [
      Child(id: 'child01', name: 'Child Other 01', login: '01', password: ''),
      Child(id: 'child02', name: 'Child Other 02', login: '02', password: ''),
      Child(id: 'child03', name: 'Child Other 03', login: '03', password: ''),
      Child(id: 'child04', name: 'Child Other 04', login: '04', password: ''),
      Child(id: 'child05', name: 'Child Other 05', login: '05', password: ''),
      Child(id: 'child06', name: 'Child Other 06', login: '06', password: ''),
    ],
  );

  SessionProvider() {
    tmpParent = Parent.copy(parent!);
    tmpChild = Child.copy(child!);
  }
  Child? tmpChild;
  Parent? tmpParent;
  bool get isLoggedIn => role != null;

  List<News> latestNews = [];

  List<Child> children = [];
  bool isLoadingChildren = false;

  List<PaymentModel> paidPayments = [];
  List<PaymentModel> upcomingPayments = [];
  bool isLoadingPayments = false;

  Future<void> loadChildren() async{
    children = parent?.children??[];
  }

  void setCurrentChildAsParent(Child? child) {
    parent!.currentChild = child;
    notifyListeners();
  }

  void login(String selectedRole) {
    role = selectedRole;
    notifyListeners();
  }

  void setRole(String? currentRole) {
    role = currentRole;
    notifyListeners();
  }

  void setParent(Parent? value) {
    parent = value;
    notifyListeners();
  }

  void setChild(Child? value) {
    child = value;
    notifyListeners();
  }

  void logout() {
    role = null;
    notifyListeners();
  }

  void addChild(String login, String name, String password) {
    parent?.children.add(
      Child(
        id: DateTime.now().toString(),
        name: name,
        login: login,
        password: password,
      ),
    );
    notifyListeners();
  }

  void deleteChild(String id) {
    parent?.children.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void changeParentPassword(String name, String newPassword) {
    parent?.name = name;
    parent?.password = newPassword;
    // TODO: call API
    print("Password changed: $newPassword");
    notifyListeners();
  }

  void changeChildPassword(String name, String newPassword) {
    child?.name = name;
    child?.password = newPassword;
    // TODO: call API
    print("Password changed: $newPassword");
    notifyListeners();
  }

  void changePasswordParentChild(String name, String newPassword, Child child) {
    // TODO: call API
    parent?.children.firstWhere((element) => element.id == child.id).name =
        name;
    parent?.children.firstWhere((element) => element.id == child.id).password =
        newPassword;
    print("Password changed: $newPassword");
    notifyListeners();
  }

  ///////////////////////////////////////////////////////////////////

  bool isLoading = false;
  bool isActivationCodeSending = false;
  String? errorMessage;

  /// CREATE ACCOUNT
  Future<bool> createParentAccount({
    required String firstName,
    required String lastName,
    required String login,
    required String password,
    required String email,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with your API call
      await Future.delayed(const Duration(seconds: 2));

      // Example success
      return true;
    } catch (e) {
      errorMessage = "Failed to create account";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// ACTIVATE ACCOUNT
  Future<bool> activateParentAccount({
    required String email,
    required String code,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with your API call
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (e) {
      errorMessage = "Invalid activation code";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// RESEND ACTIVATION CODE ACCOUNT
  Future<bool> resendActivationCode({
    required String email
  }) async {
    
    isActivationCodeSending = true;
    errorMessage = null;
    notifyListeners();

    try {
      // TODO: Replace with your API call
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (e) {
      errorMessage = "Invalid activation code";
      return false;
    } finally {
      isActivationCodeSending = false;
      notifyListeners();
    }
  }

  /// SEND RESET CODE
  Future<bool> sendResetCode({required String email}) async {
    _start();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (e) {
      errorMessage = "Failed to send reset code";
      return false;
    } finally {
      _end();
    }
  }

  void _start() {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
  }

  void _end() {
    isLoading = false;
    notifyListeners();
  }

  /// RESET PASSWORD
  Future<bool> setParentAsReponsibleOfChild({
    required bool isResponsible, required Child child
  }) async {
    _start();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 2));
      parent?.children.firstWhere((element) => element.id == child.id).parentResponsible = isResponsible;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = "Invalid code or password";
      return false;
    } finally {
      _end();
    }
  }
  /// RESET PASSWORD
  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    _start();

    try {
      // TODO: API call
      await Future.delayed(const Duration(seconds: 2));

      return true;
    } catch (e) {
      errorMessage = "Invalid code or password";
      return false;
    } finally {
      _end();
    }
  }
  ///////////////////////////////////////////////////////////////////
  Future<void> getLatestNews() async {
    // fetch from API
    latestNews = [
  News(
    title: "New Math Course Available",
    description: "We have added a new interactive math course for children aged 6-8.",
    date: DateTime(2026, 2, 20),
  ),
  News(
    title: "Platform Update",
    description: "A new design has been released to improve user experience.",
    date: DateTime(2026, 2, 18),
  ),
  News(
    title: "Parent Dashboard Improved",
    description: "Parents can now track their children's progress more easily.",
    date: DateTime(2026, 2, 15),
  ),
  News(
    title: "New Games Added",
    description: "Educational games have been added to make learning more fun.",
    date: DateTime(2026, 2, 10),
  ),
  News(
    title: "Bug Fixes",
    description: "We fixed several bugs to improve app stability.",
    date: DateTime(2026, 2, 5),
  ),
];
    notifyListeners();
  }

  Future<void> sendEmail({
    required String subject,
    required String category,
    required String content,
  }) async {
    // call backend or email service
  }

  Future<void> loadPayments() async {
  isLoadingPayments = true;
  notifyListeners();

  // simulate API
  await Future.delayed(const Duration(seconds: 1));
  paidPayments = [
  PaymentModel(
    amount: 50,
    courseName: "Mathematics Level 1",
    childName: "Alice",
    date: DateTime(2026, 2, 10),
    isPaid: true,
  ),
  PaymentModel(
    amount: 40,
    courseName: "Reading Basics",
    childName: "Alice",
    date: DateTime(2026, 2, 5),
    isPaid: true,
  ),
  PaymentModel(
    amount: 60,
    courseName: "Science Discovery",
    childName: "Bob",
    date: DateTime(2026, 1, 28),
    isPaid: true,
  ),
  PaymentModel(
    amount: 30,
    courseName: "Drawing for Kids",
    childName: "Emma",
    date: DateTime(2026, 1, 20),
    isPaid: true,
  ),
  PaymentModel(
    amount: 45,
    courseName: "English Level 1",
    childName: "Noah",
    date: DateTime(2026, 1, 15),
    isPaid: true,
  ),
  PaymentModel(
    amount: 55,
    courseName: "Mathematics Level 2",
    childName: "Alice",
    date: DateTime(2026, 1, 10),
    isPaid: true,
  ),
  PaymentModel(
    amount: 35,
    courseName: "Basic Coding",
    childName: "Lucas",
    date: DateTime(2026, 1, 5),
    isPaid: true,
  ),
  PaymentModel(
    amount: 25,
    courseName: "Music Fundamentals",
    childName: "Emma",
    date: DateTime(2025, 12, 20),
    isPaid: true,
  ),
];

upcomingPayments = [
  PaymentModel(
    amount: 75,
    courseName: "English Level 2",
    childName: "Bob",
    date: DateTime(2026, 3, 1),
    isPaid: false,
  ),
  PaymentModel(
    amount: 50,
    courseName: "Mathematics Level 2",
    childName: "Alice",
    date: DateTime(2026, 3, 5),
    isPaid: false,
  ),
  PaymentModel(
    amount: 40,
    courseName: "Reading Advanced",
    childName: "Emma",
    date: DateTime(2026, 3, 8),
    isPaid: false,
  ),
  PaymentModel(
    amount: 65,
    courseName: "Science Experiments",
    childName: "Lucas",
    date: DateTime(2026, 3, 12),
    isPaid: false,
  ),
  PaymentModel(
    amount: 30,
    courseName: "Art & Creativity",
    childName: "Noah",
    date: DateTime(2026, 3, 15),
    isPaid: false,
  ),
  PaymentModel(
    amount: 55,
    courseName: "Coding for Kids",
    childName: "Lucas",
    date: DateTime(2026, 3, 18),
    isPaid: false,
  ),
  PaymentModel(
    amount: 45,
    courseName: "English Conversation",
    childName: "Alice",
    date: DateTime(2026, 3, 20),
    isPaid: false,
  ),
  PaymentModel(
    amount: 35,
    courseName: "Music Practice",
    childName: "Emma",
    date: DateTime(2026, 3, 25),
    isPaid: false,
  ),
];

  isLoadingPayments = false;
  notifyListeners();
}
}
