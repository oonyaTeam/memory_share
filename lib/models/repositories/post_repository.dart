import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/models/services/post_service.dart';

class PostRepository {
  PostService _postService;

  Future<void> postMemory({
    @required String mainEpisode,
    @required List<SubEpisode> subEpisodeList,
    @required File photo,
  }) async {
    await _postService.postMemory(
      mainEpisode: mainEpisode,
      subEpisodes: subEpisodeList.asMap(),
      photo: photo,
    );
  }

  Future<List<Memory>> getMyMemories(String uuid) async {
    final myMemories = await _postService.getMyMemories(uuid);
    return myMemories;
  }
}
