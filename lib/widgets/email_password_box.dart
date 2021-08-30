import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';

Widget emailPasswordBox({@required IconData iconData, @required String topText, @required var onChanged, @required double width}) {
  newTheme theme = newTheme();
  bool obscureTextFlag = false;

  if (iconData == Icons.https_outlined) {
    obscureTextFlag = true;
  }

  return Column(
    children: <Widget>[
      // email, passwordという文字の部分
      SizedBox(
        width: width - 48,
        child: Container(
          margin: const EdgeInsets.only(bottom: 4),
          child: Text(
            topText,
            style: TextStyle(
              color: theme.deep,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.0
            ),
          ),
        ),
      ),
      // メールアドレス、パスワードを入力する部分
      Container(
        width: width - 48 ,
        height: 48,
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: theme.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.none
              )
            ),
            filled: true,
            fillColor: Color.alphaBlend(theme.primaryPale, Colors.white),
          ),
          obscureText: obscureTextFlag,
          onChanged: (text) => onChanged(text),
        ),
      ),
    ],
  );
}
