import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import '../../data/models/audiobook_model.dart';

class AudioHandlerImpl extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();
  final List<MediaItem> _queue = [];

  AudioHandlerImpl() {
    _initialize();
  }

  Future<void> _initialize() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.duckOthers,
      avAudioSessionMode: AVAudioSessionMode.defaultMode,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    ));

    _player.playbackEventStream.listen(_broadcastState);

    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        pause();
      } else {
        if (event.type == AudioInterruptionType.pause) {
          play();
        }
      }
    });

  }

  Future<void> loadAudiobook(AudiobookModel audiobook) async {
    final currentMediaItem = MediaItem(
      id: audiobook.id,
      album: audiobook.author,
      title: audiobook.title,
      artUri: Uri.tryParse(audiobook.coverUrl),
      duration: audiobook.duration,
      extras: {
        'description': audiobook.description,
        'genres': audiobook.genres,
      },
    );

    _queue.clear();
    _queue.add(currentMediaItem);
    queue.add(_queue);
    mediaItem.add(currentMediaItem);

    await _player.setAudioSource(AudioSource.uri(Uri.parse(audiobook.audioUrl)));
    await _player.play();
  }

  Future<void> play() => _player.play();

  Future<void> pause() => _player.pause();

  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setSpeed(double speed) => _player.setSpeed(speed);

  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() async {
    await _player.seekToNext();
  }

  @override
  Future<void> skipToPrevious() async {
    await _player.seekToPrevious();
  }

  @override
  Future<void> fastForward() async {
    await seek(_player.position + const Duration(seconds: 15));
  }

  @override
  Future<void> rewind() async {
    await seek(_player.position - const Duration(seconds: 15));
  }

  void addQueue(MediaItem item) {
    _queue.add(item);
    queue.add(_queue);
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          if (_player.playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {MediaAction.seek, MediaAction.seekForward, MediaAction.seekBackward},
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState] ?? AudioProcessingState.idle,
        playing: _player.playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
      ),
    );
  }

  @override
  Future<void> onTaskRemoved() async {
    await stop();
    return super.onTaskRemoved();
  }
}
