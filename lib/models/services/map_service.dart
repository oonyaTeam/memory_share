import 'package:geolocator/geolocator.dart';
import 'package:memory_share/models/entities/entities.dart';
import 'package:memory_share/utils/utils.dart';

class MapService {
  Future<List<Memory>> getMemories() async {
    // サンプルの値
    final memories = await fetchMemories(
      lowerLeft: 10,
      lowerRight: 10,
      upperLeft: 50,
      upperRight: 50,
    );
    return memories;
  }

  ///　現在の位置と目的地との距離を返す
  Future<int> getDistance(Memory memory) async {
    final Position currentPosition = await Geolocator.getCurrentPosition();
    if (currentPosition == null || memory == null) throw Error();

    final int distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      memory.latLng.latitude,
      memory.latLng.longitude,
    ).toInt();
    return distance;
  }
}
