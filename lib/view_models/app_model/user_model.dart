import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UserModel with ChangeNotifier {
  UserModel() {
    _userStream = FirebaseAuth.instance.authStateChanges().listen((User user) {
      User _currentUser = user;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userStream.cancel();
  }

  UserRepository _userRepository;

  StreamSubscription<User> _userStream;

  User _currentUser;

  bool _reExperienceTutorialDone;
  bool _postTutorialDone;

  User get currentUser => _currentUser;

  bool get reExperienceTutorialDone => _reExperienceTutorialDone;

  bool get postTutorialDone => _postTutorialDone;

  void reExperienceTutorialIsFinished() =>
      _userRepository.reExperienceTutorialIsFinished();

  void postTutorialIsFinished() => _userRepository.postTutorialIsFinished();
}
