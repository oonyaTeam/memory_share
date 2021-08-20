import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UpdateMailAddressViewModel with ChangeNotifier {

  UpdateMailAddressViewModel();

  final AuthRepository _authRepository = AuthRepository();

  String _newEmail = "";
  String _password = "";

  void changeNewEmail(String email) {
    _newEmail = email;
    notifyListeners();
  }

  void changePassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> updateEmail() async {
    if (!validateNewEmail()) throw Error();

    await _authRepository.updateEmail(
      newEmail: _newEmail,
      password: _password,
    );
  }

  bool validateNewEmail() => true;
}
