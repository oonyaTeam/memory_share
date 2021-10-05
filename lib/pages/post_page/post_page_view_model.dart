import 'package:flutter/material.dart';

class PostPageViewModel with ChangeNotifier {
  PostPageViewModel();

  final textFieldFocusNode = FocusNode();

  void unfocusTextField() => textFieldFocusNode.unfocus();

  void focusTextField() => textFieldFocusNode.requestFocus();
}
