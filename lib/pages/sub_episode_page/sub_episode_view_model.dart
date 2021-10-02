import 'package:flutter/material.dart';

class SubEpisodeViewModel with ChangeNotifier {
  SubEpisodeViewModel();

  final ScrollController _controller = ScrollController();

  bool _isLoading = false;

  ScrollController get controller => _controller;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
