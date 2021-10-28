import 'package:geolocator/geolocator.dart';
import 'package:memory_share/models/models.dart';

class LocationService {
  Future<Location> getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition();
    return Location.fromPosition(position);
  }
}
