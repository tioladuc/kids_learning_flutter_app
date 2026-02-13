import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/notify_data.dart';
import 'providers/session_provider.dart';
import 'providers/audio_provider.dart';

/*void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const KidsLearningApp(),
    ),
  );
}*/


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NotifyData(),
      child: MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ],
      child: const KidsLearningApp(),
    ),
    ),
  );
}