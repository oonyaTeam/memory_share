import 'package:flutter/material.dart';

class SubEpisodeViewModel with ChangeNotifier {
  SubEpisodeViewModel();

  final ScrollController _controller = ScrollController();

  ScrollController get controller => _controller;
}
