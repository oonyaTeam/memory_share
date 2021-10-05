import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng({
  required double latitude,
  required double longitude,
}) async {
  final List<Placemark> placeMarkList = await placemarkFromCoordinates(
    latitude,
    longitude,
    localeIdentifier: 'ja',
  );

  if (placeMarkList[0].street == null) return "";
  return placeMarkList[0].street!.split(' ')[1];
}
