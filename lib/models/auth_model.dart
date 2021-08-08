import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthModel with ChangeNotifier {
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

  void signUpWithEmailAndPassword() async {
    final User user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    ))
            .user;
    setCurrentUser(user);
  }

  void loginWithEmailAndPassword() async {
    if (!validateEmail() || !validatePassword()) return;

    final User user =
        (await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    ))
            .user;
    setCurrentUser(user);
  }

  bool validateEmail() => true;

  bool validatePassword() => true;
}
