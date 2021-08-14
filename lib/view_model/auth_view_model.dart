import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class AuthViewModel with ChangeNotifier {

  AuthViewModel(this._authRepository) {
    _currentUser = FirebaseAuth.instance.currentUser;
  }

  final AuthRepository _authRepository;

  String _email = "";
  String _password = "";
  User _currentUser;

  String get email => _email;

  String get password => _password;

  User get currentUser => _currentUser;

  void changeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) return;

    final User user = await _authRepository.login(_email, _password);
    setCurrentUser(user);
  }

  Future<void> loginWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) throw Error();

    final User user = await _authRepository.signUp(_email, _password);
    setCurrentUser(user);
  }

  bool validateEmail() => true;

  bool validatePassword() => true;
}
