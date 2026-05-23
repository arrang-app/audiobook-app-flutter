import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/app_providers.dart';
import '../widgets/audiobook_card.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final featuredAsync = ref.watch(featuredAudiobooksProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF070707),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search audiobooks',
                        hintStyle: const TextStyle(color: Color(0xFF7D7D7D)),
                        filled: true,
                        fillColor: const Color(0xFF161616),
                        prefixIcon: const Icon(Icons.search, color: Color(0xFF7D7D7D)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: featuredAsync.when(
                  data: (books) {
                    final filtered = books.where((book) {
                      final query = searchQuery.toLowerCase();
                      return book.title.toLowerCase().contains(query) || book.author.toLowerCase().contains(query) || book.genres.any((genre) => genre.toLowerCase().contains(query));
                    }).toList();
                    if (filtered.isEmpty) {
                      return const Center(
                        child: Text('Search to find your next audiobook', style: TextStyle(color: Color(0xFF8C8C8C), fontSize: 16)),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        return AudiobookCard(
                          audiobook: item,
                          onTap: () => context.push('/details/${item.id}'),
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFFF47051))),
                  error: (error, stack) => Center(child: Text('Could not search', style: const TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
