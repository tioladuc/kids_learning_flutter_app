class PaymentModel {
  final double amount;
  final String courseName;
  final String childName;
  final DateTime date;
  final bool isPaid;

  PaymentModel({
    required this.amount,
    required this.courseName,
    required this.childName,
    required this.date,
    required this.isPaid,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      amount: (json['amount'] ?? 0).toDouble(),
      courseName: json['courseName'] ?? '',
      childName: json['childName'] ?? '',
      date: DateTime.parse(json['date']),
      isPaid: json['isPaid'] ?? false,
    );
  }
}