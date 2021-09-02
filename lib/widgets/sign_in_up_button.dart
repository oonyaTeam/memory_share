import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget signInUpButton(String buttonText, Function() tappedEvent, double width) {
  return SizedBox(
    width: width - 48,
    height: 64,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        primary: CustomColors.primary,
        onPrimary: Colors.white,
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () => {
        tappedEvent(),
      },
    ),
  );
}
