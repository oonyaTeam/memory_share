
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
  List<MarkerData> _markers = [];
  Position _currentPosition;
  double _distance = 0.0;
  double _sigma = 10.0;
  Completer<GoogleMapController> _controller = Completer();

  StreamSubscription<Position> _positionStream;

  MarkerData get currentMarker => _currentMarker;
  List<MarkerData> get markers => _markers;
  Position get currentPosition => _currentPosition;
  double get distance => _distance;
  double get sigma => _sigma;
  Completer<GoogleMapController> get controller => _controller;

  MapModel() {
    getPosition();

    _positionStream =
      Geolocator.getPositionStream(intervalDuration: Duration(seconds: 5)).listen((Position position) {
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

  void setMapController(GoogleMapController controller) {
    _controller.complete(controller);

    notifyListeners();
  }

  void disposeController() async {
    var controller = await _controller.future;
    controller.dispose();
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
    disposeController();
  }

}