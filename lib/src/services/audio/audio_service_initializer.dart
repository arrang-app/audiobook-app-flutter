import 'package:audio_service/audio_service.dart';
import 'audio_handler_impl.dart';

Future<AudioHandler> initializeAudioService() async {
  return await AudioService.init(
    builder: () => AudioHandlerImpl(),
    config: AudioServiceConfig(
      androidNotificationChannelId: 'audiobook_playback',
      androidNotificationChannelName: 'Audiobook Playback',
      androidNotificationOngoing: true,
      androidNotificationIcon: 'mipmap/ic_launcher',
      androidStopForegroundOnPause: false,
    ),
  );
}
