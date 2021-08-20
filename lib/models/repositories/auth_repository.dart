import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:memory_share/models/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<User> login(String email, String password) async {
    final User user =
        await _authService.loginWithEmailAndPassword(email, password);
    return user;
  }

  Future<User> signUp(String email, String password) async {
    final User user =
        await _authService.signUpWithEmailAndPassword(email, password);
    return user;
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> updateEmail({
    @required String newEmail,
    @required String password,
  }) async {
    await _authService.updateEmail(
      newEmail: newEmail,
      password: password,
    );
  }

  Future<void> updatePassword({
    @required String newPassword,
    @required String oldPassword,
  }) async {
    await _authService.updatePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
  }
}
