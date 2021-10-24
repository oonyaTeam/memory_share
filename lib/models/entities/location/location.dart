import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  factory Location.fromLatLng(LatLng latLng) => Location(
        latitude: latLng.latitude,
        longitude: latLng.longitude,
      );

  factory Location.fromPosition(Position position) => Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );

  LatLng toLatLng() => LatLng(latitude, longitude);
}
