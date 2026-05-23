import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../screens/player_screen.dart';
import '../../providers/app_providers.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBook = ref.watch(currentAudiobookProvider);
    if (currentBook == null) return const SizedBox.shrink();
    final audioState = ref.watch(audioStateProvider);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => PlayerScreen(audiobookId: currentBook.id))),
      child: Container(
        height: 86,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: const BoxDecoration(
          color: Color(0xFF111111),
          border: Border(top: BorderSide(color: Color(0xFF232323), width: 1)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(currentBook.coverUrl, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(currentBook.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(currentBook.author, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 12)),
                ],
              ),
            ),
            IconButton(
              onPressed: () => ref.read(audioStateProvider.notifier).togglePlayPause(),
              icon: Icon(audioState.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
