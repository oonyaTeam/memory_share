
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_share/models/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<User> login(String email, String password) async {
    final User user = await _authService.loginWithEmailAndPassword(email, password);
    return user;
  }

  Future<User> signUp(String email, String password) async {
    final User user = await _authService.signUpWithEmailAndPassword(email, password);
    return user;
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  Future<void> updateEmail(String newEmail) async {
    await _authService.updateEmail(newEmail);
  }

  Future<void> updatePassword(String newPassword) async {
    await _authService.updatePassword(newPassword);
  }
}
