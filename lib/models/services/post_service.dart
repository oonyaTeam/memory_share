import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

/// 投稿に関する処理をまとめたService
class PostService {
  Future<void> postMemory({
    required String mainEpisode,
    required List<Episode> subEpisodes,
    required String imageUrl,
    required double angle
  }) async {
    final currentPosition = await Geolocator.getCurrentPosition();

    // TODO: サンプルデータを変更。投稿で投げるjsonは違うので、それも変更
    // episode: idにindexを入れたいので、一度Mapにして、展開している。idに入れる値は後々検討すべき？
    final NewMemory newMemory = NewMemory(
      memory: mainEpisode,
      image: imageUrl,
      latLng: LatLng(currentPosition.latitude, currentPosition.longitude),
      episodes: subEpisodes,
      angle: angle,
    );
    final String idToken = await AuthService().getIdToken();
    await createMemory(newMemory, idToken, http.Client());
  }

  // post_serviceに置くのは適切でないような気がするので、後々修正予定。
  Future<List<Memory>> getMyMemories(String uuid) async {
    final String idToken = await AuthService().getIdToken();
    // TODO: sampleなので、firebase Authを導入したら変える
    final List<Memory> myMemories = await fetchMyMemories(uuid, idToken);

    return myMemories;
  }
}
