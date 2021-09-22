import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class SettingViewModel with ChangeNotifier {
  SettingViewModel();

  final AuthRepository _authRepository = AuthRepository();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
