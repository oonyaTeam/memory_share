import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_share/models/services/auth_service.dart';

/// 認証に関する処理をまとめたRepository
class AuthRepository {
  final AuthService _authService = AuthService();

  Future<User?> login(String email, String password) =>
      _authService.loginWithEmailAndPassword(email, password);

  Future<User?> signUp(String email, String password) async =>
      _authService.signUpWithEmailAndPassword(email, password);

  Future<User?> loginWithGoogle() => _authService.loginWithGoogle();

  Future<User?> loginWithTwitter() => _authService.loginWithTwitter();

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    await _authService.updateEmail(
      newEmail: newEmail,
      password: password,
    );
  }

  Future<void> updatePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    await _authService.updatePassword(
      newPassword: newPassword,
      oldPassword: oldPassword,
    );
  }
}
