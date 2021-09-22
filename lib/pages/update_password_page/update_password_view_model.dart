import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UpdatePasswordViewModel with ChangeNotifier {
  UpdatePasswordViewModel();

  final AuthRepository _authRepository = AuthRepository();

  final ScrollController _controller = ScrollController();
  ScrollController get controller => _controller;

  String _oldPassword = "";
  String _newPassword = "";
  String _newPasswordForConfirmation = "";

  void changeOldPassword(String password) {
    _oldPassword = password;
    notifyListeners();
  }

  void changeNewPassword(String password) {
    _newPassword = password;
    notifyListeners();
  }

  void changeNewPasswordForConfirmation(String password) {
    _newPasswordForConfirmation = password;
    notifyListeners();
  }

  Future<void> updatePassword() async {
    if (!validateNewPassword()) throw Error();

    if (_newPassword != _newPasswordForConfirmation) throw Error();

    await _authRepository.updatePassword(
      newPassword: _newPassword,
      oldPassword: _oldPassword,
    );
  }

  bool validateNewPassword() => true;
}
