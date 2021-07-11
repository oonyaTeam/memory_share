import 'package:google_maps_flutter/google_maps_flutter.dart';

class Episode {
  final String id;
  final String episode;
  final num distance;

  Episode({
    this.id,
    this.episode,
    this.distance,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      episode: json['episode'],
      distance: json['distance'],
    );
  }
}

class Memory {
  final String memory;
  final LatLng geography;
  final List<String> seenAuthor;
  final List<Episode> episodes;
  final String image;
  final String author;

  Memory({
    this.memory,
    this.geography,
    this.seenAuthor,
    this.episodes,
    this.image,
    this.author,
  });

  factory Memory.fromJson(Map<String, dynamic> json) {
    return Memory(
      memory: json['memory'],
      geography: LatLng(json['geography'][0], json['geography'][1]),
      seenAuthor: json['seen_author'],
      episodes: json['episodes'].map((value) => Episode.fromJson(value)).toList(),
      image: json['image'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
    'memory': memory,
    'geography': geography,
    'seen_author': seenAuthor,
    'episodes': episodes,
    'image': image,
    'author': author,
  }
}
