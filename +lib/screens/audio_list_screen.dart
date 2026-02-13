import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/audio_provider.dart';
import '../widgets/audio_card.dart';

class AudioListScreen extends StatelessWidget {
  const AudioListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AudioProvider>();

    if (provider.audios.isEmpty && !provider.loading) {
      provider.loadAudios();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Audio List')),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: provider.audios.length,
        itemBuilder: (_, i) => AudioCard(item: provider.audios[i]),
      ),
    );
  }
}
