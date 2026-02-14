import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../models/audio_item.dart';
import '../core/api_client.dart';
import 'package:http/http.dart' as http;

class AudioProvider extends ChangeNotifier {
  List<AudioItem> audios = [];

  Future<void> loadAudios() async {
    /*final data = await ApiClient.get('/selfdictation');
    audios = (data as List)
        .map((e) => AudioItem.fromJson(e))
        .toList();*/
    audios = sampleAudioJson.map((e) => AudioItem.fromJson(e)).toList();

    notifyListeners();
  }

  void addAudio({
    required String title,
    required String description,
    required String filePath,
  }) {
    final newItem = AudioItem(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      audioUrl: filePath,
    );

    audios.add(newItem);
    notifyListeners();
  }

  Future<void> addAndUploadAudio({
    required String title,
    required String description,
    required String filePath,
  }) async {
    final file = File(filePath);
    final String baseUrl = 'http://127.0.0.1:8000';

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/selfdictation'),
    );

    request.fields['title'] = title;
    request.fields['description'] = description;

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    final response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final data = json.decode(responseBody);

      final newItem = AudioItem.fromJson(data);

      audios.add(newItem);
      notifyListeners();
    } else {
      throw Exception('Upload failed');
    }
  }

  Future<void> deleteAudio(String id) async {
    //await ApiClient.delete('/selfdictation/$id');
    audios.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  Future<void> uploadBytesAudio({
  required String title,
  required String description,
  required Uint8List audioBytes,
}) async {
  String baseUrl = '';
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('$baseUrl/selfdictation'),
  );

  request.fields['title'] = title;
  request.fields['description'] = description;

  request.files.add(
    http.MultipartFile.fromBytes(
      'file',
      audioBytes,
      filename: 'audio.aac',
    ),
  );

  final response = await request.send();

  if (response.statusCode != 200 && response.statusCode != 201) {
    throw Exception('Upload failed');
  }
}



  final List<Map<String, dynamic>> sampleAudioJson = [
    {
      "id": "1",
      "title": "Alphabet Dictation",
      "audio_url":
          "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2001.ogg",
      "description":
          "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",
    },
    {
      "id": "2",
      "title": "Numbers Practice",
      "audio_url":
          "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2014.ogg",
      "description":
          "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",
    },
    {
      "id": "3",
      "title": "Animals Vocabulary",
      "audio_url":
          "https://yehoshoualevivant.com/perso/audio/Angela/Liste%2010.ogg",
      "description":
          "Mp3juice accessing our favorite tunes effortlessly is a luxury we cherish. Among the myriad of platforms offering music downloads, MP3 Juice - MP3Juice Free MP3 Downloads stands out as a beacon of convenience and accessibility. Let's delve into the realm of MP3 Juice, exploring its features, impact, and the controversies that often accompany such platforms.",
    },
  ];
}
