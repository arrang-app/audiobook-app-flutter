import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/audiobook_model.dart';
import '../data/repositories/audiobook_repository_impl.dart';
import '../domain/usecases/get_featured_audiobooks.dart';
import '../services/audio/audio_handler_impl.dart';
import '../providers/audio_state.dart';

final audiobookRepositoryProvider = Provider((ref) => AudiobookRepositoryImpl());

final audioHandlerProvider = Provider<AudioHandlerImpl>((ref) => throw UnimplementedError());

final featuredAudiobooksProvider = FutureProvider<List<AudiobookModel>>((ref) async {
  final repository = ref.read(audiobookRepositoryProvider);
  return GetFeaturedAudiobooks(repository)();
});

final audiobookByIdProvider = FutureProvider.family<AudiobookModel?, String>((ref, id) async {
  final repository = ref.read(audiobookRepositoryProvider);
  return repository.getAudiobookById(id);
});

final currentAudiobookProvider = StateProvider<AudiobookModel?>((ref) => null);

final searchQueryProvider = StateProvider<String>((ref) => '');

final audioStateProvider = StateNotifierProvider<AudioStateNotifier, AudioState>((ref) {
  final handler = ref.read(audioHandlerProvider);
  return AudioStateNotifier(handler);
});

class AudioStateNotifier extends StateNotifier<AudioState> {
  AudioStateNotifier(this._handler) : super(const AudioState()) {
    _listenToPlaybackEvents();
  }

  final AudioHandlerImpl _handler;
  Timer? _sleepTimer;
  StreamSubscription? _playbackSubscription;

  void _listenToPlaybackEvents() {
    _playbackSubscription = _handler.playbackState.listen((playbackState) {
      state = state.copyWith(
        isPlaying: playbackState.playing,
        position: playbackState.updatePosition,
        bufferedPosition: playbackState.bufferedPosition,
        speed: playbackState.speed,
      );
    });
  }

  Future<void> loadAudiobook(AudiobookModel audiobook) async {
    state = state.copyWith(isLoading: true, currentAudiobookId: audiobook.id);
    await _handler.loadAudiobook(audiobook);
    state = state.copyWith(duration: audiobook.duration, isLoading: false, isPlaying: true);
  }

  void play() => _handler.play();
  void pause() => _handler.pause();
  void seek(Duration position) => _handler.seek(position);
  void setSpeed(double speed) {
    _handler.setSpeed(speed);
    state = state.copyWith(speed: speed);
  }

  void updatePosition(Duration position, Duration buffered) {
    state = state.copyWith(position: position, bufferedPosition: buffered);
  }

  void startSleepTimer(Duration duration) {
    _sleepTimer?.cancel();
    _sleepTimer = Timer(duration, () {
      pause();
      state = state.copyWith(isPlaying: false);
    });
  }

  void cancelSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
  }

  @override
  void dispose() {
    _playbackSubscription?.cancel();
    _sleepTimer?.cancel();
    super.dispose();
  }

  void togglePlayPause() {
    if (state.isPlaying) {
      pause();
      state = state.copyWith(isPlaying: false);
    } else {
      play();
      state = state.copyWith(isPlaying: true);
    }
  }
}
