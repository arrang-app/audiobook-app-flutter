class AudiobookModel {
  AudiobookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverUrl,
    required this.backgroundUrl,
    required this.duration,
    required this.genres,
    required this.chapters,
    required this.audioUrl,
    required this.rating,
    this.isDownloaded = false,
    this.isFavorite = false,
    this.isInLibrary = false,
  });

  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final String backgroundUrl;
  final Duration duration;
  final List<ChapterModel> chapters;
  final List<String> genres;
  final String audioUrl;
  final double rating;
  bool isDownloaded;
  bool isFavorite;
  bool isInLibrary;

  factory AudiobookModel.fromJson(Map<String, dynamic> json) {
    return AudiobookModel(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      coverUrl: json['coverUrl'] as String,
      backgroundUrl: json['backgroundUrl'] as String,
      duration: Duration(seconds: json['duration'] as int),
      genres: List<String>.from(json['genres'] as List<dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => ChapterModel.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      audioUrl: json['audioUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      isDownloaded: json['isDownloaded'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isInLibrary: json['isInLibrary'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'description': description,
        'coverUrl': coverUrl,
        'backgroundUrl': backgroundUrl,
        'duration': duration.inSeconds,
        'genres': genres,
        'chapters': chapters.map((c) => c.toJson()).toList(),
        'audioUrl': audioUrl,
        'rating': rating,
        'isDownloaded': isDownloaded,
        'isFavorite': isFavorite,
        'isInLibrary': isInLibrary,
      };
}

class ChapterModel {
  ChapterModel({
    required this.id,
    required this.title,
    required this.start,
  });

  final String id;
  final String title;
  final Duration start;

  factory ChapterModel.fromJson(Map<String, dynamic> json) => ChapterModel(
        id: json['id'] as String,
        title: json['title'] as String,
        start: Duration(seconds: json['start'] as int),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'start': start.inSeconds,
      };
}
