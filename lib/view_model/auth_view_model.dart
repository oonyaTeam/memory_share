import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {

  AuthViewModel() {
    _currentUser = FirebaseAuth.instance.currentUser;
  }

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
    if (!validateEmail() || !validatePassword()) throw Error();

    final User user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
        .user;
    setCurrentUser(user);
  }

  Future<void> loginWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) throw Error();

    final User user =
      (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      ))
        .user;
    setCurrentUser(user);
  }

  bool validateEmail() => true;

  bool validatePassword() => true;
}
