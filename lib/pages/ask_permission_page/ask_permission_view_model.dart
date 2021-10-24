import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class AskPermissionViewModel with ChangeNotifier {
  /// 設定アプリ内の、MemoryShareの設定の項目を開く
  void openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}
