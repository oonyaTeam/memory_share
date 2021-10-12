import 'package:flutter/material.dart';
import 'package:memory_share/models/models.dart';

class PostPageViewModel with ChangeNotifier {
  PostPageViewModel();

  final PostRepository _postRepository = PostRepository();

  final textFieldFocusNode = FocusNode();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;

  void unfocusTextField() => textFieldFocusNode.unfocus();

  void focusTextField() => textFieldFocusNode.requestFocus();
}
