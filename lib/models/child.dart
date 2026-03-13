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

  Child({
    required this.id,
    required this.name,
    required this.login,
    required this.password,
    this.parentResponsible,
  });

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json["id"],
      name: json["name"],
      login: json["login"],
      password: json["password"],
      parentResponsible: json["parent_responsible"] == 1,
    );
  }

  static Child copy(Child child) {
    return Child(
      id: child.id,
      name: child.name,
      login: child.login,
      password: child.password,
      parentResponsible: child.parentResponsible,
    );
  }
}