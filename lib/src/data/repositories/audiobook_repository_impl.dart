import '../../data/datasources/mock_api.dart';
import '../../data/models/audiobook_model.dart';
import '../../domain/repositories/audiobook_repository.dart';

class AudiobookRepositoryImpl implements AudiobookRepository {
  @override
  Future<List<AudiobookModel>> getFeaturedAudiobooks() async {
    return MockAudioApi.fetchFeaturedAudiobooks();
  }

  @override
  Future<AudiobookModel?> getAudiobookById(String id) async {
    return MockAudioApi.fetchAudiobookById(id);
  }
}
