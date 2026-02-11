import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayControls extends StatelessWidget {
  final AudioPlayer player;

  const PlayControls({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (_, snapshot) {
            final playing = snapshot.data?.playing ?? false;
            return IconButton(
              iconSize: 64,
              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              onPressed: playing ? player.pause : player.play,
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () => player.seek(
                player.position - const Duration(seconds: 10),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: () => player.seek(
                player.position + const Duration(seconds: 10),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: player.stop,
            ),
          ],
        ),
      ],
    );
  }
}
