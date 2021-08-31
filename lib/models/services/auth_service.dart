import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/entity/auth_result.dart';
import 'package:twitter_login/twitter_login.dart';

/// Firebase Authに関する処理をまとめたService
class AuthService {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  final TwitterLogin twitterLogin = TwitterLogin(
    apiKey: FlutterConfig.get("TWITTER_API_KEY"),
    apiSecretKey: FlutterConfig.get("TWITTER_API_SECRET_KEY"),
    redirectURI: 'memory-share://',
  );

  /// EmailとPasswordを使ってユーザ登録を行い、登録したユーザーを返す。
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    final User user = (await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  /// EmailとPasswordを使ってログインを行い、ログインしたユーザーを返す。
  Future<User> loginWithEmailAndPassword(String email, String password) async {
    final User user = (await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    return user;
  }

  /// Googleアカウントでログインを行い、ログインしたユーザーを返す。
  /// Google, Twitterは、一度Google, Twitter自体のログインを行い、それが成功したら、
  /// アカウント登録の処理を行うという流れになっている。
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

  /// Googleアカウントでログインを行い、ログインしたユーザーを返す。
  /// Googleと同様、Twitter自体のログインを行い、それが成功したら、アカウント登録の処理を行うという流れになっている。
  Future<User> loginWithTwitter() async {
    final AuthResult authResult = await twitterLogin.login();

    // ログインのステータスによって胃処理を分けてる。
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        final credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken,
          secret: authResult.authTokenSecret,
        );
        final User user =
            (await _instance.signInWithCredential(credential)).user;
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

  /// ログアウトの処理（ここは全プロバイダ統一だと思います。）
  Future<void> logout() async {
    await _instance.signOut();
  }

  /// 再認証を行う。
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

  /// Emailを更新するには再認証が必要なので、
  /// 一度を[_reAuthentication]を呼び出してから更新の処理を行っている。
  Future<void> updateEmail({
    @required String newEmail,
    @required String password,
  }) async {
    final UserCredential userCredential = await _reAuthentication(password);

    await userCredential.user.updateEmail(newEmail);
  }

  /// [updateEmail]と同様に、一度再認証を行ってから、更新処理を行っている。
  Future<void> updatePassword({
    @required String newPassword,
    @required String oldPassword,
  }) async {
    final UserCredential userCredential = await _reAuthentication(oldPassword);

    await userCredential.user.updatePassword(newPassword);
  }
}
