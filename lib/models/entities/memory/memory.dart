import 'package:flutter/material.dart';
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

  Map<String, dynamic> toJson() => {
    'id': id,
    'episode': episode,
    'distance': distance,
  };
}

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
      episodes: List<Episode>.from(json['episodes'].map((value) => Episode.fromJson(value))),
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


// SubEpisode作成用
class SubEpisode {
  LatLng latLng;
  String episode;

  SubEpisode({this.latLng, this.episode});
}