import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

class SignInUpButton extends StatelessWidget {
  const SignInUpButton({
    required this.label,
    required this.onPressed,
    required this.width,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
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
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
