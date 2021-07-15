import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class MarkerData {
  String markerId;
  LatLng position;

  MarkerData(this.markerId, this.position);
}

class MapModel with ChangeNotifier {
  MapModel() {
    _homeMapController = Completer();
    _reExperienceMapController = Completer();

    List<Memory> sampleMemories = [
      Memory(
        memory: "this is sample memory1",
        latLng: const LatLng(34.8532, 136.5822),
        seenAuthor: ["author1"],
        episodes: [],
        image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author1",
      ),
      Memory(
        memory: "this is sample memory2",
        latLng: const LatLng(34.8480, 136.5756),
        seenAuthor: ["author2"],
        episodes: [],
        image: "https://pbs.twimg.com/media/E6CYtu1VcAIjMvY?format=jpg&name=large",
        author: "author2",
      ),
    ];
    setMemories(sampleMemories);

    getPosition();

    getMemory();

    _positionStream = Geolocator.getPositionStream(
            intervalDuration: const Duration(seconds: 5))
        .listen((Position position) {
      _currentPosition = position;
      if (_currentMemory != null) {
        setDistance();
      }
      notifyListeners();
    });
  }

  // MarkerData _currentMarker;
  // final List<MarkerData> _markers = [];
  Position _currentPosition;
  double _distance = 0.0;
  Completer<GoogleMapController> _homeMapController;
  Completer<GoogleMapController> _reExperienceMapController;
  final List<Memory> _memories = [];
  Memory _currentMemory;

  StreamSubscription<Position> _positionStream;

  // MarkerData get currentMarker => _currentMarker;
  //
  // List<MarkerData> get markers => _markers;

  Position get currentPosition => _currentPosition;

  double get distance => _distance;

  Completer<GoogleMapController> get homeMapController => _homeMapController;

  Completer<GoogleMapController> get reExperienceMapController =>
      _reExperienceMapController;

  List<Memory> get memories => _memories;

  Memory get currentMemory => _currentMemory;

  // void setCurrentMarker(MarkerData marker) {
  //   _currentMarker = marker;
  //   notifyListeners();
  // }

  // void setMarker(MarkerData marker) {
  //   _markers.add(marker);
  //   notifyListeners();
  // }
  //
  // void setMarkers(List<MarkerData> markers) {
  //   _markers.addAll(markers.toSet());
  //   notifyListeners();
  // }

  void setCurrentMemory(Memory memory) {
    _currentMemory = memory;
    notifyListeners();
  }

  void setMemory(Memory memory) {
    _memories.add(memory);
    notifyListeners();
  }

  void setMemories(List<Memory> memories) {
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
    notifyListeners();
  }

  void setDistance() {
    if (_currentPosition == null || _currentMemory == null) return;

    _distance = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _currentMemory.latLng.latitude,
      _currentMemory.latLng.longitude,
    );
    notifyListeners();
  }

  void setHomeMapController(GoogleMapController controller) {
    _homeMapController.complete(controller);
    notifyListeners();
  }

  void setReExperienceMapController(GoogleMapController controller) {
    _reExperienceMapController.complete(controller);
    notifyListeners();
  }

  void getMemory() async {
    // TODO: 仮の値
    final memories = await fetchMemories(
      lowerLeft: 10,
      lowerRight: 10,
      upperLeft: 50,
      upperRight: 50,
    );
    setMemories(memories);
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }
}
