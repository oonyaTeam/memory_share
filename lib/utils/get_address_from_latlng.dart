import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng({
  required double latitude,
  required double longitude,
}) async {
  final List<Placemark> placeMarkList = await placemarkFromCoordinates(
    latitude,
    longitude,
  );
  return placeMarkList.map((placeMark) => placeMark.name ?? "").join(' ');
}
