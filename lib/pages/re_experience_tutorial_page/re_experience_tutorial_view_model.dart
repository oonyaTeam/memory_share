import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ReExperienceTutorialViewModel with ChangeNotifier {
  ReExperienceTutorialViewModel() {
    _notifier;
    pageController.addListener(_onScroll);
  }

  final int pageCount = 2;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
  ];

  final PageController pageController = PageController(initialPage: 0);

  final ValueNotifier<double> _notifier = ValueNotifier(0);

  ValueNotifier<double> get notifier => _notifier;

  void changeNotifier(double value) {
    _notifier.value = value;
    notifyListeners();
  }

  void _onScroll() {
    _notifier.value = pageController.page ?? 0;
  }

  /// 位置情報の取得の権限が許可されたら true、拒否されたら false を返す。
  Future<bool> requestPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    switch (permission) {
      case LocationPermission.denied: // 拒否された（default）
        return false;
        break;
      case LocationPermission.deniedForever: // 永遠に拒否された
        return false;
        break;
      case LocationPermission.whileInUse: // アプリを使用してるときのみ許可
        return true;
        break;
      case LocationPermission.always: // いつでも（backgroundでも）許可
        return true;
        break;
      default:
        return false;
    }
  }
}
