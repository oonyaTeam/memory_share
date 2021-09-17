import 'package:flutter/material.dart';

class UserPageViewModel with ChangeNotifier {
  UserPageViewModel();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;
}
