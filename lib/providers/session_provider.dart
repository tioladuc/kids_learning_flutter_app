import '../core/api_client.dart';
import '../core/notify_data.dart';
import '../models/child.dart';
import '../models/news.dart';
import '../models/parent.dart';
import '../models/payment_model.dart';
import 'session_base.dart';

class SessionProvider extends SessionBase {
  String? role = null; // parent | child   NOT Used

  Child? tmpChild;
  Parent? tmpParent;
  bool get isLoggedIn => (role != null && (child != null || parent != null));

  List<News> latestNews = [];

  List<Child> children = [];
  bool isLoadingChildren = true;

  List<PaymentModel> paidPayments = [];
  List<PaymentModel> upcomingPayments = [];
  bool isLoadingPayments = false;

  static Child? child;
  static Parent? parent;

  bool isLoading = false;
  bool isActivationCodeSending = false;
  String? errorMessage;
  bool isLoginLoading = false;

  SessionProvider() {
    child = Child(
      id: 'child01',
      name: 'Child Main Principale',
      login: '01',
      password: '',
    );
    parent = Parent(
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

    tmpParent = Parent.copy(parent!);
    tmpChild = Child.copy(child!);
  }

  void setCurrentChildAsParent(Child? child) {
    parent!.currentChild = child;
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

  Future<bool> logout() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/logout', {
        "childid": child?.id,
        "parentid": parent?.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        role = null;
      } else {
        errorMessage = SessionBase.translator.getText('LogoutError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*role = null;
    notifyListeners();*/
  }

  //await Future.delayed(const Duration(seconds: 2));
  //errorMessage = SessionBase.translator.getText( selectedRole == NotifyData.ChoiceChild ? 'ChildLoginError' : 'ParentLoginError');
  //isLoginLoading = false;
  //notifyListeners();
  //return false;
  Future<bool> login(String selectedRole, String login, String pwd) async {
    isLoginLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/login', {
        "role": selectedRole,
        "login": login,
        "password": pwd,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        role = selectedRole;
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          selectedRole == NotifyData.ChoiceChild
              ? 'ChildLoginError'
              : 'ParentLoginError',
        );
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoginLoading = false;
      notifyListeners();
      return statusResponse;
    }
  }

  Future<bool> addChild(String login, String name, String pwd) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/addChild', {
        "name": name,
        "login": login,
        "password": pwd,
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        parent?.children.add(
          Child(
            id: DateTime.now().toString(),
            name: name,
            login: login,
            password: pwd,
          ),
        );
      } else {
        errorMessage = SessionBase.translator.getText('AddChildToParentError');
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

  Future<bool> deleteChild(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/deleteChild', {
        "childid": id,
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        parent?.children.removeWhere((c) => c.id == id);
      } else {
        errorMessage = SessionBase.translator.getText(
          'DeleteChildToParentError',
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

  Future<bool> changeParentPassword(
    String firstName,
    String lastName,
    String newPassword,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/changeParentPassword', {
        "firstname": firstName,
        "lastname": lastName,
        "newpassword": newPassword,
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        parent?.firstName = firstName;
        parent?.lastName = lastName;
        parent?.password = newPassword;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ChangeParentPasswordError',
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

  Future<bool> changeChildPassword(String name, String newPassword) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/changeChildPassword', {
        "name": name,
        "newpassword": newPassword,
        "childid": child?.id,
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        child?.name = name;
        child?.password = newPassword;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ChangePwdChildToParentError',
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

  Future<bool> changePasswordParentChild(
    String name,
    String newPassword,
    Child child,
  ) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response =
          await ApiClient.post('/account/changePasswordParentChild', {
            "name": name,
            "newpassword": newPassword,
            "childid": child.id,
            "parentid": parent!.id,
          });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
        parent?.children.firstWhere((element) => element.id == child.id).name =
            name;
        parent?.children
                .firstWhere((element) => element.id == child.id)
                .password =
            newPassword;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ChangePwdChildToParentError',
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

  ///////////////////////////////////////////////////////////////////

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

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/createParent', {
        "firstName": firstName,
        "lastName": lastName,
        "login": login,
        "password": password,
        "email": email,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('CreateParentError');
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

  /// ACTIVATE ACCOUNT
  Future<bool> activateParentAccount({
    required String email,
    required String code,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/activateParent', {
        "email": email,
        "code": code,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ActivateParentAccountError',
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

  /// RESEND ACTIVATION CODE ACCOUNT
  Future<bool> resendActivationCode({required String email}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/account/sendActivationCodeParent',
        {"email": email},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'SendActivationCodeParentError',
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

  /// SEND RESET CODE
  Future<bool> sendResetCode({required String email}) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/account/sendActivationCodeParent',
        {"email": email},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'SendActivationCodeParentError',
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
    required bool isResponsible,
    required Child child,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post(
        '/account/setParentAsResponsibleOfChild',
        {"parentid": parent!.id, "childid": child.id},
      );
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'SetParentAsResponsibleOfChildError',
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

  /// RESET PASSWORD
  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/resetParentPassword', {
        "parentid": parent!.id,
        "email": email,
        "code": code,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ResetParentPasswordError',
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

  ///////////////////////////////////////////////////////////////////
  Future<void> loadChildren() async {
    /*isLoadingChildren = true;
    await Future.delayed(const Duration(seconds: 2));
    children = parent?.children ?? [];

    isLoadingChildren = false;
    notifyListeners();*/
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/parentLoadChildren', {
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText(
          'ParentLoadChildrenError',
        );
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> getLatestNews() async {
    // fetch from API
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/getLatestNews', {
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('GetLatestNewsError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return;
    }

    /*latestNews = [
      News(
        title: "New Math Course Available",
        description:
            "We have added a new interactive math course for children aged 6-8.",
        date: DateTime(2026, 2, 20),
      ),
      News(
        title: "Platform Update",
        description:
            "A new design has been released to improve user experience.",
        date: DateTime(2026, 2, 18),
      ),
      News(
        title: "Parent Dashboard Improved",
        description:
            "Parents can now track their children's progress more easily.",
        date: DateTime(2026, 2, 15),
      ),
      News(
        title: "New Games Added",
        description:
            "Educational games have been added to make learning more fun.",
        date: DateTime(2026, 2, 10),
      ),
      News(
        title: "Bug Fixes",
        description: "We fixed several bugs to improve app stability.",
        date: DateTime(2026, 2, 5),
      ),
    ];
    notifyListeners();*/
  }

  Future<void> sendEmail({
    required String subject,
    required String category,
    required String content,
  }) async {
    // call backend or email service
  }

  Future<void> loadPayments() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/account/loadPayment', {
        "parentid": parent!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('LoadPaymentError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return;
    }
    /*isLoadingPayments = true;
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
    notifyListeners();*/
  }
}
