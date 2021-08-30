import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

/// マップ（閲覧）に関する処理をまとめたリポジトリ
class MapRepository {
  final MapService _mapService = MapService();

  /// 投稿を取得する処理。現状は、サンプルのデータとAPIから取得したデータを合わせて返している。
  Future<List<Memory>> getMemories() async {
    // サンプルデータ
    List<Memory> sampleMemories = [
      Memory(
        memory: "this is sample memory1",
        latLng: const LatLng(34.8532, 136.5822),
        seenAuthor: ["author1"],
        episodes: [],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author1",
      ),
      Memory(
        memory: "this is sample memory2",
        latLng: const LatLng(34.8480, 136.5756),
        seenAuthor: ["author2"],
        episodes: [],
        image:
            "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author2",
      ),
    ];
    final List<Memory> memories = await _mapService.getMemories();
    return [...sampleMemories, ...memories];
  }

  Future<int> getDistance(Memory memory) async {
    final int distance = await _mapService.getDistance(memory);
    return distance;
  }
}
