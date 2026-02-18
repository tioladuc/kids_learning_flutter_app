class Course {
  final String code;
  final String name;
  final double amount;
  final DateTime? expiryDate;
  final String validity; // "1 month", "1 year", "1 term"
  final bool isRegistered;
  final String description;

  Course({
    required this.code,
    required this.name,
    required this.amount,
    this.expiryDate,
    required this.validity,
    required this.isRegistered,
    required this.description,
  });
}
