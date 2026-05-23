// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_state.dart';

_$_AudioState _$$_AudioStateFromJson(Map<String, dynamic> json) => _$_AudioState(
      isLoading: json['isLoading'] as bool? ?? false,
      isPlaying: json['isPlaying'] as bool? ?? false,
      speed: (json['speed'] as num?)?.toDouble() ?? 1.0,
      position: _durationFromJson(json['position'] as int? ?? 0),
      bufferedPosition: _durationFromJson(json['bufferedPosition'] as int? ?? 0),
      duration: _durationFromJson(json['duration'] as int? ?? 0),
      currentAudiobookId: json['currentAudiobookId'] as String?,
      queue: (json['queue'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
    );

Map<String, dynamic> _$$_AudioStateToJson(_$_AudioState instance) => <String, dynamic>{
      'isLoading': instance.isLoading,
      'isPlaying': instance.isPlaying,
      'speed': instance.speed,
      'position': _durationToJson(instance.position),
      'bufferedPosition': _durationToJson(instance.bufferedPosition),
      'duration': _durationToJson(instance.duration),
      'currentAudiobookId': instance.currentAudiobookId,
      'queue': instance.queue,
    };

