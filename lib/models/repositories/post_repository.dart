import 'dart:io';

import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/models/services/post_service.dart';
import 'package:memory_share/models/services/storage_service.dart';

class PostRepository {
  final PostService _postService = PostService();
  final StorageService _storageService = StorageService();

  Future<void> postMemory({
    @required String mainEpisode,
    @required List<SubEpisode> subEpisodeList,
    @required File photo,
  }) async {
    final String imageUrl = await _storageService.uploadImage(photo);
    await _postService.postMemory(
      mainEpisode: mainEpisode,
      subEpisodes: subEpisodeList.asMap(),
      imageUrl: imageUrl,
    );
  }

  Future<List<Memory>> getMyMemories(String uuid) async {
    final myMemories = await _postService.getMyMemories(uuid);
    return myMemories;
  }
}
