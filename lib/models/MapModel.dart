
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel with ChangeNotifier {

  Marker _currentMarker;
  List<Marker> _markers = [];
  Position _currentPosition;
  double _distance = 0.0;
  double _sigma = 10.0;
  Completer<GoogleMapController> _controller = Completer();

  StreamSubscription<Position> _positionStream;

  Marker get currentMarker => _currentMarker;
  List<Marker> get markers => _markers;
  Position get currentPosition => _currentPosition;
  double get distance => _distance;
  double get sigma => _sigma;
  Completer<GoogleMapController> get controller => _controller;

  MapModel() {
    _positionStream =
      Geolocator.getPositionStream().listen((Position position) {
          _currentPosition = position;
          if (_currentMarker != null) {
            setDistance();
          }
          notifyListeners();
      });
  }

  void setCurrentMarker(Marker marker) {
    _currentMarker = marker;
    notifyListeners();
  }

  void setMarker(Marker marker) {
    _markers.add(marker);
  }

  void setMarkers(List<Marker> markers) {
    _markers.addAll(markers.toSet());
  }

  void getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  void setDistance() {
    _distance = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _currentMarker.position.latitude,
      _currentMarker.position.longitude,
    );
  }

  void setMapController(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void dispose() {
    super.dispose();
    _positionStream.cancel();
  }

}