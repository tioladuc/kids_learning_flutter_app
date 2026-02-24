class Child {
  final String id;
  String name;
  final String login;
  String password;

  int? completedTasks;
  int? totalTasks;
  int? totalTimeMinutes;
  int? streakDays;
  int? age;

  bool? parentResponsible = false;

  Child(
      {required this.id,
      required this.name,
      required this.login,
      required this.password});

  static Child copy(Child child) {
    return Child(
        id: child.id,
        name: child.name,
        login: child.login,
        password: child.password);
  }
}
