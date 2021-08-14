import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class PostViewModel with ChangeNotifier {

  PostViewModel() {
    getMyMemories();
  }

  PostRepository _postRepository;

  File _photo;
  List<Memory> _myMemories = [];
  final List<SubEpisode> _subEpisodeList = [];
  Memory _newMemory;

  File get photo => _photo;

  List<Memory> get myMemories => _myMemories;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  Memory get newMemory => _newMemory;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void setMemory(String memory) {
    _newMemory.memory = memory;
    notifyListeners();
    // post_pageで再レンダリングしないためにここではnotifyListeners()を呼び出さない。
    // 投稿内容を永続化しておくなら、ここにその処理を記述する。
  }

  void addSubEpisode(String subEpisode) async {
    final position = await Geolocator.getCurrentPosition();
    _subEpisodeList.add(SubEpisode(
      latLng: LatLng(position.latitude, position.longitude),
      episode: subEpisode,
    ));
    notifyListeners();
  }

  void removeSubEpisode(int index) {
    _subEpisodeList.removeAt(index);
    notifyListeners();
  }

  void clearSubEpisode() {
    _subEpisodeList.clear();
    _newMemory.episodes.clear();
    notifyListeners();
  }

  void getMyMemories() async {
    const uuid = "author1"; // TODO: sampleなので、firebase Authを導入したら変える
    await _postRepository.getMyMemories(uuid).then((myMemories) => _myMemories = myMemories);
    notifyListeners();
  }

  Future<void> postMemory(String memory) async {
    await _postRepository.postMemory(
      mainMemory: memory,
      subEpisodeList: _subEpisodeList,
      photo: photo,
    );
  }
}
