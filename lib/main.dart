import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/app.dart';
import 'src/services/audio/audio_handler_impl.dart';
import 'src/services/audio/audio_service_initializer.dart';
import 'src/services/notification/notification_service.dart';
import 'src/services/storage/hive_service.dart';
import 'src/providers/app_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.initialize();
  await NotificationService.initialize();
  final audioHandler = await initializeAudioService();
  runApp(ProviderScope(overrides: [audioHandlerProvider.overrideWithValue(audioHandler as AudioHandlerImpl)], child: const AudioBookApp()));
}
