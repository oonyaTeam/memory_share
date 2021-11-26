import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

/// 投稿に関する処理をまとめたService
class PostService {
  final LocationService _locationService = LocationService();

  Future<void> postMemory({
    required String mainEpisode,
    required List<Episode> subEpisodes,
    required String imageUrl,
    required double angle,
  }) async {
    final currentLocation = await _locationService.getCurrentLocation();

    final NewMemory newMemory = NewMemory(
      memory: mainEpisode,
      image: imageUrl,
      location: currentLocation,
      episodes: subEpisodes,
      angle: angle,
    );
    final String idToken = await AuthService().getIdToken();
    await createMemory(newMemory, idToken, http.Client());
  }
}
