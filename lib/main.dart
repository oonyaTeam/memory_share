import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:memory_share/models/entities/entities.dart';

import 'app.dart';

void main() async {
  // 環境変数をFlutterプロジェクト内で呼び出すための関数
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  // Hive(永続化)の初期化設定
  await Hive.initFlutter();
  Hive.registerAdapter(UserRecordAdapter());

  // Firebaseの設定
  await Firebase.initializeApp();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9999);

  runApp(
    const MyApp(),
  );
}
