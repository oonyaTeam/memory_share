import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  set photo(File? photo) {
    _photo = photo;
    notifyListeners();
  }

  set mainEpisode(String mainEpisode) {
    _mainEpisode = mainEpisode;
    notifyListeners();
  }

  set angle(double angle) {
    _angle = angle;
    notifyListeners();
  }

  /// サブエピソードを追加する
  void addSubEpisode(String subEpisode) async {
    final position = await Geolocator.getCurrentPosition();
    _subEpisodeList.add(SubEpisode(
      location: Location.fromPosition(position),
      episode: subEpisode,
    ));
    notifyListeners();
  }

  /// 特定のサブエピソードを削除する
  void removeSubEpisode(int index) {
    _subEpisodeList.removeAt(_subEpisodeList.length - index - 1);
    notifyListeners();
  }

  /// サブエピソードをすべて削除する
  void clearSubEpisode() {
    _subEpisodeList.clear();
    notifyListeners();
  }

  /// MainEpisodeを削除する
  void clearMainEpisode() {
    _mainEpisode = '';
    notifyListeners();
  }

  /// 新規投稿のデータを削除する
  void clearNewPost() {
    _mainEpisode = '';
    _photo = null;
    _subEpisodeList.clear();
    _angle = 0;
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

  /// MainEpisodeの写真を取り、その写真と撮影した方角を保持する。
  Future<void> takeMainEpisodeImage() async {
    final imageWithAngle = await _postRepository.takeMainEpisodeImage();
    if (imageWithAngle.image == null || imageWithAngle.angle == null) {
      throw Error();
    }

    photo = imageWithAngle.image!;
    angle = imageWithAngle.angle!;
  }
}
