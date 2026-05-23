// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_state.dart';

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.',
);

AudioState _$AudioStateFromJson(Map<String, dynamic> json) {
  return _AudioState.fromJson(json);
}

class _$AudioStateTearOff {
  const _$AudioStateTearOff();

  _AudioState call({
    bool isLoading = false,
    bool isPlaying = false,
    double speed = 1.0,
    Duration position = Duration.zero,
    Duration bufferedPosition = Duration.zero,
    Duration duration = Duration.zero,
    String? currentAudiobookId,
    List<String> queue = const [],
  }) {
    return _AudioState(
      isLoading: isLoading,
      isPlaying: isPlaying,
      speed: speed,
      position: position,
      bufferedPosition: bufferedPosition,
      duration: duration,
      currentAudiobookId: currentAudiobookId,
      queue: queue,
    );
  }

  AudioState fromJson(Map<String, Object?> json) {
    return AudioState.fromJson(json);
  }
}

const $AudioState = _$AudioStateTearOff();

mixin _$AudioState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  double get speed => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get bufferedPosition => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get currentAudiobookId => throw _privateConstructorUsedError;
  List<String> get queue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioStateCopyWith<AudioState> get copyWith => throw _privateConstructorUsedError;
}

abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(AudioState value, $Res Function(AudioState) then) = _$AudioStateCopyWithImpl<$Res>;
  $Res call({
    bool isLoading,
    bool isPlaying,
    double speed,
    Duration position,
    Duration bufferedPosition,
    Duration duration,
    String? currentAudiobookId,
    List<String> queue,
  });
}

class _$AudioStateCopyWithImpl<$Res> implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  final AudioState _value;
  final $Res Function(AudioState) _then;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isPlaying = freezed,
    Object? speed = freezed,
    Object? position = freezed,
    Object? bufferedPosition = freezed,
    Object? duration = freezed,
    Object? currentAudiobookId = freezed,
    Object? queue = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      isPlaying: isPlaying == freezed ? _value.isPlaying : isPlaying as bool,
      speed: speed == freezed ? _value.speed : speed as double,
      position: position == freezed ? _value.position : position as Duration,
      bufferedPosition: bufferedPosition == freezed ? _value.bufferedPosition : bufferedPosition as Duration,
      duration: duration == freezed ? _value.duration : duration as Duration,
      currentAudiobookId: currentAudiobookId == freezed ? _value.currentAudiobookId : currentAudiobookId as String?,
      queue: queue == freezed ? _value.queue : queue as List<String>,
    ));
  }
}

abstract class _$AudioStateCopyWith<$Res> implements $AudioStateCopyWith<$Res> {
  factory _$AudioStateCopyWith(_AudioState value, $Res Function(_AudioState) then) = __$AudioStateCopyWithImpl<$Res>;
  @override
  $Res call({
    bool isLoading,
    bool isPlaying,
    double speed,
    Duration position,
    Duration bufferedPosition,
    Duration duration,
    String? currentAudiobookId,
    List<String> queue,
  });
}

class __$AudioStateCopyWithImpl<$Res> extends _$AudioStateCopyWithImpl<$Res> implements _$AudioStateCopyWith<$Res> {
  __$AudioStateCopyWithImpl(_AudioState _value, $Res Function(_AudioState) _then)
      : super(_value, (v) => _then(v as _AudioState));

  @override
  _AudioState get _value => super._value as _AudioState;

  @override
  $Res call({
    Object? isLoading = freezed,
    Object? isPlaying = freezed,
    Object? speed = freezed,
    Object? position = freezed,
    Object? bufferedPosition = freezed,
    Object? duration = freezed,
    Object? currentAudiobookId = freezed,
    Object? queue = freezed,
  }) {
    return _then(_AudioState(
      isLoading: isLoading == freezed ? _value.isLoading : isLoading as bool,
      isPlaying: isPlaying == freezed ? _value.isPlaying : isPlaying as bool,
      speed: speed == freezed ? _value.speed : speed as double,
      position: position == freezed ? _value.position : position as Duration,
      bufferedPosition: bufferedPosition == freezed ? _value.bufferedPosition : bufferedPosition as Duration,
      duration: duration == freezed ? _value.duration : duration as Duration,
      currentAudiobookId: currentAudiobookId == freezed ? _value.currentAudiobookId : currentAudiobookId as String?,
      queue: queue == freezed ? _value.queue : queue as List<String>,
    ));
  }
}

@JsonSerializable()
class _$_AudioState implements _AudioState {
  const _$_AudioState({
    this.isLoading = false,
    this.isPlaying = false,
    this.speed = 1.0,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.duration = Duration.zero,
    this.currentAudiobookId,
    this.queue = const [],
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final double speed;
  @override
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration position;
  @override
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration bufferedPosition;
  @override
  @JsonKey(fromJson: _durationFromJson, toJson: _durationToJson)
  final Duration duration;
  @override
  final String? currentAudiobookId;
  @override
  @JsonKey()
  final List<String> queue;

  factory _$_AudioState.fromJson(Map<String, dynamic> json) => _$$_AudioStateFromJson(json);

  @override
  String toString() {
    return 'AudioState(isLoading: $isLoading, isPlaying: $isPlaying, speed: $speed, position: $position, bufferedPosition: $bufferedPosition, duration: $duration, currentAudiobookId: $currentAudiobookId, queue: $queue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AudioState &&
            (identical(other.isLoading, isLoading) || other.isLoading == isLoading) &&
            (identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying) &&
            (identical(other.speed, speed) || other.speed == speed) &&
            (identical(other.position, position) || other.position == position) &&
            (identical(other.bufferedPosition, bufferedPosition) || other.bufferedPosition == bufferedPosition) &&
            (identical(other.duration, duration) || other.duration == duration) &&
            (identical(other.currentAudiobookId, currentAudiobookId) || other.currentAudiobookId == currentAudiobookId) &&
            const DeepCollectionEquality().equals(other.queue, queue));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        isLoading,
        isPlaying,
        speed,
        position,
        bufferedPosition,
        duration,
        currentAudiobookId,
        const DeepCollectionEquality().hash(queue),
      );

  @JsonKey(ignore: true)
  @override
  _$AudioStateCopyWith<_AudioState> get copyWith => __$AudioStateCopyWithImpl<_AudioState>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AudioStateToJson(this);
  }
}

abstract class _AudioState implements AudioState {
  const factory _AudioState({
    bool isLoading,
    bool isPlaying,
    double speed,
    Duration position,
    Duration bufferedPosition,
    Duration duration,
    String? currentAudiobookId,
    List<String> queue,
  }) = _$_AudioState;

  factory _AudioState.fromJson(Map<String, dynamic> json) = _$_AudioState.fromJson;

  @override
  bool get isLoading;
  @override
  bool get isPlaying;
  @override
  double get speed;
  @override
  Duration get position;
  @override
  Duration get bufferedPosition;
  @override
  Duration get duration;
  @override
  String? get currentAudiobookId;
  @override
  List<String> get queue;
  @override
  @JsonKey(ignore: true)
  _$AudioStateCopyWith<_AudioState> get copyWith;
}

Duration _durationFromJson(int seconds) => Duration(seconds: seconds);
int _durationToJson(Duration duration) => duration.inSeconds;
