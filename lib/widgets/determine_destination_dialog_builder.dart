import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/view_models.dart';

// DetermineDestinationDialog (マーカーを設定するか確認するダイアログ)

Widget determineDestinationDialogBuilder({
  @required BuildContext context,
  @required HomeViewModel model,
}) {
  return AlertDialog(
    title: const Text("この場所を目的地に設定しますか？"),
    content: Text('目的地までの距離は、${model.distance}mです。'),
    actions: [
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReExperiencePage(currentMemory: model.currentMemory,),
            ),
          );
        },
        child: const Text("OK"),
      )
    ],
  );
}
