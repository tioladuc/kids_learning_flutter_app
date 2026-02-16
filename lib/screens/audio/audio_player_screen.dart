import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../core/constances.dart';
import '../../core/notify_data.dart';
import '../../models/audio_item.dart';
import '../../widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  final AudioItem audio;
  const AudioPlayerScreen({super.key, required this.audio});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = AudioPlayer();
  final double speedPace = 0.25;
  double currentSpeed = 1.0;
  int position = 0;

  @override
  void initState() {
    super.initState();
    player.setUrl(widget.audio.audioUrl);
    player.setSpeed(currentSpeed);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void setSpeed(bool increase) {
    setState(() {
      if (increase) {
        currentSpeed = currentSpeed < 4 ? (currentSpeed + speedPace) : 4.0;
        currentSpeed = currentSpeed < 4 ? currentSpeed : 4.0;
      } else {
        currentSpeed = 0 < currentSpeed ? (currentSpeed - speedPace) : 0;
        currentSpeed = currentSpeed < 0 ? 0 : currentSpeed;
      }
      player.setSpeed(currentSpeed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifyData = context.watch<NotifyData>();

    return AppScaffold(
      //appBar: const AppHeader(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {}, //context.read<SessionProvider>().login('child'),
            style: Constant.getTitle1ButtonStyle(),
            child: notifyData.currentLanguage == Constant.languageEN
                ? Text(Constant.readingAudioTitleEN)
                : Text(Constant.readingAudioTitleFR),
          ),
          const SizedBox(height: 24),

          Text(widget.audio.title, style: Constant.getTitleStyle()),
          const SizedBox(height: 5),
          Text(
            (notifyData.currentLanguage == Constant.languageEN
                    ? Constant.readingSpeedEN
                    : Constant.readingSpeedFR) +
                currentSpeed.toString(),
            style: Constant.getTextSimpleStyle(),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.keyboard_double_arrow_left,
                ), //keyboard_double_arrow_left
                onPressed: () => setSpeed(false),
              ),

              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () =>
                    player.seek(player.position - const Duration(seconds: 10)),
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  setState(() {
                    player.play();
                    position = 1;
                  });
                },
                style: position == 1
                    ? Constant.getButtonSimpleSelectedStyle()
                    : Constant.getButtonSimpleStyle(),
              ),
              IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  setState(() {
                    player.pause();
                    position = 2;
                  });
                },
                style: position == 2
                    ? Constant.getButtonSimpleSelectedStyle()
                    : Constant.getButtonSimpleStyle(),
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: () {
                  setState(() {
                    player.stop();
                    player.seek(const Duration(seconds: 0));
                    position = 3;
                  });
                },
                style: position == 3
                    ? Constant.getButtonSimpleSelectedStyle()
                    : Constant.getButtonSimpleStyle(),
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () =>
                    player.seek(player.position + const Duration(seconds: 10)),
              ),

              IconButton(
                icon: const Icon(
                  Icons.keyboard_double_arrow_right,
                ), //keyboard_double_arrow_right
                onPressed: () => setSpeed(true),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(widget.audio.description, style: Constant.getTextStyle()),
        ],
      ),
    );
  }
}
