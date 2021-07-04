
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapModel with ChangeNotifier {

  Marker _currentMarker;
  Position _currentPosition;
  StreamSubscription<Position> _positionStream;
  double _distance = 0.0;
  Completer<GoogleMapController> _controller = Completer();

  Marker get currentMarker => _currentMarker;
  Position get currentPosition => _currentPosition;
  double get distance => _distance;
  Completer<GoogleMapController> get controller => _controller;

  MapModel() {
    _positionStream =
      Geolocator.getPositionStream().listen((Position position) {
          _currentPosition = position;
          if (_currentMarker != null) {
            _setDistance();
          }
          notifyListeners();
      });
  }


  void setCurrentMarker(Marker marker) {
    _currentMarker = marker;
    notifyListeners();
  }

  void _getPosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();
    _currentPosition = currentPosition;
    notifyListeners();
  }

  void _setDistance() {
    _distance = Geolocator.distanceBetween(
      _currentPosition.latitude,
      _currentPosition.longitude,
      _currentMarker.position.latitude,
      _currentMarker.position.longitude,
    );
  }

}