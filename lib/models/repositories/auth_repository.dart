import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:memory_share/models/services/auth_service.dart';

/// 認証に関する処理をまとめたRepository
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

  Future<User> loginWithGoogle() async {
    final User user = await _authService.loginWithGoogle();
    return user;
  }

  Future<User> loginWithTwitter() async {
    final User user = await _authService.loginWithTwitter();
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
