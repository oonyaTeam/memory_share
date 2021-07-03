import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:memory_share/pages/re_experience_page.dart';


// DetermineDestinationDialog (マーカーを設定するか確認するダイアログ)

Widget DetermineDestinationDialogBuilder(BuildContext context, double distance, Function onSubmit, Marker marker) {
  return AlertDialog(
    title: Text("この場所を目的地に設定しますか？"),
    content: Text('目的地までの距離は、${distance}mです。'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          onSubmit();
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReExperiencePage(marker: marker,)));
        },
        child: Text("OK"),
      )
    ],
  );
}