import '../repositories/audiobook_repository.dart';
import '../../data/models/audiobook_model.dart';

class GetFeaturedAudiobooks {
  GetFeaturedAudiobooks(this.repository);

  final AudiobookRepository repository;

  Future<List<AudiobookModel>> call() async {
    return repository.getFeaturedAudiobooks();
  }
}
