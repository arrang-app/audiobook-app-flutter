import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/audiobook_model.dart';
import '../../providers/app_providers.dart';
import '../widgets/audiobook_card.dart';
import '../widgets/genre_chip.dart';
import '../widgets/mini_player.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredAudiobooksProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Good evening', style: TextStyle(fontFamily: 'Fredoka', fontSize: 32, color: Colors.white)),
                      SizedBox(height: 6),
                      Text('Your curated audiobook library awaits', style: TextStyle(color: Color(0xFFC6C6C6), fontSize: 15)),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                height: 42,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    GenreChip(label: 'Thriller'),
                    GenreChip(label: 'Fantasy'),
                    GenreChip(label: 'Wellness'),
                    GenreChip(label: 'Drama'),
                    GenreChip(label: 'History'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: featuredAsync.when(
                data: (books) => ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    Text('Featured Audiobooks', style: const TextStyle(fontFamily: 'Fredoka', fontSize: 22, color: Colors.white)).animate().fadeIn(duration: 500.ms),
                    const SizedBox(height: 16),
                    ...books.map((book) => AudiobookCard(
                          audiobook: book,
                          onTap: () => context.push('/details/${book.id}'),
                        )),
                    const SizedBox(height: 20),
                    const Text('Continue listening', style: TextStyle(fontFamily: 'Fredoka', fontSize: 22, color: Colors.white)),
                    const SizedBox(height: 16),
                    ...books.take(2).map((book) => GestureDetector(
                          onTap: () => context.push('/player/${book.id}'),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: const Color(0xFF141414),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: Image.network(book.coverUrl, width: 74, height: 74, fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(book.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                                      const SizedBox(height: 6),
                                      Text(book.author, style: const TextStyle(color: Color(0xFFC6C6C6), fontSize: 14)),
                                      const SizedBox(height: 12),
                                      LinearProgressIndicator(value: 0.42, color: const Color(0xFFF47051), backgroundColor: const Color(0xFF262626)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const SizedBox(height: 120),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF47051))),
                error: (error, stack) => Center(
                  child: Text('Failed to load books.', style: const TextStyle(color: Color(0xFFC6C6C6))),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
