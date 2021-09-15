import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/episode_view_page/episode_view_page.dart';
import 'package:memory_share/widgets/sub_episode_dialog.dart';
import 'package:memory_share/widgets/widgets.dart';

class ReExperienceViewModel with ChangeNotifier {
  ReExperienceViewModel(this._currentMemory, this._context) {
    // 位置情報を取得するStream
    _positionStream = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 5),
    ).listen((Position position) async {
      // currentPositionを変更、メインエピソード・サブエピソードとの距離も変更したのち、
      // 各サブエピソードを表示するかをチェックしている。
      _currentPosition = position;
      await setDistance();
      checkDistance();
      notifyListeners();
    });

    // currentMemoryのサブエピソードを、ReExperienceでの表示のために_subEpisodeListに代入してる。
    _subEpisodeList = _currentMemory.episodes
        .map((episode) => SubEpisode(
              id: episode.id,
              episode: episode.episode,
              latLng: episode.latLng,
            ))
        .toList();
  }

  final MapRepository _mapRepository = MapRepository();
  final BuildContext _context;

  // サブエピソードを見ることができる距離の定数値
  static const distancePossibleViewSubEpisodeDialog = 100;

  Position? _currentPosition;
  num _distance = double.infinity;
  final Completer<GoogleMapController> _reExperienceMapController = Completer();
  final Memory _currentMemory;
  List<SubEpisode> _subEpisodeList = [];
  bool _shouldViewingDialog = false;

  StreamSubscription<Position>? _positionStream;

  Position? get currentPosition => _currentPosition;

  num get distance => _distance;

  Completer<GoogleMapController> get reExperienceMapController =>
      _reExperienceMapController;

  Memory get currentMemory => _currentMemory;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  bool get shouldViewingDialog => _shouldViewingDialog;

  void getPosition() async {
    final Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  Future<void> setDistance() async {
    if (_currentPosition == null) return;

    final Position currentPosition = await Geolocator.getCurrentPosition();

    _distance = _mapRepository.getDistance(
      _currentMemory.latLng,
      LatLng(currentPosition.latitude, currentPosition.longitude),
    );

    for (int i = 0; i < _subEpisodeList.length; i++) {
      _subEpisodeList[i].distance = _mapRepository.getDistance(
        _subEpisodeList[i].latLng,
        LatLng(currentPosition.latitude, currentPosition.longitude),
      );
    }

    notifyListeners();
  }

  String sample() {
    return _mapRepository
        .getDistance(
          _subEpisodeList[0].latLng,
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        )
        .toString();
  }

  /// 各サブエピソードの距離を見て、表示距離以下かつ表示しているダイアログが無ければ、
  /// サブエピソードのダイアログを表示する。
  void checkDistance() {
    if (_distance <= distancePossibleViewSubEpisodeDialog &&
        !_shouldViewingDialog) {
      showMainEpisodeDialog();
    }

    for (SubEpisode subEpisode in _subEpisodeList) {
      if (!subEpisode.isViewed &&
          subEpisode.distance <= distancePossibleViewSubEpisodeDialog &&
          !_shouldViewingDialog) {
        viewSubEpisode(subEpisode.id);
        showSubEpisodeDialog(subEpisode.episode);
      }
    }
  }

  void setReExperienceMapController(GoogleMapController controller) {
    _reExperienceMapController.complete(controller);
    notifyListeners();
  }

  changeMapMode(GoogleMapController controller) {
    getMapStyleJsonFile("assets/Light.json")
        .then((res) => controller.setMapStyle(res));
  }

  Future<String> getMapStyleJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  /// メインエピソードと自分の位置の中間をカメラ位置に設定してる。
  LatLng getCameraPosition() {
    final latitude =
        (_currentPosition!.latitude + _currentMemory.latLng.latitude) / 2;
    final longitude =
        (_currentPosition!.longitude + _currentMemory.latLng.longitude) / 2;
    return LatLng(latitude, longitude);
  }

  void showMainEpisodeDialog() {
    _shouldViewingDialog = true;
    showDialog(
      context: _context,
      builder: (_) => YesDialogBox(
        descriptions1: "目的地の周辺です。\nカメラに切り替えます。",
        wid: MediaQuery.of(_context).size.width,
        tapEvent1: () {
          Navigator.of(_context).push(MaterialPageRoute(
            builder: (_) => const EpisodeViewPage(),
          ));
        },
      ),
    ).then((_) {
      _shouldViewingDialog = false;
    });
  }

  /// サブエピソードのダイアログを表示する関数
  void showSubEpisodeDialog(String episode) {
    _shouldViewingDialog = true;
    showDialog(
      context: _context,
      builder: (_) => SubEpisodeDialog(episode),
    ).then((_) {
      // ダイアログが閉じたら、ダイアログを見ているかどうかを保持するbool値を変更。
      _shouldViewingDialog = false;
    });
  }

  /// サブエピソードを閲覧したときに、その閲覧したという値を変更する関数
  void viewSubEpisode(String id) {
    final int index =
        _subEpisodeList.indexWhere((subEpisode) => subEpisode.id == id);
    _subEpisodeList[index].isViewed = true;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream?.cancel();
  }
}

/// [ReExperiencePage]において、サブエピソードに関するデータを持つためのクラス
class SubEpisode {
  SubEpisode({
    required this.id,
    required this.episode,
    required this.latLng,
    this.isViewed = false,
    this.distance = double.infinity,
  });

  final String id;
  final String episode;
  final LatLng latLng;
  bool isViewed;
  num distance;
}
