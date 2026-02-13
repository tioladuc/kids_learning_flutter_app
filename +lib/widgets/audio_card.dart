import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/audio_item.dart';
import '../screens/audio_player_screen.dart';
import '../state/audio_provider.dart';
import 'confirm_dialog.dart';

class AudioCard extends StatelessWidget {
  final AudioItem item;

  const AudioCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        title: Text(item.title),
        subtitle: Text(item.createdAt.toString()),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () async {
            final confirm = await showConfirmDialog(context);
            if (confirm) {
              context.read<AudioProvider>().deleteAudio(item.id);
            }
          },
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AudioPlayerScreen(item: item),
            ),
          );
        },
      ),
    );
  }
}
