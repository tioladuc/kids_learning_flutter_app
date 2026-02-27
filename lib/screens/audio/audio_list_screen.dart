import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constances.dart';
import '../../core/core_translator.dart';
import '../../core/notify_data.dart';
import '../../providers/audio_provider.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/audio_tile.dart';
import 'audio_record_screen.dart';

class AudioListScreen extends StatefulWidget {
  const AudioListScreen({super.key});

  @override
  State<AudioListScreen> createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  Translator translator = Translator();
  @override
  void initState() {
    super.initState();
    context.read<AudioProvider>().loadAudios();
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();
    translator = Translator(status: StatusLangue.CONSTANCE_CONSTANCE, lang: notifyData.currentLanguage);
    final audios = context.watch<AudioProvider>().audios;

    return AppScaffold(
      body: Column(
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: Constant.getTitle1ButtonStyle(),
                child: Text(translator.getText('listingAudioTitle')),
              ),
              const SizedBox(width: 24),
              IconButton(
                style: Constant.getButtonSimpleSelectedStyle(),
                icon: const Icon(Icons.mic),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecordAudioScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: audios.length,
              itemBuilder: (_, i) => AudioTile(audio: audios[i]),
            ),
          ),
        ],
      ),
    );
  }
}
