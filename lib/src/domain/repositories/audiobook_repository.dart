import '../../data/models/audiobook_model.dart';

abstract class AudiobookRepository {
  Future<List<AudiobookModel>> getFeaturedAudiobooks();
  Future<AudiobookModel?> getAudiobookById(String id);
}
