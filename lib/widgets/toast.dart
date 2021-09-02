import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget toast(String text, bool isSuccessed) {
  IconData icon = isSuccessed ? Icons.check : Icons.close;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isSuccessed ? CustomColors.success : CustomColors.error),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}
