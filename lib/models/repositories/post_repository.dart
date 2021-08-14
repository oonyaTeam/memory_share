import 'dart:io';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/models/services/post_service.dart';

class PostRepository {
  PostService _postService;

  Future<void> postMemory({
    @required String mainMemory,
    @required List<SubEpisode> subEpisodeList,
    @required File photo,
  }) async {
    await _postService.postMemory(
      mainMemory: mainMemory,
      subEpisodes: subEpisodeList.asMap(),
      photo: photo,
    );
  }

  Future<List<Memory>> getMyMemories(String uuid) async {
    final myMemories = _postService.getMyMemories(uuid);
    return myMemories;
  }
}
