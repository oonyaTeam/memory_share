import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

/// 投稿に関する処理をまとめたService
class PostService {
  Future<void> postMemory(
      {required String mainEpisode,
      required List<Episode> subEpisodes,
      required String imageUrl,
      required double angle}) async {
    final currentPosition = await Geolocator.getCurrentPosition();

    final NewMemory newMemory = NewMemory(
      memory: mainEpisode,
      image: imageUrl,
      location: Location.fromPosition(currentPosition),
      episodes: subEpisodes,
      angle: angle,
    );
    final String idToken = await AuthService().getIdToken();
    await createMemory(newMemory, idToken, http.Client());
  }
}
