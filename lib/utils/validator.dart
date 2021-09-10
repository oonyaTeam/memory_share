import 'package:flutter/material.dart';

class Validator {
  static String validate({required kind, required value}) {
    if (kind == Icons.email_outlined) {
      if (value.indexOf('@') < 1) {
        return '@がないです';
      }
    } else if (kind == Icons.https_outlined) {
      if (value.length < 8) {
        return '8文字以上にしてください';
      }
    }
    return '';
  }
}
