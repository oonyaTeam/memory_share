import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    final User user = (await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final User user = (await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  Future<User> loginWithGoogle() async {
    GoogleSignInAccount signInAccount = await GoogleSignIn().signIn();
    if(signInAccount == null) throw Error();

    GoogleSignInAuthentication auth = await signInAccount.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    User user = (await _instance.signInWithCredential(credential)).user;
    return user;
  }

  Future<void> logout() async {
    await _instance.signOut();
  }

  Future<UserCredential> _reAuthentication(String password) async {
    final user = _instance.currentUser;
    final UserCredential userCredential = await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: user.email,
        password
          : password,
      ),
    );
    return userCredential;
  }

  Future<void> updateEmail({
    @required String newEmail,
    @required String password,
  }) async {
    final UserCredential userCredential = await _reAuthentication(password);

    await userCredential.user.updateEmail(newEmail);
  }

  Future<void> updatePassword({
    @required String newPassword,
    @required String oldPassword,
  }) async {
    final UserCredential userCredential = await _reAuthentication(oldPassword);

    await userCredential.user.updatePassword(newPassword);
  }
}
