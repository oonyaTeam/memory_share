import 'package:flutter/material.dart';
import 'package:memory_share/pages/re_experience_page.dart';


// DetermineDestinationDialog (マーカーを設定するか確認するダイアログを表示

Widget DetermineDestinationDialogBuilder(BuildContext context, String distance) {
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReExperiencePage()));
        },
        child: Text("OK"),
      )
    ],
  );
}