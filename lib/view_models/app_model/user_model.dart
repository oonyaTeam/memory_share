import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UserModel with ChangeNotifier {
  UserModel();

  UserRepository _userRepository;

  User _currentUser;

  bool _reExperienceTutorialDone;
  bool _postTutorialDone;

  User get currentUser => _currentUser;
  bool get reExperienceTutorialDone => _reExperienceTutorialDone;
  bool get postTutorialDone => _postTutorialDone;

  void reExperienceTutorialIsFinished() =>
    _userRepository.reExperienceTutorialIsFinished();
}
