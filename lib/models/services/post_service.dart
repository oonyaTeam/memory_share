import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class PostService {
  Future<void> postMemory({
    @required String mainMemory,
    @required Map<int, SubEpisode> subEpisodes,
    @required File photo,
  }) async {
    final currentPosition = await Geolocator.getCurrentPosition();

    // TODO: 自分をauthorとseenAuthorに登録してる。sampleなので（以下略
    // TODO: サンプルimageをセット（cloud storageに上げて、Urlを入れる処理が必要）
    // episode: idにindexを入れたいので、一度Mapにして、展開している。idに入れる値は後々検討すべき？
    final Memory newMemory = Memory(
      memory: mainMemory,
      author: "author1",
      seenAuthor: ["author1"],
      image:
          "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
      latLng: LatLng(currentPosition.latitude, currentPosition.longitude),
      episodes: List<Episode>.from(
          subEpisodes.entries.map((subEpisode) => Episode(
                id: subEpisode.key.toString(),
                episode: subEpisode.value.episode,
                distance: Geolocator.distanceBetween(
                  currentPosition.latitude,
                  currentPosition.longitude,
                  subEpisode.value.latLng.latitude,
                  subEpisode.value.latLng.longitude,
                ).toInt(),
              ))),
    );
    await createMemory(newMemory);
  }
}
