import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class LongButton extends StatelessWidget {
  const LongButton({
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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          primary: CustomColors.primary,
          onPrimary: Colors.white,
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
