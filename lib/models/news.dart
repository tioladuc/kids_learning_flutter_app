class News {
  final String title;
  final String description;
  final DateTime date;

  News({
    required this.title,
    required this.description,
    required this.date,
  });

  /// Convert from JSON (API)
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      date: DateTime.parse(json['date']),
    );
  }

  /// Convert to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
    };
  }
}