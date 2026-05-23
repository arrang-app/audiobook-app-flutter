import '../../data/models/audiobook_model.dart';

class MockAudioApi {
  static Future<List<AudiobookModel>> fetchFeaturedAudiobooks() async {
    await Future.delayed(const Duration(milliseconds: 650));
    return _featuredAudiobooks;
  }

  static Future<AudiobookModel?> fetchAudiobookById(String id) async {
    await Future.delayed(const Duration(milliseconds: 350));
    return _featuredAudiobooks.firstWhere(
      (item) => item.id == id,
      orElse: () => _featuredAudiobooks.first,
    );
  }

  static final List<AudiobookModel> _featuredAudiobooks = [
    AudiobookModel(
      id: 'aurora-01',
      title: 'Midnight Cities',
      author: 'Avery Lane',
      description:
          'A cinematic journey through modern cityscapes, perfect for late-night listening and immersive storytelling.',
      coverUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=800&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d?auto=format&fit=crop&w=1200&q=80',
      duration: const Duration(hours: 12, minutes: 32),
      genres: ['Mystery', 'Thriller', 'Narrative'],
      chapters: [
        ChapterModel(id: 'ch1', title: 'Introduction', start: Duration.zero),
        ChapterModel(id: 'ch2', title: 'First Signs', start: const Duration(minutes: 12)),
        ChapterModel(id: 'ch3', title: 'City Pulse', start: const Duration(minutes: 34)),
      ],
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      rating: 4.9,
      isDownloaded: false,
      isFavorite: true,
      isInLibrary: true,
    ),
    AudiobookModel(
      id: 'aurora-02',
      title: 'Ocean of Voices',
      author: 'Mila Rowan',
      description:
          'A premium audible meditation through coastal soundscapes and character-driven drama.',
      coverUrl: 'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=800&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
      duration: const Duration(hours: 8, minutes: 18),
      genres: ['Drama', 'Wellness', 'Lifestyle'],
      chapters: [
        ChapterModel(id: 'ch1', title: 'Coastal Breath', start: Duration.zero),
        ChapterModel(id: 'ch2', title: 'Tide', start: const Duration(minutes: 18)),
      ],
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      rating: 4.7,
      isDownloaded: false,
      isFavorite: false,
      isInLibrary: false,
    ),
    AudiobookModel(
      id: 'aurora-03',
      title: 'Afterglow',
      author: 'Noah Quinn',
      description:
          'A premium story of memory and meaning, designed with smooth narration and modern audio cues.',
      coverUrl: 'https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d?auto=format&fit=crop&w=800&q=80',
      backgroundUrl: 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
      duration: const Duration(hours: 10, minutes: 40),
      genres: ['Contemporary', 'Romance', 'Audio Drama'],
      chapters: [
        ChapterModel(id: 'ch1', title: 'Spark', start: Duration.zero),
        ChapterModel(id: 'ch2', title: 'Afterlight', start: const Duration(minutes: 23)),
        ChapterModel(id: 'ch3', title: 'Horizon', start: const Duration(minutes: 55)),
      ],
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      rating: 4.8,
      isDownloaded: true,
      isFavorite: true,
      isInLibrary: true,
    ),
  ];
}
