import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class LoginViewModel with ChangeNotifier {

  LoginViewModel(this._authRepository);

  final AuthRepository _authRepository;

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

  Future<void> loginWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) throw Error();

    await _authRepository.login(_email, _password);
  }

  Future<void> loginWithGoogle() async {
    await _authRepository.loginWithGoogle();
  }

  Future<void> loginWithTwiiter() async {
    await _authRepository.loginWithTwitter();
  }

  bool validateEmail() => true;

  bool validatePassword() => true;
}
