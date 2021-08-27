import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget episodePreview({@required String episodeText}) {
  return Container(
    color: newTheme().light.withOpacity(0.8),
    margin: const EdgeInsets.fromLTRB(80, 0, 80, 0),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(episodeText),
        ],
      ),
    ),
  );
}