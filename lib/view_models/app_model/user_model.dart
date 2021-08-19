import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class UserModel with ChangeNotifier {
  UserModel() {
    _userStream = FirebaseAuth.instance.authStateChanges().listen((User user) {
      _currentUser = user;
      getMyMemories();

      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userStream.cancel();
  }

  final UserRepository _userRepository = UserRepository();

  final PostRepository _postRepository = PostRepository();

  StreamSubscription<User> _userStream;

  User _currentUser;

  bool _reExperienceTutorialDone;
  bool _postTutorialDone;

  List<Memory> _myMemories;

  User get currentUser => _currentUser;

  bool get reExperienceTutorialDone => _reExperienceTutorialDone;

  bool get postTutorialDone => _postTutorialDone;

  List<Memory> get myMemories => _myMemories;

  void reExperienceTutorialIsFinished() async {
    await _userRepository.reExperienceTutorialIsFinished();
    notifyListeners();
  }

  void postTutorialIsFinished() async {
    await _userRepository.postTutorialIsFinished();
    notifyListeners();
  }

  void getMyMemories() async {
    if(_currentUser == null) return;
    _myMemories = await _postRepository.getMyMemories(_currentUser.uid);
    notifyListeners();
  }

  void addMymemories(Memory memory) async {
    _myMemories.add(memory);
    notifyListeners();
  }
}