import 'package:flutter/material.dart';

class VariableColorButton extends StatelessWidget {
  const VariableColorButton({
    required this.label,
    this.onPressed,
    required this.width,
    required this.height,
    required this.primary,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  final double width;
  final double height;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: primary,
          onPrimary: Colors.white,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
