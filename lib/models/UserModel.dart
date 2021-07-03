
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel with ChangeNotifier {

  Marker _currentMarker;

  Marker get currentMarker => _currentMarker;

  void setCurrentMarker(Marker marker) {
    _currentMarker = marker;

    notifyListeners();
  }
}