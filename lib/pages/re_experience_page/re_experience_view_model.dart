import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class ReExperienceViewModel with ChangeNotifier {
  ReExperienceViewModel(this._currentMemory, this._context) {
    getPosition();

    _positionStream = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 5),
    ).listen((Position position) async {
      _currentPosition = position;
      await setDistance();
      checkDistance();
      notifyListeners();
    });

    _subEpisodeList = _currentMemory.episodes
        .map((episode) => SubEpisode(
              id: episode.id,
              episode: episode.episode,
              latLng: episode.latLng,
            ))
        .toList();
  }

  final MapRepository _mapRepository = MapRepository();

  Position? _currentPosition;
  int _distance = 0;
  final Completer<GoogleMapController> _reExperienceMapController = Completer();
  final Memory _currentMemory;
  late List<SubEpisode> _subEpisodeList = [];

  final BuildContext _context;

  StreamSubscription<Position>? _positionStream;

  Position? get currentPosition => _currentPosition;

  int get distance => _distance;

  Completer<GoogleMapController> get reExperienceMapController =>
      _reExperienceMapController;

  Memory get currentMemory => _currentMemory;

  List<SubEpisode> get subEpisodeList => _subEpisodeList;

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
        LatLng(currentPosition.latitude, currentPosition.longitude),
        _subEpisodeList[i].latLng,
      );
    }
  }

  void checkDistance() {
    for (SubEpisode subEpisode in _subEpisodeList) {
      if (!subEpisode.isViewed && subEpisode.distance <= 100) {
        viewSubEpisode(subEpisode.id);
        showSubEpisodeDialog();
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

  // メインエピソードと自分の位置の中間をカメラ位置に設定してる。
  LatLng getCameraPosition() {
    final latitude =
        (_currentPosition!.latitude + _currentMemory.latLng.latitude) / 2;
    final longitude =
        (_currentPosition!.longitude + _currentMemory.latLng.longitude) / 2;
    return LatLng(latitude, longitude);
  }

  void showSubEpisodeDialog() {
    showDialog(
      context: _context,
      builder: (_) => const AlertDialog(
        title: Text('サブエピソード'),
      ),
    );
  }

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
