import 'package:flutter/material.dart';

class PostDetailViewModel with ChangeNotifier {
  PostDetailViewModel();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;
}
