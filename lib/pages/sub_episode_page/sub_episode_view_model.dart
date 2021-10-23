import 'package:flutter/material.dart';

class SubEpisodeViewModel with ChangeNotifier {
  SubEpisodeViewModel();

  final ScrollController controller = ScrollController();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
