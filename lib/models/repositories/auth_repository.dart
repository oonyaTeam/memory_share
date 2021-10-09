import 'package:firebase_auth/firebase_auth.dart';
import 'package:memory_share/models/services/auth_service.dart';

/// 認証に関する処理をまとめたRepository
class AuthRepository {
  final AuthService _authService = AuthService();

  /// Emailとパスワードでログインを行う。
  Future<User?> login(String email, String password) async {
    final User? user =
        await _authService.loginWithEmailAndPassword(email, password);
    if (user != null) {
      await _authService.postAuthor();
    }
    return user;
  }

  /// EmailとパスワードでSignUpを行う。
  /// ユーザの作成ができたときは、サーバーにauthorをポストするリクエストも投げる。
  Future<User?> signUp(String email, String password) async {
    final User? user =
        await _authService.signUpWithEmailAndPassword(email, password);
    if (user != null) {
      await _authService.postAuthor();
    }
    return user;
  }

  /// Googleでログインを行う。
  /// ユーザの作成ができたときは、サーバーにauthorをポストするリクエストも投げる。
  Future<User?> loginWithGoogle() async {
    final User? user = await _authService.loginWithGoogle();

    if (user != null) {
      await _authService.postAuthor();
    }
    return user;
  }

  /// Twitterでログインを行う。
  /// ユーザの作成ができたときは、サーバーにauthorをポストするリクエストも投げる。
  Future<User?> loginWithTwitter() async {
    final User? user = await _authService.loginWithTwitter();

    if (user != null) {
      await _authService.postAuthor();
    }
    return user;
  }

  /// ログアウトする。
  Future<void> logout() async {
    await _authService.logout();
  }

  /// Emailを更新する
  Future<void> updateEmail({
    required String newEmail,
    required String password,
  }) async {
    await _authService.updateEmail(
      newEmail: newEmail,
      password: password,
    );
  }

  /// PassWordを更新する
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
