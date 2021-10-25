import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memory_share/models/models.dart';

/// ユーザーに関することや、アプリの全体で参照したい値や処理をまとめてるViewModelです。
class UserModel with ChangeNotifier {
  UserModel() {
    // ユーザーの認証情報をlistenするように設定。
    _userStream = FirebaseAuth.instance.authStateChanges().listen((User? user) {
      // 認証情報が変わった時は、currentUserの変更と、自分の投稿の取得を行っている。
      _currentUser = user;
      getMyMemories();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userStream?.cancel();
  }

  /// アプリ起動時に行う非同期処理（コンストラクタとは別に置いて、app.dartで呼び出す。
  Future<void> initialize() async {
    // Local DB(Hive) から、チュートリアルを見たかのデータを取得
    _reExperienceTutorialDone =
        await _userRepository.getReExperienceTutorialDone();
    _postTutorialDone = await _userRepository.getPostTutorialDone();

    // currentUserを代入
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  final UserRepository _userRepository = UserRepository();
  final MemoryRepository _memoryRepository = MemoryRepository();

  /// ユーザ情報が流れてくるStream
  StreamSubscription<User?>? _userStream;

  /// ログインしているユーザ
  User? _currentUser;

  // 各チュートリアルを終えているかというbool値
  bool? _reExperienceTutorialDone;
  bool? _postTutorialDone;

  // 自分の投稿一覧
  List<Memory> _myMemories = [];

  User? get currentUser => _currentUser;

  bool? get reExperienceTutorialDone => _reExperienceTutorialDone;

  bool? get postTutorialDone => _postTutorialDone;

  List<Memory> get myMemories => _myMemories;

  /// 閲覧のチュートリアルが終了した際の処理
  ///
  /// bool値を変更し、hive(永続化)の処理も呼び出す。
  Future<void> reExperienceTutorialIsFinished() async {
    await _userRepository.reExperienceTutorialIsFinished();
    _reExperienceTutorialDone = true;
    notifyListeners();
  }

  /// 投稿のチュートリアルが終了した際の処理
  ///
  /// bool値を変更し、hive(永続化)の処理も呼び出す。
  void postTutorialIsFinished() async {
    await _userRepository.postTutorialIsFinished();
    _postTutorialDone = true;
    notifyListeners();
  }

  /// 自分の投稿の一覧の取得
  void getMyMemories() async {
    if (_currentUser == null) return;
    _myMemories = await _memoryRepository.getMyMemories(_currentUser!.uid);
    notifyListeners();
  }

  /// 投稿した際に、自分の思い出のリストに追加する。
  void addMyMemories(Memory memory) async {
    _myMemories.add(memory);
    notifyListeners();
  }

  /// ユーザがEmail＆パスワードでの認証をしているユーザかどうかの判定
  bool isEmailUser() {
    if (_currentUser == null) return false;

    // collection パッケージの firstWhereOrNullを使用。ある場合とない場合を区別したかったので。
    final UserInfo? userInfo = _currentUser!.providerData.firstWhereOrNull(
      (UserInfo userInfo) => userInfo.providerId == "password",
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
