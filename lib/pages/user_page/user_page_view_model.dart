import 'dart:math';

import 'package:flutter/material.dart';

class UserPageViewModel with ChangeNotifier {
  UserPageViewModel() {
    _controller.addListener(() {
      titleStartPadding = min(16 + _controller.offset, 72);

      notifyListeners();
    });
  }

  final ScrollController _controller = ScrollController();
  double titleStartPadding = 16.0;

  ScrollController get controller => _controller;
}
