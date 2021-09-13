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

    _positionStream = Geolocator.getPositionStream(
      intervalDuration: const Duration(seconds: 5),
    ).listen((Position position) {
      _currentPosition = position;
      if (_currentMemory != null) {
        setDistance();
      }
    });
  }

  final MapRepository _mapRepository = MapRepository();

  Position? _currentPosition;
  int _distance = 0;
  final Completer<GoogleMapController> _homeMapController = Completer();
  final List<Memory> _memories = [];
  Memory? _currentMemory;

  StreamSubscription<Position>? _positionStream;

  Position? get currentPosition => _currentPosition;

  int get distance => _distance;

  Completer<GoogleMapController> get homeMapController => _homeMapController;

  List<Memory> get memories => _memories;

  Memory? get currentMemory => _currentMemory;

  void setCurrentMemory(Memory memory) {
    _currentMemory = memory;
    setDistance();
  }

  void addMemory(Memory memory) {
    _memories.add(memory);
    notifyListeners();
  }

  void addMemories(List<Memory> memories) {
    _memories.addAll(memories);
    notifyListeners();
  }

  void clearMemories() {
    _memories.clear();
    notifyListeners();
  }

  void getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
  }

  void setDistance() {
    if (_currentPosition == null || _currentMemory == null) return;

    _distance = _mapRepository.getDistance(
      _currentMemory!.latLng,
      LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
    );
    notifyListeners();
  }

  void setHomeMapController(GoogleMapController controller) {
    _homeMapController.complete(controller);
    notifyListeners();
  }

  void getMemories() async {
    final memories = await _mapRepository.getMemories();
    addMemories(memories);
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
    _positionStream?.cancel();
  }
}
