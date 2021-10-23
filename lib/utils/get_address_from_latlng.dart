import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromLatLng({
  required double latitude,
  required double longitude,
}) async {
  try {
    final List<Placemark> placeMarkList = await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: 'ja',
    );

    if (placeMarkList[0].street == null) return "";

    // ex: 'XX県XX市
    return (placeMarkList[0].administrativeArea ?? "") +
        (placeMarkList[0].locality ?? "");
    // ex: 'XX県XX市XX町0-0-0'
    // return placeMarkList[0].street!.split(' ')[1];

  } catch (e) {
    return "";
  }
}
