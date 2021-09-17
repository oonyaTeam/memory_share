import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

/// 投稿に関する処理をまとめたService
class PostService {
  Future<Memory> postMemory({
    required String mainEpisode,
    required List<Episode> subEpisodes,
    required String imageUrl,
  }) async {
    final currentPosition = await Geolocator.getCurrentPosition();

    // TODO: 自分をauthorとseenAuthorに登録してる。sampleなので（以下略
    // TODO: サンプルimageをセット（cloud storageに上げて、Urlを入れる処理が必要）
    // episode: idにindexを入れたいので、一度Mapにして、展開している。idに入れる値は後々検討すべき？
    final Memory newMemory = Memory(
      memory: mainEpisode,
      author: "author1",
      image: imageUrl,
      latLng: LatLng(currentPosition.latitude, currentPosition.longitude),
      episodes: subEpisodes,
    );
    final String idToken = await AuthService().getIdToken();
    await createMemory(newMemory, idToken, http.Client());
    return newMemory;
  }

  // post_serviceに置くのは適切でないような気がするので、後々修正予定。
  Future<List<Memory>> getMyMemories(String uuid) async {
    // TODO: sampleなので、firebase Authを導入したら変える
    final List<Memory> myMemories = await fetchMyMemories(uuid);

    return myMemories;
  }
}
