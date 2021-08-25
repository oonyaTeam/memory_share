import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';

class ReExperienceViewModel with ChangeNotifier {
  ReExperienceViewModel() {
    _reExperienceMapController = Completer();

    getPosition();

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

  Position _currentPosition;
  int _distance = 0;
  Completer<GoogleMapController> _reExperienceMapController;
  Memory _currentMemory;

  StreamSubscription<Position> _positionStream;

  Position get currentPosition => _currentPosition;

  int get distance => _distance;

  Completer<GoogleMapController> get reExperienceMapController =>
      _reExperienceMapController;

  Memory get currentMemory => _currentMemory;

  void setCurrentMemory(Memory memory) {
    _currentMemory = memory;
  }

  void getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  Future<void> setDistance() async {
    if (_currentPosition == null || _currentMemory == null) return;

    _distance = await _mapRepository.getDistance(_currentMemory);
    notifyListeners();
  }

  void setReExperienceMapController(GoogleMapController controller) {
    _reExperienceMapController.complete(controller);
    notifyListeners();
  }

  changeMapMode(GoogleMapController controller) {
    getMapStyleJsonFile("assets/Light.json")
        .then((res) => {controller.setMapStyle(res)});
  }

  Future<String> getMapStyleJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }
}
