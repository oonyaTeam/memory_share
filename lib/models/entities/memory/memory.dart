import 'package:memory_share/models/entities/entities.dart';

/// サブエピソードの型です、APIで受け取ったサブエピソードなど、主に閲覧の方で使用します。
/// 投稿のほうでは、一時的に[SubEpisode]を使います。（今後修正の余地あり）
class Episode {
  final int id;
  final String episode;
  final Location location;

  Episode({
    required this.id,
    required this.episode,
    required this.location,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      episode: json['episode'],
      location: Location.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'episode': episode,
        ...location.toJson(),
      };
}

/// 投稿全体の型です。メインのエピソードやサブエピソードなどを持ちます。
class Memory {
  int id;
  String memory;
  Location location;
  List<Episode> episodes;
  String image;
  int authorId;
  num angle;
  bool isSeen;
  String? address;

  Memory({
    required this.id,
    required this.memory,
    required this.location,
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
      location: Location.fromJson(json),
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
      ...location.toJson(),
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
  Location location;
  String episode;

  SubEpisode({required this.location, required this.episode});
}

class NewMemory {
  String memory;
  Location location;
  List<Episode> episodes;
  String image;
  double angle;

  NewMemory({
    required this.memory,
    required this.location,
    required this.episodes,
    required this.image,
    required this.angle,
  });

  Map<String, dynamic> toJson() {
    final episodesJson = episodes.map((episode) => episode.toJson()).toList();
    return {
      'memory': memory,
      ...location.toJson(),
      'episodes': episodesJson,
      'image': image,
      'angle': angle,
    };
  }
}

class NewSeenMemory {
  int id;

  NewSeenMemory({required this.id});

  Map<String, dynamic> toJson() {
    return {
      'memory_id': id,
    };
  }
}
