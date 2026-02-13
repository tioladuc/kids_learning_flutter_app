import 'package:flutter/material.dart';
import '../models/audio_item.dart';
import '../core/api_client.dart';

class AudioProvider extends ChangeNotifier {
  List<AudioItem> audios = [];

  Future<void> loadAudios() async {
    /*final data = await ApiClient.get('/selfdictation');
    audios = (data as List)
        .map((e) => AudioItem.fromJson(e))
        .toList();*/
        audios =
    sampleAudioJson.map((e) => AudioItem.fromJson(e)).toList();

    notifyListeners();
  }

  Future<void> deleteAudio(String id) async {
    //await ApiClient.delete('/selfdictation/$id');
    audios.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  final List<Map<String, dynamic>> sampleAudioJson = [
  {
    "id": "1",
    "title": "Alphabet Dictation",
    "audio_url": "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2001.ogg",
    "description": "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",    
  },
  {
    "id": "2",
    "title": "Numbers Practice",
    "audio_url": "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2014.ogg",
    "description": "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",
  },
  {
    "id": "3",
    "title": "Animals Vocabulary",
    "audio_url": "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2010.ogg",
    "description": "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",
  }
];

}
