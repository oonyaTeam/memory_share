import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget toast() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: newTheme().primary
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check),
        const SizedBox(
          width: 12.0,
        ),
        const Text("This is a Custom Toast"),
      ],
    ),
  );
}



