import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  final TwitterLogin twitterLogin = TwitterLogin(
    apiKey: FlutterConfig.get("TWITTER_API_KEY"),
    apiSecretKey: FlutterConfig.get("TWITTER_API_SECRET_KEY"),
    redirectURI: 'memory-share://',
  );

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
    if (signInAccount == null) throw Error();

    GoogleSignInAuthentication auth = await signInAccount.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    User user = (await _instance.signInWithCredential(credential)).user;
    return user;
  }

  Future<User> loginWithTwitter() async {
    final AuthResult authResult = await twitterLogin.login();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken,
          secret: authResult.authTokenSecret,
        );
        final User user = (await _instance.signInWithCredential(credential)).user;
        return user;
        break;
      case TwitterLoginStatus.cancelledByUser:
        // ユーザーがキャンセルした
      throw Error();
        break;
      case TwitterLoginStatus.error:
        // error
        throw Error();
        break;
    }
  }

  Future<void> logout() async {
    await _instance.signOut();
  }

  Future<UserCredential> _reAuthentication(String password) async {
    final user = _instance.currentUser;
    final UserCredential userCredential =
        await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(
        email: user.email,
        password: password,
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
