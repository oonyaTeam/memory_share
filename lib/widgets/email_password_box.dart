import 'package:flutter/material.dart';
import 'package:memory_share/theme.dart';
import 'package:memory_share/utils/utils.dart';

// for alphabet label
class EmailPasswordBox extends StatelessWidget {
  const EmailPasswordBox({
    Key? key,
    required this.iconData,
    required this.type,
    required this.label,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final ValidatorType type;
  final String label;
  final void Function(String) onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // email, passwordという文字の部分
        SizedBox(
          width: width,
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
          type: type,
          onChanged: onChanged,
          width: width,
        ),
      ],
    );
  }
}

// for japanese label
class UpdateEmailPasswordBox extends StatelessWidget {
  const UpdateEmailPasswordBox({
    Key? key,
    required this.iconData,
    required this.type,
    required this.label,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final ValidatorType type;
  final String label;
  final void Function(String) onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // email, passwordという文字の部分
        SizedBox(
          width: width,
          child: Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1.0,
              ),
            ),
          ),
        ),
        // メールアドレス、パスワードを入力する部分
        EmailPasswordForm(
          iconData: iconData,
          type: type,
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
    required this.type,
    required this.onChanged,
    required this.width,
  }) : super(key: key);

  final IconData iconData;
  final ValidatorType type;
  final void Function(String) onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(iconData, color: CustomColors.primary),
            contentPadding: const EdgeInsets.all(0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            fillColor: Color.alphaBlend(CustomColors.primaryPale, Colors.white),
          ),
          validator: (value) {
            return Validator.validate(type: type, value: value);
          },
          obscureText: iconData == Icons.https_outlined,
          onChanged: (text) => onChanged(text),
        ),
      ),
    );
  }
}
