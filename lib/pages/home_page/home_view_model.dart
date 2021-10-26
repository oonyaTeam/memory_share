import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    getMemories();

    getPosition();

    // マーカーの画像の取得
    _mapRepository
        .getMainEpisodeMarkerBitmap('assets/memory_spot_icon.png')
        .then((value) {
      _memoryMarker = value;
    });
    _mapRepository
        .getMainEpisodeMarkerBitmap('assets/memory_spot_icon_viewed.png')
        .then((value) {
      _memoryViewedMarker = value;
    });

    // 位置情報を取得するStreamを定義
    _positionStream = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 5),
    ).listen((Position position) {
      _currentPosition = position;
      if (_currentMemory != null) {
        setDistance();
      }
      notifyListeners();
    });
  }

  final MapRepository _mapRepository = MapRepository();

  /// ユーザの現在位置
  Position? _currentPosition;

  /// ユーザの現在位置とフォーカスしているMemoryとの距離
  int _distance = 0;

  /// マップを制御するControllerを管理するCompleter
  final Completer<GoogleMapController> _homeMapController = Completer();

  /// Memory（投稿）の配列
  final List<Memory> _memories = [];

  /// フォーカスしているMemory
  Memory? _currentMemory;

  /// マップ上に表示するMemoryのマーカーのBitmapイメージ
  BitmapDescriptor? _memoryMarker;
  BitmapDescriptor? _memoryViewedMarker;

  /// ユーザの位置情報が流れてくるStream
  StreamSubscription<Position>? _positionStream;

  Position? get currentPosition => _currentPosition;

  int get distance => _distance;

  Completer<GoogleMapController> get homeMapController => _homeMapController;

  List<Memory> get memories => _memories;

  Memory? get currentMemory => _currentMemory;

  BitmapDescriptor? get memoryMarker => _memoryMarker;
  BitmapDescriptor? get memoryViewedMarker => _memoryViewedMarker;

  set currentMemory(Memory? memory) {
    _currentMemory = memory;
    setDistance();
  }

  void addMemory(Memory memory) {
    _memories.add(memory);
    notifyListeners();
  }

  void addMemories(List<Memory> memories) {
    _memories.addAll(memories);
  }

  /// 現在地を取得する
  void getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  /// 現在地とフォーカスしているMemoryとの距離を設定する。
  void setDistance() {
    if (_currentPosition == null || _currentMemory == null) return;

    _distance = _mapRepository.getDistance(
      _currentMemory!.location,
      Location.fromPosition(_currentPosition!),
    );
  }

  /// マップを制御するCOntrollerをセットする。
  void setHomeMapController(GoogleMapController controller) {
    _homeMapController.complete(controller);
    notifyListeners();
  }

  /// 投稿を API から取得する
  void getMemories() async {
    final memories = await _mapRepository.getMemories();
    addMemories(memories);
    notifyListeners();
  }

  /// GoogleMapのスタイルを変更（定義）する
  ///
  /// スタイルの設定が書かれているファイルを読み込み、その内容を反映させる。
  changeMapMode(GoogleMapController controller) {
    getMapStyleJsonFile("assets/Light.json")
        .then((res) => {controller.setMapStyle(res)});
  }

  /// GoogleMapのスタイルが定義されているファイルを読み込む
  Future<String> getMapStyleJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream?.cancel();
  }
}
