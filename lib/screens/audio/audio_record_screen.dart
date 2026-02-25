import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:just_audio/just_audio.dart' hide AudioSource;
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../providers/audio_provider.dart';
import '../../widgets/app_scaffold.dart';

class RecordAudioScreen extends StatefulWidget {
  const RecordAudioScreen({super.key});

  @override
  State<RecordAudioScreen> createState() => _RecordAudioScreenState();
}

class _RecordAudioScreenState extends State<RecordAudioScreen> {
  final _recorder = FlutterSoundRecorder();
  final _player = AudioPlayer();

  late StreamController<Uint8List> _streamController;
  Uint8List? _audioBytes;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isUploading = false;

  String? _filePath; // mobile only

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initRecorder();

    _streamController = StreamController<Uint8List>();

    _streamController.stream.listen((data) {
      _audioBytes = data;
    });

    _player.positionStream.listen((pos) {
      setState(() => _position = pos);
    });

    _player.durationStream.listen((dur) {
      if (dur != null) setState(() => _duration = dur);
    });
  }

  Future<bool> requestMicPermission() async {
    var status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
  }

  // 🎤 START
  Future<void> _startRecording() async {
    bool hasPermission = await requestMicPermission();
    if (!hasPermission) {
      print("Microphone permission denied");
      return;
    }

    await _recorder.openRecorder();
    Codec codec = kIsWeb ? Codec.opusWebM : Codec.aacADTS;
    await _recorder.startRecorder(
      codec: codec,
      toFile: 'audio.${kIsWeb ? 'webm' : 'aac'}',
    );

    setState(() {
      _isRecording = true;
    });
  }

  // ⏹ STOP
  Future<void> _stopRecording() async {
    String? path = await _recorder.stopRecorder();
    print(path);
    if (path != null) {
      _filePath = path;

      if (kIsWeb) {
        await _player.setUrl(path); // for blob URLs
      } else {
        await _player.setFilePath(path); // for mobile
      }
    }

    setState(() {
      _isRecording = false;
    });
  }

  // ▶️ PLAY
  Future<void> _togglePlay() async {
    if (_isPlaying) {
      setState(() => _isPlaying = false);
      await _player.pause();
    } else {
      setState(() => _isPlaying = true);
      await _player.play();
    }
  }

  // 🔄 RE-RECORD
  void _reRecord() async {
    await _player.stop();

    setState(() {
      _audioBytes = null;
      _filePath = null;
      _duration = Duration.zero;
      _position = Duration.zero;
    });
  }

  // 💾 SAVE + UPLOAD
  Future<void> _save(NotifyData notifyData) async {
    setState(() => _isUploading = true);

    try {
      //ToDo
      String data = "Hello, world!";
      List<int> encodedData = utf8.encode(data);
      Uint8List bytes = Uint8List.fromList(encodedData);

      await Provider.of<AudioProvider>(context, listen: false).uploadBytesAudio(
        title: _titleController.text,
        description: _descriptionController.text,
        audioBytes: bytes,
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text(notifyData.currentLanguage == Constant.languageEN
              ? Constant.UploadFailedEN
              : Constant.UploadFailedFR)));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  // ⏱ FORMAT
  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$m:$s";
  }

  @override
  void dispose() {
    _streamController.close();

    _recorder.closeRecorder();
    _player.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      //appBar: AppBar(title: const Text('Record Audio')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: Constant.getTitle1ButtonStyle(),
              child: notifyData.currentLanguage == Constant.languageEN
                  ? Text(Constant.recordMainTitleEN)
                  : Text(Constant.recordMainTitleFR),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? Constant.recordTitleEN
                    : Constant.recordTitleFR,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: notifyData.currentLanguage == Constant.languageEN
                    ? Constant.recordDescriptionEN
                    : Constant.recordDescriptionFR,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              label: Text(
                _isRecording
                    ? (notifyData.currentLanguage == Constant.languageEN
                        ? Constant.recordStopEN
                        : Constant.recordStopFR)
                    : (notifyData.currentLanguage == Constant.languageEN
                        ? Constant.recordStartEN
                        : Constant.recordStartFR),
              ),
            ),
            const SizedBox(height: 24),
            if (_filePath != null)
              Column(
                children: [
                  Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds
                        .clamp(0, _duration.inSeconds)
                        .toDouble(),
                    onChanged: (value) {
                      _player.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_format(_position)),
                      Text(_format(_duration)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: _togglePlay,
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed: _reRecord,
                      ),
                    ],
                  ),
                ],
              ),
            const Spacer(),
            ElevatedButton(
              style: Constant.getTitle3ButtonStyle(),
              onPressed: () {
                _isUploading ? null : _save(notifyData);
              },
              child: _isUploading
                  ? const CircularProgressIndicator()
                  : Text(
                      notifyData.currentLanguage == Constant.languageEN
                          ? Constant.recordSaveAndUploadEN
                          : Constant.recordSaveAndUploadFR,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
