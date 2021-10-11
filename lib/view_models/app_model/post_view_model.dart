import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

/// 投稿関連をまとめたViewModelです。
class PostViewModel with ChangeNotifier {
  /// 投稿に関するAPI処理などは[PostRepository]や[PostService]にあります。
  final PostRepository _postRepository = PostRepository();

  // 撮影した写真
  File? _photo;
  // サブエピソードのリスト
  final List<SubEpisode> _subEpisodeList = [];
  // メインのエピソード
  String _mainEpisode = "";

  double _angle = 0;

  File? get photo => _photo;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  String get mainEpisode => _mainEpisode;

  double get angle => _angle;

  void setPhoto(File photo) {
    _photo = photo;
    notifyListeners();
  }

  set mainEpisode(String mainEpisode) {
    _mainEpisode = mainEpisode;
    notifyListeners();
  }

  void setAngle(double angle) {
    _angle = angle;
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

  /// [PostRepository]のpostMemoryを呼び出して、入力したデータを投稿する。
  Future<void> postMemory() async {
    if (_photo == null) throw Error();

    await _postRepository.postMemory(
        mainEpisode: _mainEpisode,
        subEpisodeList: _subEpisodeList,
        photo: _photo!,
        angle: _angle);
  }

  Future<void> takeMainEpisodeImage() async {
    final imageWithAngle = await _postRepository.takeMainEpisodeImage();
    if (imageWithAngle.image == null || imageWithAngle.angle == null) {
      throw Error();
    }

    setPhoto(imageWithAngle.image!);
    setAngle(imageWithAngle.angle!);
  }
}
