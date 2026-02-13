import '../core/api_client.dart';
import '../models/audio_item.dart';

class AudioService {
  static Future<List<AudioItem>> fetchAudios() async {
    final res = await ApiClient.dio.get('/audios');

    return (res.data as List)
        .map((e) => AudioItem.fromJson(e))
        .toList();
  }

  static Future<void> deleteAudio(String id) async {
    await ApiClient.dio.delete('/audios/$id');
  }
}
