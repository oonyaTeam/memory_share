import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UpdateMailAddressViewModel with ChangeNotifier {

  UpdateMailAddressViewModel();

  final AuthRepository _authRepository = AuthRepository();

  String _newEmail = "";

  String get newEmail => _newEmail;


  void changeNewEmail(String email) {
    _newEmail = email;
    notifyListeners();
  }

  Future<void> updateEmail() async {
    if (!validateNewEmail()) throw Error();

    await _authRepository.updateEmail(_newEmail);
  }

  bool validateNewEmail() => true;

}
