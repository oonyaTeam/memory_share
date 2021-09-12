import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

/// マップ（閲覧）に関する処理をまとめたリポジトリ
class MapRepository {
  final MapService _mapService = MapService();

  /// 投稿を取得する処理。現状は、サンプルのデータとAPIから取得したデータを合わせて返している。
  Future<List<Memory>> getMemories() async {
    // サンプルデータ
    final List<Memory> sampleMemories = [
      Memory(
        memory: "this is sample memory1",
        latLng: const LatLng(34.8532, 136.5822),
        seenAuthor: ["author1"],
        episodes: [
          Episode(
            id: 'episode0',
            episode: 'this is sub episode 0',
            latLng: const LatLng(34.8510, 136.588),
          ),
          Episode(
            id: 'episode1',
            episode: 'this is sub episode 1',
            latLng: const LatLng(34.8529, 136.589),
          ),
          Episode(
            id: 'episode2',
            episode: 'this is sub episode 2',
            latLng: const LatLng(34.8520, 136.5801),
          ),
        ],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author1",
      ),
      Memory(
        memory: "this is sample memory2",
        latLng: const LatLng(34.8480, 136.5756),
        seenAuthor: ["author2"],
        episodes: [
          Episode(
            id: 'episode1',
            episode: 'this is sub episode 1',
            latLng: const LatLng(34.8520, 136.580),
          ),
          Episode(
            id: 'episode2',
            episode: 'this is sub episode 2',
            latLng: const LatLng(34.8515, 136.581),
          ),
        ],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author2",
      ),
    ];
    final List<Memory> memories = await _mapService.getMemories();
    return [...sampleMemories, ...memories];
  }

  ///　現在の位置と目的地との距離を返す
  int getDistance(LatLng startLatLng, LatLng endLatLng) {
    final int distance = _mapService.getDistance(
      startLatLng,
      endLatLng,
    );
    return distance;
  }
}
