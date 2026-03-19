class Child {
  final String id;
  String name;
  final String login;
  String password;
  String passwordraw;

  int? completedTasks;
  int? totalTasks;
  int? totalTimeMinutes;
  int? streakDays;
  int? age;

  bool? parentResponsible = false;

  Child({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    required this.passwordraw,
    this.parentResponsible,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json["id"],
      name: json["name"],
      login: json["login"],
      password: json["password"],
      passwordraw: json["passwordraw"],
      parentResponsible: json["parent_responsible"] == 1,
    );
  }

  static Child copy(Child child) {
    return Child(
      id: child.id,
      name: child.name,
      login: child.login,
      password: child.password,
      passwordraw: child.passwordraw,
      parentResponsible: child.parentResponsible,
    );
  }
}