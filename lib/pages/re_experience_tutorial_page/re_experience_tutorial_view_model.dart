import 'package:flutter/material.dart';

class ReExperienceTutorialViewModel with ChangeNotifier {
  ReExperienceTutorialViewModel() {
    _notifier = ValueNotifier(0);
  }

  final int pageCount = 2;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
  ];
  ValueNotifier<double> _notifier;

  ValueNotifier<double> get notifier => _notifier;

  void changeNotifier(ValueNotifier<double> notifier) {
    _notifier = notifier;
  }
}
