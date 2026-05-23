import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String settingsBox = 'settings_box';
  static const String favoritesKey = 'favorites';
  static const String downloadsKey = 'downloads';
  static const String libraryKey = 'library';

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(settingsBox);
  }

  static Box get box => Hive.box(settingsBox);

  static List<String> getFavorites() {
    return List<String>.from(box.get(favoritesKey, defaultValue: <String>[]) as List<dynamic>);
  }

  static Future<void> toggleFavorite(String id) async {
    final favorites = getFavorites();
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    await box.put(favoritesKey, favorites);
  }

  static List<String> getDownloads() {
    return List<String>.from(box.get(downloadsKey, defaultValue: <String>[]) as List<dynamic>);
  }

  static Future<void> registerDownload(String id) async {
    final downloads = getDownloads();
    if (!downloads.contains(id)) {
      downloads.add(id);
      await box.put(downloadsKey, downloads);
    }
  }

  static List<String> getLibrary() {
    return List<String>.from(box.get(libraryKey, defaultValue: <String>[]) as List<dynamic>);
  }

  static Future<void> addToLibrary(String id) async {
    final library = getLibrary();
    if (!library.contains(id)) {
      library.add(id);
      await box.put(libraryKey, library);
    }
  }
}
