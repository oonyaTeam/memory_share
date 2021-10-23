import 'package:flutter/material.dart';

class VariableButton extends StatelessWidget {
  const VariableButton({
    required this.label,
    required this.onPressed,
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
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
