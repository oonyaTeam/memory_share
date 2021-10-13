import 'package:flutter/material.dart';

class PostPageViewModel with ChangeNotifier {
  PostPageViewModel();

  final textFieldFocusNode = FocusNode();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;

  void unfocusTextField() => textFieldFocusNode.unfocus();

  void focusTextField() => textFieldFocusNode.requestFocus();
}
