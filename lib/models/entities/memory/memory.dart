import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// サブエピソードの型です、APIで受け取ったサブエピソードなど、主に閲覧の方で使用します。
/// 投稿のほうでは、一時的に[SubEpisode]を使います。（今後修正の余地あり）
class Episode {
  final String id;
  final String episode;
  final LatLng latLng;

  Episode({
    @required this.id,
    @required this.episode,
    @required this.latLng,
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
  String memory;
  LatLng latLng;
  List<String> seenAuthor;
  List<Episode> episodes;
  String image;
  String author;

  Memory({
    @required this.memory,
    @required this.latLng,
    @required this.seenAuthor,
    @required this.episodes,
    @required this.image,
    @required this.author,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      memory: json['memory'],
      latLng: LatLng(json['latitude'], json['longitude']),
      seenAuthor: json['seen_author'].cast<String>() as List<String>,
      episodes: List<Episode>.from(
          json['episodes'].map((value) => Episode.fromJson(value))),
      image: json['image'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
        'memory': memory,
        'latitude': latLng.latitude,
        'longitude': latLng.longitude,
        'seen_author': seenAuthor,
        'episodes': episodes.map((episode) => episode.toJson()).toList(),
        'image': image,
        'author': author,
      };
}

/// SubEpisode作成時にのみ使用。APIから取得したサブエピソードは[Episode]である。
class SubEpisode {
  LatLng latLng;
  String episode;

  SubEpisode({@required this.latLng, @required this.episode});
}
