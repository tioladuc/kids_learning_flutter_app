class AudioItem {
  final String id;
  final String title;
  final String audioUrl;
  final String description;

  AudioItem({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.description
  });

  factory AudioItem.fromJson(Map<String, dynamic> json) {
    return AudioItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      audioUrl: (json['base_url'] ?? '') + (json['audio_url'] ?? ''),
      description: json['description'] ?? '',
    );
  }
  /*factory AudioItem.fromJson(Map<String, dynamic> json) {
    return AudioItem(
      id: json['id'],
      title: json['title'],
      audioUrl: json['audio_url'],
      description: json['description'],
    );
  }

  factory AudioItem.fromJson(Map<String, dynamic> json) {
    return AudioItem(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      audioUrl: json['audio_path'] ?? '',
      description: json['description'] ?? '',
    );
  }*/
}
