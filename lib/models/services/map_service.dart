import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:memory_share/models/models.dart';
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

  int getDistance(Location start, Location end) {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    ).toInt();
  }
}
