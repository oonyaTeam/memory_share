import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vibration/vibration.dart';

/// 写真、方角などのコア機能をまとめたService
class CoreService {
  /// 写真を撮影する
  Future<File?> takeImage() async {
    final picker = ImagePicker();
    final XFile? takenImage = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (takenImage == null) return null;

    return File(takenImage.path);
  }

  /// 画面を縦固定にする
  Future<void> setScreenOrientationPortrait() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  /// 画面を横固定にする
  Future<void> setScreenOrientationLandscape() async =>
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

  /// 角度を取得する
  Future<double?> getAngle() async {
    final CompassEvent compassData = await FlutterCompass.events!.first;
    double? angle = compassData.heading;

    if (angle == null) return null;

    if (angle < 0) {
      angle = 360 + angle;
    }
    return angle;
  }

  /// バイブレーションを実行する（1秒間）
  Future<void> viblate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate();
    }
  }
}
