import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/utils/utils.dart';

import 'auth_service.dart';

class MapService {
  Future<List<Memory>> getMemories() async {
    final String idToken = await AuthService().getIdToken();
    // サンプルの値
    final memories = await fetchMemories(
      lowerLeft: 10,
      lowerRight: 10,
      upperLeft: 50,
      upperRight: 50,
      idToken: idToken,
      client: http.Client(),
    );
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
