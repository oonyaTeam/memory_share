import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';
import 'package:memory_share/utils/utils.dart';

class SignUpViewModel with ChangeNotifier {
  SignUpViewModel(this._authRepository);

  final AuthRepository _authRepository;

  String _email = "";
  String _password = "";

  String get email => _email;

  String get password => _password;

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) throw Error();

    await _authRepository.signUp(_email, _password);
  }

  Future<void> loginWithGoogle() async {
    await _authRepository.loginWithGoogle();
  }

  Future<void> loginWithTwitter() async {
    await _authRepository.loginWithTwitter();
  }

  bool validateEmail() =>
      Validator.validate(type: ValidatorType.email, value: _email) == '';

  bool validatePassword() =>
      Validator.validate(type: ValidatorType.password, value: _password) == '';
}
