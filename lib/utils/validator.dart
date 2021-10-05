import 'package:flutter/material.dart';
import 'package:memory_share/utils/utils.dart';

class Validator {
  static String errorName = "";

  static String validate({required kind, required value}) {
    if (kind == Icons.email_outlined) {
      if (!(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$").hasMatch(value))) {
        return 'メールアドレスが正しくないです';
      }
    } else if (kind == Icons.https_outlined) {
      if (value.length < 8) {
        return '8文字以上にしてください';
      }
    }
    return '';
  }

  static void firebaseAuthLoginValidate({required BuildContext context, required String message}) {
    switch (message) {
      case "user-not-found":
        showCustomToast(context, 'ユーザーが見つかりません', false);
        break;
      case "invalid-email":
        showCustomToast(context, 'メールアドレスが間違っています', false);
        break;
      case "wrong-password":
        showCustomToast(context, 'パスワードが間違っています', false);
        break;
      default:
        showCustomToast(context, 'ログイン出来ませんでした', false);
        break;
    }
  }

  static void firebaseAuthSignUpValidate({required BuildContext context, required String message}) {
    switch (message) {
      case "email-already-in-use":
        showCustomToast(context, 'このメールアドレスは使用済みです', false);
        break;
      default:
        showCustomToast(context, '登録出来ませんでした', false);
        break;
    }
  }
}
