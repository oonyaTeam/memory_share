import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget textBox(IconData iconData, String topText, var textBoxFunc) {
  newTheme theme = newTheme();
  bool obscureTextFlag = false;

  if (topText == "Password") {
    obscureTextFlag = true;
  }

  return Column(
    children: <Widget>[
      const SizedBox(height: 24),
      SizedBox(
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.only(left: 24, bottom: 4),
          child: Text(
            topText,
            style: TextStyle(
              color: theme.deep,
              fontSize: 18,
            ),
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: theme.primary),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            filled: true,
            fillColor: Color.alphaBlend(theme.primaryPale, Colors.white),
          ),
          obscureText: obscureTextFlag,
          onChanged: (text) => textBoxFunc(text),
        ),
      ),
    ],
  );
}