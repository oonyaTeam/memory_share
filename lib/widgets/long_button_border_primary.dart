import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class LongButtonBorderPrimary extends StatelessWidget {
  const LongButtonBorderPrimary({
    required this.label,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 346.0,
      height: 48.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: const BorderSide(color: CustomColors.primary, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          primary: Colors.white,
          onPrimary: CustomColors.primary,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
