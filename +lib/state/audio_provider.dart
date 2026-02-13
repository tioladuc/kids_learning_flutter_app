import 'package:flutter/material.dart';
import '../models/audio_item.dart';
import '../services/audio_service.dart';

class AudioProvider extends ChangeNotifier {
  List<AudioItem> audios = [];
  bool loading = false;

  ////////////////////////////////////////////
    static final List<AudioItem> sampleAudioItems = [
  AudioItem(
    id: '1',
    title: 'Morning Dictation',
    audioUrl: 'https://example.com/audio/morning_dictation.mp3',
    createdAt: DateTime(2026, 1, 10, 8, 30),
  ),
  AudioItem(
    id: '2',
    title: 'Alphabet Practice',
    audioUrl: 'https://example.com/audio/alphabet_practice.mp3',
    createdAt: DateTime(2026, 1, 12, 15, 45),
  ),
  AudioItem(
    id: '3',
    title: 'Spelling Test – Animals',
    audioUrl: 'https://example.com/audio/spelling_animals.mp3',
    createdAt: DateTime(2026, 1, 15, 10, 0),
  ),
  AudioItem(
    id: '4',
    title: 'Short Story Dictation',
    audioUrl: 'https://example.com/audio/short_story.mp3',
    createdAt: DateTime(2026, 1, 18, 18, 20),
  ),
];

    ///////////////////////////////////////////

  Future<void> loadAudios() async {
    loading = true;
    notifyListeners();

    

    audios = AudioProvider.sampleAudioItems; //await AudioService.fetchAudios();
    loading = false;
    notifyListeners();
  }

  Future<void> deleteAudio(String id) async {
    //await AudioService.deleteAudio(id);
    //audios.removeWhere((e) => e.id == id);
    print('duclair T');
    AudioProvider.sampleAudioItems.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
