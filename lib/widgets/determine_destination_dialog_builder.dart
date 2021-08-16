import 'package:flutter/material.dart';
import 'package:memory_share/pages/pages.dart';
import 'package:memory_share/view_models/view_models.dart';
import 'package:provider/provider.dart';

// DetermineDestinationDialog (マーカーを設定するか確認するダイアログ)

Widget determineDestinationDialogBuilder({
  @required BuildContext context,
}) {
  final homeViewModel = context.watch<HomeViewModel>();
  return AlertDialog(
    title: const Text("この場所を目的地に設定しますか？"),
    content: Text('目的地までの距離は、${homeViewModel.distance}mです。'),
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
