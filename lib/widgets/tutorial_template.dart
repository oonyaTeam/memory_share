import 'package:flutter/material.dart';

class TutorialTemplate extends StatelessWidget {
  const TutorialTemplate({
    required this.content,
    required this.text,
    Key? key,
  }) : super(key: key);

  final Widget content;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 400,
          child: content,
        ),
        const SizedBox(height: 64),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
