import 'dart:io';

import 'package:memory_share/models/models.dart';
import 'package:memory_share/models/services/core_service.dart';
import 'package:memory_share/models/services/post_service.dart';
import 'package:memory_share/models/services/seen_memory_service.dart';
import 'package:memory_share/models/services/storage_service.dart';

class PostRepository {
  final PostService _postService = PostService();
  final StorageService _storageService = StorageService();
  final SeenMemoryService _seenMemoryService = SeenMemoryService();
  final CoreService _coreService = CoreService();

  /// 投稿を行う処理。撮った画像を[StorageService]でCloudStorageに投げたあと、
  /// そのURLとエピソードなどを[Memory]としてAPIに投げている。
  Future<void> postMemory({
    required String mainEpisode,
    required List<SubEpisode> subEpisodeList,
    required File photo,
    required double angle,
  }) async {
    final String imageUrl = await _storageService.uploadImage(photo);
    await _postService.postMemory(
        mainEpisode: mainEpisode,
        subEpisodes: List<Episode>.from(
          subEpisodeList.asMap().entries.map((entry) => Episode(
                id: entry.key,
                episode: entry.value.episode,
                location: entry.value.location,
              )),
        ),
        imageUrl: imageUrl,
        angle: angle);
  }

  Future<void> seenMemoryId({
    required int id,
  }) async {
    await _seenMemoryService.updateMemoryId(id: id);
  }

  Future<ImageWithAngle> takeMainEpisodeImage() async {
    // 写真を撮るために画面を横向きに
    await _coreService.setScreenOrientationLandscape();
    final File? takenImage = await _coreService.takeImage();

    final double? angle = await _coreService.getAngle();

    // 画面を縦向きに戻す
    await _coreService.setScreenOrientationPortrait();

    return ImageWithAngle(
      image: takenImage,
      angle: angle,
    );
  }
}

class ImageWithAngle {
  ImageWithAngle({
    required this.image,
    required this.angle,
  });

  final File? image;
  final double? angle;
}
