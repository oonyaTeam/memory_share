import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/utils/utils.dart';

class MapService {
  Future<List<Memory>> getMemories() async {
    // サンプルの値
    final memories = await fetchMemories(10, 10, 50, 50, http.Client());
    return memories;
  }

  Future<Position> getCurrentPosition() => Geolocator.getCurrentPosition();

  int getDistance(LatLng startLatLng, LatLng endLatLng) {
    return Geolocator.distanceBetween(
      startLatLng.latitude,
      startLatLng.longitude,
      endLatLng.latitude,
      endLatLng.longitude,
    ).toInt();
  }
}
