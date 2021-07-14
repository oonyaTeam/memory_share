
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerData {
  String markerId;
  LatLng position;

  MarkerData(this.markerId, this.position);
}

class MapModel with ChangeNotifier {

  MarkerData _currentMarker;
  final List<MarkerData> _markers = [];
  Position _currentPosition;
  double _distance = 0.0;
  Completer<GoogleMapController> _homeMapController;
  Completer<GoogleMapController> _reExperienceMapController;

  StreamSubscription<Position> _positionStream;

  MarkerData get currentMarker => _currentMarker;
  List<MarkerData> get markers => _markers;
  Position get currentPosition => _currentPosition;
  double get distance => _distance;
  Completer<GoogleMapController> get homeMapController => _homeMapController;
  Completer<GoogleMapController> get reExperienceMapController => _reExperienceMapController;

  MapModel() {

    _homeMapController = Completer();
    _reExperienceMapController = Completer();

    List<MarkerData> markers = [
      MarkerData('marker1', const LatLng(34.8532, 136.5822)),
      MarkerData('marker2', const LatLng(34.8480, 136.5756)),
    ];
    setMarkers(markers);

    getPosition();

    _positionStream =
      Geolocator.getPositionStream(intervalDuration: const Duration(seconds: 5)).listen((Position position) {
          _currentPosition = position;
          if (_currentMarker != null) {
            setDistance();
          }
          notifyListeners();
      });
  }

  void setCurrentMarker(MarkerData marker) {
    _currentMarker = marker;
    notifyListeners();
  }

  void setMarker(MarkerData marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void setMarkers(List<MarkerData> markers) {
    _markers.addAll(markers.toSet());
    notifyListeners();
  }

  void getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  void setDistance() {
    if(_currentPosition == null || _currentMarker == null ) return;

    _distance = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _currentMarker.position.latitude,
      _currentMarker.position.longitude,
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


  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }

}