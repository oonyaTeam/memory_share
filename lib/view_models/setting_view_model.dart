import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class SettingViewModel with ChangeNotifier {

  SettingViewModel();

  final AuthRepository _authRepository = AuthRepository();

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
