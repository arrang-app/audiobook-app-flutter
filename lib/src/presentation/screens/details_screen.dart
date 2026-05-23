import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/audiobook_model.dart';
import '../../providers/app_providers.dart';
import '../../services/storage/hive_service.dart';
import '../widgets/genre_chip.dart';
import '../widgets/mini_player.dart';

class DetailsScreen extends ConsumerWidget {
  const DetailsScreen({required this.audiobookId, super.key});

  final String audiobookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audiobookAsync = ref.watch(audiobookByIdProvider(audiobookId));
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: audiobookAsync.when(
        data: (book) {
          if (book == null) {
            return const Center(child: Text('Audiobook not found', style: TextStyle(color: Colors.white)));
          }
          return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Row(
                    children: [
                      IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                      const SizedBox(width: 8),
                      const Text('Details', style: TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 22)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      Hero(
                        tag: 'cover-${book.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: CachedNetworkImage(imageUrl: book.coverUrl, height: 320, width: double.infinity, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(book.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontFamily: 'Fredoka', fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(book.author, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 16)),
                      const SizedBox(height: 18),
                      Row(children: book.genres.map((genre) => Padding(padding: const EdgeInsets.only(right: 10), child: GenreChip(label: genre))).toList()),
                      const SizedBox(height: 18),
                      Text(book.description, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 15, height: 1.5)),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          _DetailTile(label: 'Duration', value: '${book.duration.inHours}h ${book.duration.inMinutes.remainder(60)}m'),
                          const SizedBox(width: 16),
                          _DetailTile(label: 'Rating', value: '${book.rating}'),
                        ],
                      ),
                      const SizedBox(height: 26),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(currentAudiobookProvider.notifier).state = book;
                          context.push('/player/${book.id}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF47051),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('Play Now', style: TextStyle(fontSize: 16)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                await HiveService.addToLibrary(book.id);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to library')));
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF383838)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                minimumSize: const Size.fromHeight(56),
                              ),
                              child: const Text('Add to library', style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1C),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: IconButton(
                              onPressed: () async {
                                await HiveService.toggleFavorite(book.id);
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Favorite toggled')));
                              },
                              icon: const Icon(Icons.favorite_outline, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF47051))),
        error: (error, stack) => Center(child: Text('Error loading audiobook', style: const TextStyle(color: Colors.white))),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(18)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 13)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
