import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_state.freezed.dart';
part 'audio_state.g.dart';

@freezed
class AudioState with _$AudioState {
  const factory AudioState({
    @Default(false) bool isLoading,
    @Default(false) bool isPlaying,
    @Default(1.0) double speed,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,
    @Default(Duration.zero) Duration duration,
    String? currentAudiobookId,
    @Default([]) List<String> queue,
  }) = _AudioState;

  factory AudioState.fromJson(Map<String, dynamic> json) => _$AudioStateFromJson(json);
}
