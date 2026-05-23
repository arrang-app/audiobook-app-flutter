import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/audiobook_model.dart';
import '../../providers/app_providers.dart';
import '../widgets/audiobook_card.dart';
import '../widgets/mini_player.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredAudiobooksProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: featuredAsync.when(
          data: (books) {
            final favorites = books.where((book) => book.isFavorite).toList();
            final downloads = books.where((book) => book.isDownloaded).toList();
            final recent = books.take(2).toList();
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              children: [
                const Text('Library', style: TextStyle(color: Colors.white, fontFamily: 'Fredoka', fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _SectionCard(title: 'Recently Played', subtitle: 'Resume from where you left off', items: recent, onTap: (book) => context.push('/player/${book.id}')),
                const SizedBox(height: 16),
                _SectionCard(title: 'Downloaded', subtitle: 'Available offline', items: downloads, onTap: (book) => context.push('/player/${book.id}')),
                const SizedBox(height: 16),
                _SectionCard(title: 'Favorites', subtitle: 'Your wishlist and favorites', items: favorites, onTap: (book) => context.push('/details/${book.id}')),
                const SizedBox(height: 120),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF47051))),
          error: (error, stack) => Center(child: Text('Unable to load library', style: const TextStyle(color: Colors.white))),
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.subtitle, required this.items, required this.onTap});

  final String title;
  final String subtitle;
  final List<AudiobookModel> items;
  final void Function(AudiobookModel) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFF121212), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Fredoka')),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 13)),
          const SizedBox(height: 16),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Text('No items here yet.', style: TextStyle(color: Color(0xFFC6C6C6))),
            )
          else
            Column(children: items.map((book) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.network(book.coverUrl, width: 54, fit: BoxFit.cover)),
                title: Text(book.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                subtitle: Text(book.author, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 13)),
                trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xFF757575), size: 18),
                onTap: () => onTap(book),
              ),
            )).toList()),
        ],
      ),
    );
  }
}
