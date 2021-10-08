import 'package:flutter/material.dart';

class AddSubEpisodeViewModel with ChangeNotifier {
  AddSubEpisodeViewModel();

  final TextEditingController textEditingController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  String _subEpisode = '';

  String get subEpisode => _subEpisode;

  set subEpisode(String str) {
    _subEpisode = str;
    notifyListeners();
  }

  void unfocusTextField() => textFieldFocusNode.unfocus();

  void focusTextField() => textFieldFocusNode.requestFocus();
}
