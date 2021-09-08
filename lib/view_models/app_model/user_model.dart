import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memory_share/models/models.dart';

/// ユーザーに関することや、アプリの全体で参照したい値や処理をまとめてるViewModelです。
class UserModel with ChangeNotifier {
  UserModel() {
    // ユーザーの認証情報をlistenするように設定。
    _userStream = FirebaseAuth.instance.authStateChanges().listen((User user) {
      // 認証情報が変わった時は、currentUserの変更と、自分の投稿の取得を行っている。
      _currentUser = user;
      getMyMemories();
      notifyListeners();
    });

    /// 各チュートリアルを見たかどうかのbool値を取得している。
    /// `Future(() async{})` はコンストラクタ内で非同期処理を行う書き方。
    /// 実際はコンストラクタが非同期処理を待たずに終了してしまうので、[]
    Future(() async {
      _reExperienceTutorialDone =
          await _userRepository.getReExperienceTutorialDone();
      _postTutorialDone = await _userRepository.getPostTutorialDone();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userStream.cancel();
  }

  /// アプリ起動時に行う非同期処理（コンストラクタとは別に置いて、app.dartで呼び出す。
  Future<void> initialize() async {
    _reExperienceTutorialDone =
        await _userRepository.getReExperienceTutorialDone();
    _postTutorialDone = await _userRepository.getPostTutorialDone();
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  final UserRepository _userRepository = UserRepository();

  final PostRepository _postRepository = PostRepository();

  StreamSubscription<User> _userStream;

  User _currentUser;

  bool _reExperienceTutorialDone;
  bool _postTutorialDone;

  List<Memory> _myMemories = [];

  User get currentUser => _currentUser;

  bool get reExperienceTutorialDone => _reExperienceTutorialDone;

  bool get postTutorialDone => _postTutorialDone;

  List<Memory> get myMemories => _myMemories;

  /// チュートリアルが終了した際の処理。bool値を変更し、hive(永続化)の処理も呼び出す。
  Future<void> reExperienceTutorialIsFinished() async {
    await _userRepository.reExperienceTutorialIsFinished();
    _reExperienceTutorialDone = true;
    notifyListeners();
  }

  void postTutorialIsFinished() async {
    await _userRepository.postTutorialIsFinished();
    _postTutorialDone = true;
    notifyListeners();
  }

  /// 自分の投稿の一覧の取得
  void getMyMemories() async {
    if (_currentUser == null) return;
    _myMemories = await _postRepository.getMyMemories(_currentUser.uid);
    notifyListeners();
  }

  /// 投稿した際に、
  void addMyMemories(Memory memory) async {
    _myMemories.add(memory);
    notifyListeners();
  }

  /// ユーザがEmail＆パスワードでの認証をしているユーザかどうかの判定
  bool isEmailUser() {
    if (currentUser == null) return false;

    final UserInfo userInfo = _currentUser.providerData.firstWhere(
      (UserInfo userInfo) => userInfo.providerId == "password",
      orElse: () => null,
    );
    return userInfo != null;
  }

  /// 位置情報の取得の権限が許可されていたら true、拒否されたら false を返す。
  Future<bool> checkPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    switch (permission) {
      case LocationPermission.denied:
        return false;
      case LocationPermission.deniedForever:
        return false;
      case LocationPermission.whileInUse:
        return true;
      case LocationPermission.always:
        return true;
      default:
        return true;
    }
  }
}
