class AudioItem {
  final String id;
  final String title;
  final String audioUrl;
  final DateTime createdAt;

  AudioItem({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.createdAt,
  });

  factory AudioItem.fromJson(Map<String, dynamic> json) {
    return AudioItem(
      id: json['id'],
      title: json['title'],
      audioUrl: json['audio_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
