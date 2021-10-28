import 'package:memory_share/models/models.dart';

class LocationRepository {
  final LocationService _locationService = LocationService();

  Future<Location> getCurrentLocation() async =>
      await _locationService.getCurrentLocation();
}
