import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';

class EmailPasswordBox extends StatelessWidget {
  const EmailPasswordBox({
    Key? key,
    required this.iconData,
    required this.topText,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final String topText;
  final Function onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(
                color: CustomColors.deep,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.0,
              ),
            ),
          ),
        ),
        // メールアドレス、パスワードを入力する部分
        SizedBox(
          width: width - 48,
          height: 70,
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(iconData, color: CustomColors.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                      const BorderSide(width: 0, style: BorderStyle.none),
                ),
                filled: true,
                fillColor:
                    Color.alphaBlend(CustomColors.primaryPale, Colors.white),
              ),
              validator: (value) {
                return Validator.validate(kind: iconData, value: value);
              },
              obscureText: obscureTextFlag,
              onChanged: (text) => onChanged(text),
            ),
          ),
        ),
      ],
    );
  }
}
