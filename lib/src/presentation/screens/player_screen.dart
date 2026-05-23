import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_providers.dart';
import '../../data/models/audiobook_model.dart';
import '../widgets/waveform_player.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  const PlayerScreen({required this.audiobookId, super.key});

  final String audiobookId;

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bookAsync = ref.read(audiobookByIdProvider(widget.audiobookId));
      bookAsync.whenData((book) {
        if (book != null) {
          ref.read(currentAudiobookProvider.notifier).state = book;
          ref.read(audioStateProvider.notifier).loadAudiobook(book);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioState = ref.watch(audioStateProvider);
    final book = ref.watch(currentAudiobookProvider);

    if (book == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(color: Color(0xFFF47051))));
    }

    final progress = book.duration.inMilliseconds > 0
        ? audioState.position.inMilliseconds / book.duration.inMilliseconds
        : 0.0;
    final bufferedProgress = book.duration.inMilliseconds > 0
        ? audioState.bufferedPosition.inMilliseconds / book.duration.inMilliseconds
        : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              child: Row(
                children: [
                  IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white)),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  Hero(
                    tag: 'cover-${book.id}',
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 30, offset: const Offset(0, 18))],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(34),
                          child: CachedNetworkImage(imageUrl: book.coverUrl, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  Text(book.title, style: const TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(book.author, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 16)),
                  const SizedBox(height: 24),
                  Text('${_formatDuration(audioState.position)} / ${_formatDuration(book.duration)}', style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 14)),
                  const SizedBox(height: 12),
                  WaveformPlayer(
                    progress: progress,
                    buffered: bufferedProgress,
                    onSeek: (value) {
                      final seekPosition = Duration(milliseconds: (book.duration.inMilliseconds * value).round());
                      ref.read(audioStateProvider.notifier).seek(seekPosition);
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _ActionButton(icon: Icons.replay_10, label: 'Rewind', onTap: () => ref.read(audioStateProvider.notifier).seek(audioState.position - const Duration(seconds: 10))),
                      _ActionButton(icon: audioState.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded, label: audioState.isPlaying ? 'Pause' : 'Play', isPrimary: true, size: 76, onTap: () => ref.read(audioStateProvider.notifier).togglePlayPause()),
                      _ActionButton(icon: Icons.forward_10, label: 'Forward', onTap: () => ref.read(audioStateProvider.notifier).seek(audioState.position + const Duration(seconds: 10))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Chapters', style: TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 20)),
                  const SizedBox(height: 14),
                  ...book.chapters.map((chapter) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(chapter.title, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(_formatDuration(chapter.start), style: const TextStyle(color: Color(0xFFC6C6C6))),
                      trailing: const Icon(Icons.play_arrow_rounded, color: Color(0xFFF47051)),
                      onTap: () => ref.read(audioStateProvider.notifier).seek(chapter.start),
                    );
                  }).toList(),
                  const SizedBox(height: 24),
                  const Text('Playback Settings', style: TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 20)),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _SpeedChip(label: '0.75x', selected: audioState.speed == 0.75, onTap: () => ref.read(audioStateProvider.notifier).setSpeed(0.75)),
                      _SpeedChip(label: '1.0x', selected: audioState.speed == 1.0, onTap: () => ref.read(audioStateProvider.notifier).setSpeed(1.0)),
                      _SpeedChip(label: '1.25x', selected: audioState.speed == 1.25, onTap: () => ref.read(audioStateProvider.notifier).setSpeed(1.25)),
                      _SpeedChip(label: '1.5x', selected: audioState.speed == 1.5, onTap: () => ref.read(audioStateProvider.notifier).setSpeed(1.5)),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            ref.read(audioStateProvider.notifier).startSleepTimer(const Duration(minutes: 15));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sleep timer set for 15 minutes')));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF383838)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('Sleep Timer', style: TextStyle(color: Colors.white, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () => ref.read(audioStateProvider.notifier).cancelSleepTimer(),
                        icon: const Icon(Icons.timer_off, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 110),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '${duration.inHours}:$minutes:$seconds';
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap, this.isPrimary = false, this.size = 56});

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: isPrimary ? const Color(0xFFF47051) : const Color(0xFF121212),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: isPrimary ? 36 : 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 12)),
      ],
    );
  }
}

class _SpeedChip extends StatelessWidget {
  const _SpeedChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF47051) : const Color(0xFF171717),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}
