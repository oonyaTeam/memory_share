import 'package:flutter/material.dart';

class AddSubEpisodeViewModel with ChangeNotifier {
  AddSubEpisodeViewModel();

  final TextEditingController _textEditingController = TextEditingController();
  String _subEpisode = '';

  TextEditingController get textEditingController => _textEditingController;

  String get subEpisode => _subEpisode;

  void onChanged(String text) {
    _subEpisode = text;
    notifyListeners();
  }
}
