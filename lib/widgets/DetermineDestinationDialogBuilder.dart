import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/models/MapModel.dart';
import 'package:memory_share/pages/re_experience_page.dart';
import 'package:provider/provider.dart';

// DetermineDestinationDialog (マーカーを設定するか確認するダイアログ)

Widget DetermineDestinationDialogBuilder({
  BuildContext context,
}) {
  final mapModel = context.watch<MapModel>();
  return AlertDialog(
    title: Text("この場所を目的地に設定しますか？"),
    content: Text('目的地までの距離は、${mapModel.distance}mです。'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          mapModel.disposeController();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReExperiencePage(
                marker: Marker(
                  markerId: MarkerId(mapModel.currentMarker.markerId),
                  position: mapModel.currentMarker.position,
                  infoWindow: InfoWindow(
                    title: mapModel.currentMarker.markerId,
                    snippet: 'text',
                  ),
                ),
              ),
            ),
          );
        },
        child: Text("OK"),
      )
    ],
  );
}
