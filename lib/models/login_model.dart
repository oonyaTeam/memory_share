import 'package:flutter/material.dart';

class LoginModel with ChangeNotifier {
  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  void changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  bool validateEmail() => true;
  bool validatePassword() => true;
}