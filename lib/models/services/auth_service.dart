
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _instance = FirebaseAuth.instance;

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    final User user =
      (await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
        .user;
    return user;
  }

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final User user =
      (await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
        .user;
    return user;
  }

  Future<void> logout() async {
    await _instance.signOut();
  }

  Future<void> updateEmail(String newEmail) async {
    await _instance.currentUser.updateEmail(newEmail);
  }

  Future<void> updatePassword(String newPassword) async {
    await _instance.currentUser.updatePassword(newPassword);
  }
}