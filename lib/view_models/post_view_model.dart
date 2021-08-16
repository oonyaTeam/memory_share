import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class PostViewModel with ChangeNotifier {
  PostViewModel() {
    getMyMemories();
  }

  final PostRepository _postRepository = PostRepository();

  File _photo;
  List<Memory> _myMemories = [];
  final List<SubEpisode> _subEpisodeList = [];
  String _mainEpisode = "";

  File get photo => _photo;

  List<Memory> get myMemories => _myMemories;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  String get mainEpisode => _mainEpisode;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  void setMainEpisode(String mainEpisode) {
    _mainEpisode = mainEpisode;
    notifyListeners();
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
    notifyListeners();
  }

  void getMyMemories() async {
    const uuid = "author1"; // TODO: sampleなので、firebase Authを導入したら変える
    await _postRepository
        .getMyMemories(uuid)
        .then((myMemories) => _myMemories = myMemories);
    notifyListeners();
  }

  Future<void> postMemory(String mainEpisode) async {
    await _postRepository.postMemory(
      mainEpisode: mainEpisode,
      subEpisodeList: _subEpisodeList,
      photo: _photo,
    );
  }
}
