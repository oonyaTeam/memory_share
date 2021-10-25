import 'package:geocoding/geocoding.dart';
import 'package:memory_share/models/models.dart' as models;

Future<String> getAddressFromLocation(models.Location location) async {
  try {
    final List<Placemark> placeMarkList = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
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
