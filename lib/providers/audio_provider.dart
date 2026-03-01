import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import '../core/api_client.dart';
import '../models/audio_item.dart';
import 'package:http/http.dart' as http;

import 'session_base.dart';
import 'session_provider.dart';

class AudioProvider extends SessionBase {
  List<AudioItem> audios = [];
  bool isLoading = false;
  String? errorMessage = null;

  Future<bool> loadAudios() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/audio/loadAudios', {
        "childid": SessionProvider.child!.id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('LoadAudiosError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*audios = sampleAudioJson.map((e) => AudioItem.fromJson(e)).toList();

    notifyListeners();*/
  }

  Future<bool> addAudio({
    required String title,
    required String description,
    required String filePath,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/audio/addAudio', {
        "childid": SessionProvider.child!.id,
        "title": title,
        "description": description,
        "filePath": filePath,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('addAudioError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*final newItem = AudioItem(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      audioUrl: filePath,
    );

    audios.add(newItem);
    notifyListeners();*/
  }

  Future<bool> addAndUploadAudio({
    required String title,
    required String description,
    required String filePath,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/audio/addAndUploadAudio', {
        "childid": SessionProvider.child!.id,
        "title": title,
        "description": description,
        "filePath": filePath,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('AddAndUploadAudioError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*final file = File(filePath);
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
    }*/
  }

  Future<bool> deleteAudio(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/audio/deleteAudio', {
        "childid": SessionProvider.child!.id,
        "audioid": id,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('DeleteAudioError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*//await ApiClient.delete('/selfdictation/$id');
    audios.removeWhere((a) => a.id == id);
    notifyListeners();*/
  }

  Future<bool> uploadBytesAudio({
    required String title,
    required String description,
    required Uint8List audioBytes,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    bool statusResponse = false;
    try {
      final response = await ApiClient.post('/audio/uploadBytesAudio', {
        "childid": SessionProvider.child!.id,
        "title": title,
        "description": description,
        "audioBytes": audioBytes,
      });
      //Map<String, dynamic> response = {'success': true,};

      // ✅ Example: handle response
      if (response['success'] == true) {
        statusResponse = true;
      } else {
        errorMessage = SessionBase.translator.getText('UploadBytesAudioError');
        statusResponse = false;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
      return statusResponse;
    }
    /*AudioItem audio = AudioItem(
      id: DateTime.now().toString(),
      title: title,
      audioUrl: '',
      description: description,
    );
    audios.add(audio);
    notifyListeners();
    return;

    String baseUrl = '';
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/selfdictation'),
    );

    request.fields['title'] = title;
    request.fields['description'] = description;

    request.files.add(
      http.MultipartFile.fromBytes('file', audioBytes, filename: 'audio.aac'),
    );

    final response = await request.send();

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Upload failed');
    }*/
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
