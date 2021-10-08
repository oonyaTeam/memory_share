import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';

class EmailPasswordBox extends StatelessWidget {
  const EmailPasswordBox({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final String label;
  final Function onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // email, passwordという文字の部分
        SizedBox(
          width: width - 24,
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              label,
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
        EmailPasswordForm(
          iconData: iconData,
          onChanged: onChanged,
          width: width,
        ),
      ],
    );
  }
}

class EmailPasswordForm extends StatelessWidget {
  const EmailPasswordForm({
    Key? key,
    required this.iconData,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final Function onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 24,
      height: 48,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: CustomColors.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            fillColor: Color.alphaBlend(CustomColors.primaryPale, Colors.white),
          ),
          validator: (value) {
            return Validator.validate(kind: iconData, value: value);
          },
          obscureText: iconData == Icons.https_outlined,
          onChanged: (text) => onChanged(text),
        ),
      ),
    );
  }
}
