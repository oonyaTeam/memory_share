import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:provider/provider.dart';

// DetermineDestinationDialog (マーカーを設定するか確認するダイアログ)

Widget determineDestinationDialogBuilder({
  BuildContext context,
}) {
  final mapModel = context.watch<MapModel>();
  return AlertDialog(
    title: const Text("この場所を目的地に設定しますか？"),
    content: Text('目的地までの距離は、${mapModel.distance}mです。'),
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
              builder: (context) => const ReExperiencePage(),
            ),
          );
        },
        child: const Text("OK"),
      )
    ],
  );
}
