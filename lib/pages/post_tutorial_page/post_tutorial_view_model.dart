import 'package:flutter/material.dart';

class PostTutorialViewModel with ChangeNotifier {
  PostTutorialViewModel() {
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
}
