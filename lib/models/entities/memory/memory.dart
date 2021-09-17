import 'package:google_maps_flutter/google_maps_flutter.dart';

/// サブエピソードの型です、APIで受け取ったサブエピソードなど、主に閲覧の方で使用します。
/// 投稿のほうでは、一時的に[SubEpisode]を使います。（今後修正の余地あり）
class Episode {
  final int id;
  final String episode;
  final LatLng latLng;

  Episode({
    required this.id,
    required this.episode,
    required this.latLng,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      episode: json['episode'],
      latLng: LatLng(json['latitude'], json['longitude']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'episode': episode,
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
      };
}

/// 投稿全体の型です。メインのエピソードやサブエピソードなどを持ちます。
class Memory {
  int id;
  String memory;
  LatLng latLng;
  List<Episode> episodes;
  String image;
  int authorId;
  double angle;
  bool isSeen;

  Memory({
    required this.id,
    required this.memory,
    required this.latLng,
    required this.episodes,
    required this.image,
    required this.authorId,
    required this.angle,
    required this.isSeen,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      id: json['id'],
      memory: json['memory'],
      latLng: LatLng(json['latitude'], json['longitude']),
      episodes: List<Episode>.from(
          json['episodes'].map((value) => Episode.fromJson(value))),
      image: json['image'],
      authorId: json['author_id'],
      angle: json['angle'],
      isSeen: json['seen'],
    );
  }

  Map<String, dynamic> toJson() {
    final episodesJson = episodes.map((episode) => episode.toJson()).toList();
    return {
      'id': id,
      'memory': memory,
      'latitude': latLng.latitude,
      'longitude': latLng.longitude,
      'episodes': episodesJson,
      'image': image,
      'author_id': authorId,
      'angle': angle,
      'seen': isSeen,
    };
  }
}

/// SubEpisode作成時にのみ使用。APIから取得したサブエピソードは[Episode]である。
class SubEpisode {
  LatLng latLng;
  String episode;

  SubEpisode({required this.latLng, required this.episode});
}
