import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget longButton(String buttonText, Function() tappedEvent) {
  return SizedBox(
    width: 346.0,
    height: 48.0,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16)
          )
        ),
        primary: CustomColors.primary,
        onPrimary: Colors.white,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => tappedEvent(),
    ),
  );
}
