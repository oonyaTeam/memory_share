import 'package:flutter/material.dart';

class AddSubEpisodeViewModel with ChangeNotifier {
  AddSubEpisodeViewModel();

  final TextEditingController textEditingController = TextEditingController();
  final textFieldFocusNode = FocusNode();
  String subEpisode = '';

  void unfocusTextField() => textFieldFocusNode.unfocus();

  void focusTextField() => textFieldFocusNode.requestFocus();
}
