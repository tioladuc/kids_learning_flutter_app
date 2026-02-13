import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../models/audio_item.dart';
import '../widgets/play_controls.dart';

class AudioPlayerScreen extends StatefulWidget {
  final AudioItem item;

  const AudioPlayerScreen({super.key, required this.item});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player.setUrl(widget.item.audioUrl);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item.title)),
      body: Center(
        child: PlayControls(player: player),
      ),
    );
  }
}
