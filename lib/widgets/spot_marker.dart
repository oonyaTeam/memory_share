import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker spotMarker(String markerId, LatLng position, Function onTap) {
  return Marker(
    markerId: MarkerId(markerId),
    position: position,
    onTap: () => onTap,
    infoWindow: InfoWindow(
      title: markerId,
      snippet: 'text',
    ),
  );
}
