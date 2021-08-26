import 'package:flutter/material.dart';

class PostTutorialViewModel with ChangeNotifier {
  PostTutorialViewModel() {
    _notifier = ValueNotifier(0);
  }

  final int pageCount = 2;
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
  ];

  ValueNotifier<double> _notifier;

  ValueNotifier<double> get notifier => _notifier;

  void changeNotifier(double value) {
    _notifier = ValueNotifier(value);
  }
}
