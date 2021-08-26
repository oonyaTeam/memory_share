import 'package:flutter/material.dart';
import 'package:flutter_sliding_tutorial/flutter_sliding_tutorial.dart';

class Tutorial1Page extends StatelessWidget {
  const Tutorial1Page({
    this.page,
    this.notifier,
    Key key,
  }) : super(key: key);

  final int page;
  final ValueNotifier<double> notifier;

  @override
  Widget build(BuildContext context) {
    return SlidingPage(
      notifier: notifier,
      page: page,
      child: Container(),
    );
  }
}
