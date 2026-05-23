import 'dart:async';

import '../storage/hive_service.dart';

class DownloadManager {
  static Future<bool> downloadAudiobook(String id) async {
    await Future.delayed(const Duration(milliseconds: 900));
    await HiveService.registerDownload(id);
    return true;
  }

  static Future<List<String>> getDownloadedAudiobooks() async {
    return HiveService.getDownloads();
  }
}
