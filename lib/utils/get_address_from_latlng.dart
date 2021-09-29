import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng({
  required double latitude,
  required double longitude,
}) async {
  final List<Placemark> placemarkList = await placemarkFromCoordinates(
    latitude,
    longitude,
    localeIdentifier: 'ja',
  );
  return placemarkList.map((placemark) => placemark.name ?? "").join(' ');
}
