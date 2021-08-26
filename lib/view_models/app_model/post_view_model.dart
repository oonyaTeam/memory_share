import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class PostViewModel with ChangeNotifier {
  final PostRepository _postRepository = PostRepository();

  File _photo;
  final List<SubEpisode> _subEpisodeList = [];
  String _mainEpisode = "";

  File get photo => _photo;

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

  Future<void> postMemory() async {
    await _postRepository.postMemory(
      mainEpisode: _mainEpisode,
      subEpisodeList: _subEpisodeList,
      photo: _photo,
    );
  }
}
