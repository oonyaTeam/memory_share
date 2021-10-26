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
      _currentLocation = Location.fromPosition(position);
      await setDistance();
      checkDistance();
    });

    // currentMemoryのサブエピソードを、ReExperienceでの表示のために_subEpisodeListに代入してる。
    _subEpisodeList = _currentMemory.episodes
        .map((episode) => SubEpisode(
              id: episode.id,
              episode: episode.episode,
              location: episode.location,
            ))
        .toList();
  }

  final MapRepository _mapRepository = MapRepository();
  final UserRepository _userRepository = UserRepository();
  final LocationRepository _locationRepository = LocationRepository();
  final BuildContext _context;

  // メイン・サブエピソードを見ることができる距離の定数値
  static const distancePossibleViewMainEpisodeDialog = 10;
  static const distancePossibleViewSubEpisodeDialog = 10;

  Location? _currentLocation;
  num _distance = double.infinity;
  num _sigma = double.infinity;
  final Completer<GoogleMapController> _reExperienceMapController = Completer();
  final Memory _currentMemory;
  List<SubEpisode> _subEpisodeList = [];
  bool _isViewedMainEpisodeDialog = false;
  bool _shouldViewingDialog = false;
  BitmapDescriptor? _mainEpisodeMarker;
  BitmapDescriptor? _mainEpisodeViewedMarker;

  StreamSubscription<Position>? _positionStream;

  Location? get currentLocation => _currentLocation;

  num get distance => _distance;

  num get sigma => _sigma;

  Completer<GoogleMapController> get reExperienceMapController =>
      _reExperienceMapController;

  Memory get currentMemory => _currentMemory;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

  bool get shouldViewingDialog => _shouldViewingDialog;

  bool get isViewedMainEpisodeDialog => _isViewedMainEpisodeDialog;

  BitmapDescriptor? get mainEpisodeMarker => _mainEpisodeMarker;
  BitmapDescriptor? get mainEpisodeViewedMarker => _mainEpisodeViewedMarker;

  /// ユーザの現在地を取得
  void getPosition() async {
    _currentLocation = await _locationRepository.getCurrentLocation();
    notifyListeners();
  }

  /// メイン・サブエピソードとの距離を設定
  Future<void> setDistance() async {
    if (_currentLocation == null) return;

    // メインエピソードとの距離を変更
    _distance = _mapRepository.getDistance(
      _currentMemory.location,
      _currentLocation!,
    );

    if (_distance / 100 >= 10) {
      _sigma = 10;
    } else {
      _sigma = _distance / 100;
    }

    // 各サブエピソードとの距離を変更
    for (int i = 0; i < _subEpisodeList.length; i++) {
      _subEpisodeList[i].distance = _mapRepository.getDistance(
        _subEpisodeList[i].location,
        _currentLocation!,
      );
    }
    notifyListeners();
  }

  /// メイン・サブエピソードとの距離などの条件をチェックし、ダイアログなどを表示する。
  void checkDistance() {
    if (_shouldViewingDialog) return;

    if (_distance <= distancePossibleViewMainEpisodeDialog &&
        !_isViewedMainEpisodeDialog) {
      _userRepository.viblate();
      showMainEpisodeDialog();
      _isViewedMainEpisodeDialog = true;
    }

    if (_shouldViewingDialog) return;

    // 各サブエピソードの距離を見て、表示距離以下かつ表示しているダイアログが無ければ、
    // サブエピソードのダイアログを表示する。
    for (SubEpisode subEpisode in _subEpisodeList) {
      if (!subEpisode.isViewed &&
          subEpisode.distance <= distancePossibleViewSubEpisodeDialog) {
        viewSubEpisode(subEpisode.id);
        _userRepository.viblate();
        showSubEpisodeDialog(subEpisode.episode);
      }
    }
  }

  void setReExperienceMapController(GoogleMapController controller) {
    _reExperienceMapController.complete(controller);
    notifyListeners();
  }

  /// マップモードを変更する
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
        (_currentLocation!.latitude + _currentMemory.location.latitude) / 2;
    final longitude =
        (_currentLocation!.longitude + _currentMemory.location.longitude) / 2;
    return LatLng(latitude, longitude);
  }

  /// EpisodeViewPageに遷移するダイアログを表示する。
  void showMainEpisodeDialog() {
    _shouldViewingDialog = true;
    showDialog(
      context: _context,
      builder: (_) => YesDialogBox(
        descriptions1: "目的地の周辺です。\nカメラに切り替えます。",
        wid: MediaQuery.of(_context).size.width,
        tapEvent1: () {
          Navigator.pop(_context);
          Navigator.of(_context).push(MaterialPageRoute(
            builder: (_) => EpisodeViewPage(_currentMemory),
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
  void viewSubEpisode(int id) {
    final int index =
        _subEpisodeList.indexWhere((subEpisode) => subEpisode.id == id);
    _subEpisodeList[index].isViewed = true;
    notifyListeners();
  }

  /// メインエピソードとサブエピソードのマーカーの画像を取得する関数
  void getMarkerBitmaps() async {
    // メインエピソードのマーカー画像を取得
    Future<void> _getMainEpisodeMarker() async {
      final BitmapDescriptor marker = await _mapRepository
          .getMainEpisodeMarkerBitmap('assets/memory_spot_icon.png');
      _mainEpisodeMarker = marker;
      final BitmapDescriptor viewedMarker = await _mapRepository
          .getMainEpisodeMarkerBitmap('assets/memory_spot_icon_viewed.png');
      _mainEpisodeViewedMarker = viewedMarker;
    }

    // サブエピソードのマーカー画像（二種類）を取得
    Future<void> _getSubEpisodeMarker(int index) async {
      final BitmapDescriptor marker = await _mapRepository
          .getSubEpisodeMarkerBitmap(_subEpisodeList[index].iconKey);
      _subEpisodeList[index].iconImage = marker;

      final BitmapDescriptor invalidMarker = await _mapRepository
          .getSubEpisodeMarkerBitmap(_subEpisodeList[index].invalidIconKey);
      _subEpisodeList[index].invalidIconImage = invalidMarker;
    }

    // それぞれの取得処理を futures にまとめ、並行処理している
    final List<Future<void>> futures = [];

    futures.add(_getMainEpisodeMarker());

    for (int i = 0; i < _subEpisodeList.length; i++) {
      futures.add(_getSubEpisodeMarker(i));
    }

    await Future.wait(futures);
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
    required this.location,
    this.isViewed = false,
    this.distance = double.infinity,
  });

  final int id;
  final String episode;
  final Location location;
  bool isViewed;
  num distance;

  //　マーカー表示のためのGlobalKey
  final GlobalKey iconKey = GlobalKey();
  final GlobalKey invalidIconKey = GlobalKey();

  // マーカーの画像
  BitmapDescriptor? iconImage;
  BitmapDescriptor? invalidIconImage;
}
