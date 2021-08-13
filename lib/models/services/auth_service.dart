
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    final User user =
      (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
        .user;
    return user;
  }

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final User user =
      (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
        .user;
    return user;
  }
}