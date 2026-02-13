import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/constances.dart';
import '../core/notify_data.dart';
import '../models/audio_item.dart';
import '../providers/audio_provider.dart';
import '../screens/audio_player_screen.dart';

class AudioTile extends StatelessWidget {
  final AudioItem audio;

  const AudioTile({super.key, required this.audio});

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    
    return ListTile(
      title: Text(audio.title),
      leading: const Icon(Icons.play_circle),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (_) => AlertDialog(
              title: notifyData.currentLanguage == Constant.languageEN ?  Text(Constant.deleteAudioEN) : Text(Constant.deleteAudioFR),
              content: notifyData.currentLanguage == Constant.languageEN ?  Text(Constant.areYouSureAudioEN) : Text(Constant.areYouSureAudioFR),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: notifyData.currentLanguage == Constant.languageEN ?  Text(Constant.cancelEN) : Text(Constant.cancelFR)),
                TextButton(onPressed: () => Navigator.pop(context, true), child: notifyData.currentLanguage == Constant.languageEN ?  Text(Constant.deleteEN) : Text(Constant.deleteFR),),
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
          MaterialPageRoute(
            builder: (_) => AudioPlayerScreen(audio: audio),
          ),
        );
      },
    );
  }
}
