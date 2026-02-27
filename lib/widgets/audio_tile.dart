import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constances.dart';
import '../core/core_translator.dart';
import '../core/notify_data.dart';
import '../models/audio_item.dart';
import '../providers/audio_provider.dart';
import '../screens/audio/audio_player_screen.dart';

class AudioTile extends StatelessWidget {
  final AudioItem audio;
  Translator translator = Translator();

  AudioTile({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    translator = Translator(
      status: StatusLangue.CONSTANCE_CONSTANCE,
      lang: notifyData.currentLanguage,
    );

    return ListTile(
      title: Text(audio.title),
      leading: const Icon(Icons.play_circle),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(translator.getText('deleteAudio')),
              content: Text(translator.getText('areYouSureAudio')),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(translator.getText('cancel')),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child:Text(translator.getText('delete')),
                ),
              ],
            ),
          );

          if (confirmed == true) {
            context.read<AudioProvider>().deleteAudio(audio.id);
          }
        },
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AudioPlayerScreen(audio: audio)),
        );
      },
    );
  }
}
