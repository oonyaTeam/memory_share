
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_share/models/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future login(String email, String password) async {
    final User user = await _authService.loginWithEmailAndPassword(email, password);
    return user;
  }
}
